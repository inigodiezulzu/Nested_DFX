####################################################################################
#//////////////////////////////////////////////////////////////////////////////
#// © Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
#// This file contains confidential and proprietary information of 
#// Advanced Micro Devices, Inc. and is protected under U.S. and 
#// international copyright and other intellectual property laws. 
#//////////////////////////////////////////////////////////////////////////////
#// Vendor: AMD 
#// Version: 2022.1
#// Application: Dynamic Function eXchange tutorial
#// Filename: pblocks_shifters_vcu118.xdc
#// Date Last Modified: 14 FEB 2022
#//
#// Board:  VCU118
#// Device: xcvu9p
#// Design Name: led_shift_count_nested
#// Purpose: Dynamic Function eXchange Tutorial
#/////////////////////////////////////////////////////////////////////////////
####################################################################################

#-------------------------------------------------
# pblock_inst_shift_upper
#            for pr instance inst_shift_upper
#-------------------------------------------------
create_pblock pblock_inst_shift_upper
add_cells_to_pblock [get_pblocks pblock_inst_shift_upper] [get_cells -quiet [list inst_RP/inst_shift_upper]]
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {SLICE_X76Y190:SLICE_X83Y219}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {DSP48E2_X9Y76:DSP48E2_X9Y87}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB18_X5Y76:RAMB18_X5Y87}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB36_X5Y38:RAMB36_X5Y43}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_upper]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_upper]

#-------------------------------------------------
# pblock_inst_shift_lower
#            for pr instance inst_shift_lower
#-------------------------------------------------
create_pblock pblock_inst_shift_lower
add_cells_to_pblock [get_pblocks pblock_inst_shift_lower] [get_cells -quiet [list inst_RP/inst_shift_lower]]
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {SLICE_X76Y140:SLICE_X83Y169}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {DSP48E2_X9Y56:DSP48E2_X9Y67}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB18_X5Y56:RAMB18_X5Y67}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB36_X5Y28:RAMB36_X5Y33}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_lower]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_lower]



