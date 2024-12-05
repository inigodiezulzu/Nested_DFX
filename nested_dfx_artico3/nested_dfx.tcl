###############################################################
###  Minimum settings required to run DFX flow:
###  1. Specify flow steps
###  2. Define target board
###  3. Identify source directories
###  4. Define static module
###  5. Define RPs, and their RM variants
###############################################################
####flow control (1 = run step , 0 = skip step)
set run.topSynth       1 ;#synthesize static
set run.rmSynth        1 ;#synthesize RM variants

# Define the verbose variable
set verbose 1

create_project -in_memory 
set part xczu9eg-ffvb1156-2-e
set_property part xczu9eg-ffvb1156-2-e [current_project]
set_property board_part xilinx.com:zcu102:part0:3.4 [current_project]

set_property "target_language" "VHDL" [current_project]

# Add artico3 repository
set artico3_ip_dir [pwd]/pcores
set_property  ip_repo_paths $artico3_ip_dir [current_project]
update_ip_catalog

###############################################################
### Advanced Settings
###############################################################
# Load utilities
#Define location for "Tcl" directory. Defaults to "./tcl_HD"
if {[file exists "./Tcl_HD"]} { 
   set tclDir  "./Tcl_HD"
} else {
   error "ERROR: No valid location found for required Tcl scripts. Set \$tclDir in design.tcl to a valid location."
}
puts "Setting TCL dir to $tclDir"

####Source required Tcl Procs
source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/hd_utils.tcl
source $tclDir/dfx_utils.tcl

###############################################################
###  Run Settings
###############################################################
####Input Directories
set srcDir     "./Sources"
set rtlDir     "$srcDir/hdl"
set prjDir     "$srcDir/prj"
set xdcDir     "$srcDir/xdc"
set coreDir    "$srcDir/cores"
set netlistDir "$srcDir/netlist"

####Output Directories
set synthDir  "./Synth"
set implDir   "./Implement"
set dcpDir    "./Checkpoint"
set bitDir    "./Bitstreams"

###############################################################
### Static Module Definition
###############################################################
set top "system"

###############################################################
### RP & RM Definitions (Repeat for each RP)
### 1. Define Reconfigurable Partition (RP) name
### 2. Associate Reconfigurable Modules (RMs) to the RP
###############################################################
set rp1 "a3_slot"
set rm_variants($rp1) "a3_matmul a3_dummy"
set rp2 "reconfig_inst"
set rm_variants($rp2) "dfx_artico3_base"

# Create system block
source ./system.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse .gen/sources_1/bd/system/hdl/system_wrapper.vhd
set_property top system_wrapper [current_fileset]

source ./a3_matmul.tcl
make_wrapper -files [get_files .srcs/sources_1/bd/a3_matmul/a3_matmul.bd] -top
add_files -norecurse .gen/sources_1/bd/a3_matmul/hdl/a3_matmul_wrapper.vhd

source ./a3_dummy.tcl
make_wrapper -files [get_files .srcs/sources_1/bd/a3_dummy/a3_dummy.bd] -top
add_files -norecurse .gen/sources_1/bd/a3_dummy/hdl/a3_dummy_wrapper.vhd

# Create dfx_artico3_base block
source ./dfx_artico3_base.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/dfx_artico3_base/dfx_artico3_base.bd] -top
add_files -norecurse .gen/sources_1/bd/dfx_artico3_base/hdl/dfx_artico3_base_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


# ============================================
# 1. Static Design
# ============================================

# Create the static module
set static "Static"
add_module $static
set_attribute module $static moduleName $top
set_attribute module $static top_level 1
set_attribute module $static vhdl [list .gen/sources_1/bd/system/hdl/system_wrapper.vhd]
set_attribute module $static synth         ${run.topSynth}

# ============================================
# 2. Configure Reconfigurable Partitions
# ============================================

foreach rp [array names rm_variants] {
  foreach rm $rm_variants($rp) {
    set variant $rm
    add_module $variant
    set_attribute module $variant moduleName   $rp
    set_attribute module $variant vhdl         [list .gen/sources_1/bd/$variant/hdl/*_wrapper.vhd]
    set_attribute module $variant synth        ${run.rmSynth}
  }
}

########################################################################
### Configuration (Implementation) Definition 
########################################################################
foreach cfg_name [array names rm_config] {
  if {$cfg_name=="initial"} {set state "implement"} else {set state "import"}
    
  set config "Config"
  set partition_list [list [list $static $top $state]]

  foreach {rp rm_variant} $rm_config($cfg_name) {
    set module_inst inst_${rp}
    set config "${config}_${rm_variant}"
    set partition [list $rm_variant $module_inst implement]
    lappend partition_list $partition
  }
 set config "${config}_${state}"
  
  add_implementation $config
  set_attribute impl $config top             $top
  set_attribute impl $config implXDC         [list $xdcDir/${top}_zcu102.xdc]

  set_attribute impl $config partitions      $partition_list
  set_attribute impl $config dfx.impl         1 
  set_attribute impl $config impl            ${run.dfxImpl} 
  set_attribute impl $config verify     	    ${run.prVerify} 
  set_attribute impl $config bitstream  	    ${run.writeBitstream} 
  #set_attribute impl $config bitstream_settings [list <options_go_here>]
}
# ============================================
# 5. Synthesis and Implementation
# ============================================
#source $tclDir/run.tcl


set resultDir "$synthDir/Static"


# Synthesis of the static design
synth_design -mode default -flatten_hierarchy rebuilt -top system_wrapper -part xczu9eg-ffvb1156-2-e > $resultDir/Static_synth_design.rds
write_checkpoint -force $resultDir/Static_synth.dcp > $resultDir/write_checkpoint.log



