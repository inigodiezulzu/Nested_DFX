
create_project -in_memory 
set_property part xczu9eg-ffvb1156-2-e [current_project]
set_property board_part xilinx.com:zcu102:part0:3.4 [current_project]

# Save directory and project names to variables for easy reuse
set proj_name [current_project]
set proj_dir [get_property directory [current_project]]

set_property "target_language" "VHDL" $proj_name

# Add artico3 repository
set artico3_ip_dir [pwd]/pcores
set_property  ip_repo_paths $artico3_ip_dir [current_project]
update_ip_catalog

set_property source_mgmt_mode All [current_project]

# Create a3_dummy block
source ./a3_dummy.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/a3_dummy/a3_dummy.bd] -top
add_files -norecurse .gen/sources_1/bd/a3_dummy/hdl/a3_dummy_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
close_bd_design [get_bd_designs a3_dummy]

# Create a3_matmul block
source ./a3_matmul.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/a3_matmul/a3_matmul.bd] -top
add_files -norecurse .gen/sources_1/bd/a3_matmul/hdl/a3_matmul_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
close_bd_design [get_bd_designs a3_matmul]

# Create dfx_artico3_base block
source ./dfx_artico3_base.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/dfx_artico3_base/dfx_artico3_base.bd] -top
add_files -norecurse .gen/sources_1/bd/dfx_artico3_base/hdl/dfx_artico3_base_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
close_bd_design [get_bd_designs dfx_artico3_base]

#add_files .srcs/sources_1/bd/dfx_artico3_base/dfx_artico3_base.bd

# Create system block
source ./system.tcl
#make wrapper file; vivado needs it to implement design
make_wrapper -files [get_files .srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse .gen/sources_1/bd/system/hdl/system_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
set_property top system_wrapper [current_fileset]
save_bd_design
close_bd_design [get_bd_designs system]

