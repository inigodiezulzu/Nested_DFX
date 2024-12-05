#
# Copyright (C) 2024, Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: X11
#

source ./design_settings.tcl
set loc "./Implement/top_static"

file mkdir ./Implement
file delete -force $loc
file mkdir $loc
file mkdir $loc/reports
puts "#HD: Running implementation top_static"
create_project -in_memory -part $part > $loc/create_project.log
add_files ./Synth/Static/top_synth.dcp
#add_files ./Sources/xdc/top_io_$xboard.xdc
#set_property USED_IN {implementation} [get_files ./Sources/xdc/top_io_$xboard.xdc]
add_files ./Sources/xdc/pblock_top_artico3.xdc
set_property USED_IN {implementation} [get_files ./Sources/xdc/pblock_top_artico3.xdc]
add_file ./Synth/artico3/reconfig_inst_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP} [get_files ./Synth/artico3/reconfig_inst_synth.dcp]
add_file ./Synth/artico3/a3_slot_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP/a3_slot_0 inst_RP/a3_slot_1 inst_RP/a3_slot_2 inst_RP/a3_slot_3 inst_RP/a3_slot_4 inst_RP/a3_slot_5 inst_RP/a3_slot_6 inst_RP/a3_slot_7 } [get_files ./Synth/artico3/slot_synth.dcp]
link_design -mode default -reconfig_partitions {inst_RP} -part $part -top top > $loc/top_link_design.log
write_checkpoint -force $loc/top_link_design.dcp > $loc/write_checkpoint.log

opt_design > $loc/top_opt_design.log
puts "	#HD: Completed: opt_design"
write_checkpoint -force $loc/top_opt_design.dcp > $loc/write_checkpoint.log
place_design > $loc/top_place_design.log
puts "	#HD: Completed: place_design"
write_checkpoint -force $loc/top_place_design.dcp > $loc/write_checkpoint.log
phys_opt_design > $loc/top_phys_opt_design.log
puts "	#HD: Completed: phys_opt_design"
write_checkpoint -force $loc/top_phys_opt_design.dcp > $loc/write_checkpoint.log
route_design > $loc/top_route_design.log
puts "	#HD: Completed: route_design"
write_checkpoint -force $loc/top_route_design.dcp > $loc/write_checkpoint.log
report_utilization -file $loc/reports/top_utilization_route_design.rpt > $loc/temp.log
report_route_status -file $loc/reports/top_route_status.rpt > $loc/temp.log
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $loc/reports/top_timing_summary.rpt > $loc/temp.log
debug::report_design_status > $loc/reports/top_design_status.rpt
report_drc -ruledeck bitstream_checks -name top -file $loc/reports/top_drc_bitstream_checks.rpt > $loc/reports/temp.log
puts "	#HD: Completed"
close_project
