
################################################################
# This is a generated script based on design: dfx_artico3_base
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source dfx_artico3_base_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name dfx_artico3_base

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
cei.upm.es:artico3:artico3_shuffler:1.0\
cei.upm.es:artico3:a3_dummy:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set S_AXI_LITE [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S_AXI_LITE

  set S_AXI_MM [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_MM ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {1} \
   CONFIG.AWUSER_WIDTH {1} \
   CONFIG.BUSER_WIDTH {1} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {12} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {1} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {1} \
   ] $S_AXI_MM


  # Create ports
  set s_axi_aclk_0 [ create_bd_port -dir I -type clk s_axi_aclk_0 ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S_AXI_LITE:S_AXI_MM} \
 ] $s_axi_aclk_0
  set s_axi_aresetn_0 [ create_bd_port -dir I -type rst s_axi_aresetn_0 ]
  set interrupt_0 [ create_bd_port -dir O -type intr interrupt_0 ]

  # Create instance: artico3_shuffler_0, and set properties
  set artico3_shuffler_0 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:artico3_shuffler:1.0 artico3_shuffler_0 ]
  set_property CONFIG.C_S_AXI_ID_WIDTH {12} $artico3_shuffler_0


  # Create instance: a3_slot_0, and set properties
  set a3_slot_0 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_0 ]

  # Create instance: a3_slot_1, and set properties
  set a3_slot_1 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_1 ]

  # Create instance: a3_slot_2, and set properties
  set a3_slot_2 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_2 ]

  # Create instance: a3_slot_3, and set properties
  set a3_slot_3 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_3 ]

  # Create instance: a3_slot_4, and set properties
  set a3_slot_4 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_4 ]

  # Create instance: a3_slot_5, and set properties
  set a3_slot_5 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_5 ]

  # Create instance: a3_slot_6, and set properties
  set a3_slot_6 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_6 ]

  # Create instance: a3_slot_7, and set properties
  set a3_slot_7 [ create_bd_cell -type ip -vlnv cei.upm.es:artico3:a3_dummy:1.0 a3_slot_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net artico3_slot0 [get_bd_intf_pins artico3_shuffler_0/m0_artico3] [get_bd_intf_pins a3_slot_0/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot1 [get_bd_intf_pins artico3_shuffler_0/m1_artico3] [get_bd_intf_pins a3_slot_1/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot2 [get_bd_intf_pins artico3_shuffler_0/m2_artico3] [get_bd_intf_pins a3_slot_2/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot3 [get_bd_intf_pins artico3_shuffler_0/m3_artico3] [get_bd_intf_pins a3_slot_3/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot4 [get_bd_intf_pins artico3_shuffler_0/m4_artico3] [get_bd_intf_pins a3_slot_4/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot5 [get_bd_intf_pins artico3_shuffler_0/m5_artico3] [get_bd_intf_pins a3_slot_5/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot6 [get_bd_intf_pins artico3_shuffler_0/m6_artico3] [get_bd_intf_pins a3_slot_6/s_artico3]
  connect_bd_intf_net -intf_net artico3_slot7 [get_bd_intf_pins artico3_shuffler_0/m7_artico3] [get_bd_intf_pins a3_slot_7/s_artico3]
  connect_bd_intf_net -intf_net s00_axi_0_1 [get_bd_intf_ports S_AXI_LITE] [get_bd_intf_pins artico3_shuffler_0/s00_axi]
  connect_bd_intf_net -intf_net s01_axi_0_1 [get_bd_intf_ports S_AXI_MM] [get_bd_intf_pins artico3_shuffler_0/s01_axi]

  # Create port connections
  connect_bd_net -net artico3_shuffler_0_interrupt  [get_bd_pins artico3_shuffler_0/interrupt] \
  [get_bd_ports interrupt_0]
  connect_bd_net -net s_axi_aclk_0_1  [get_bd_ports s_axi_aclk_0] \
  [get_bd_pins artico3_shuffler_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_0_1  [get_bd_ports s_axi_aresetn_0] \
  [get_bd_pins artico3_shuffler_0/s_axi_aresetn]

  # Create address segments
  assign_bd_address -offset 0xA0000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces S_AXI_LITE] [get_bd_addr_segs artico3_shuffler_0/s00_axi/reg0] -force
  assign_bd_address -offset 0xB0000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces S_AXI_MM] [get_bd_addr_segs artico3_shuffler_0/s01_axi/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


