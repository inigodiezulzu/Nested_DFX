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
#// Filename: pblocks_counters_vcu108.xdc
#// Date Last Modified: 14 FEB 2022
#//
#// Board:  VCU108
#// Device: xcvu095
#// Design Name: led_shift_count_nested
#// Purpose: Dynamic Function eXchange Tutorial
#/////////////////////////////////////////////////////////////////////////////
####################################################################################

#-------------------------------------------------
# pblock_inst_count_upper
#            for pr instance inst_count_upper
#-------------------------------------------------
create_pblock pblock_inst_count_upper
add_cells_to_pblock [get_pblocks pblock_inst_count_upper] [get_cells -quiet [list inst_RP/inst_count_upper]]
resize_pblock [get_pblocks pblock_inst_count_upper] -add {SLICE_X32Y125:SLICE_X47Y164}
resize_pblock [get_pblocks pblock_inst_count_upper] -add {RAMB18_X4Y50:RAMB18_X5Y65}
resize_pblock [get_pblocks pblock_inst_count_upper] -add {RAMB36_X4Y25:RAMB36_X5Y32}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_count_upper]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_count_upper]

#-------------------------------------------------
# pblock_inst_count_lower
#            for pr instance inst_count_lower
#-------------------------------------------------
create_pblock pblock_inst_count_lower
add_cells_to_pblock [get_pblocks pblock_inst_count_lower] [get_cells -quiet [list inst_RP/inst_count_lower]]
resize_pblock [get_pblocks pblock_inst_count_lower] -add {SLICE_X32Y75:SLICE_X47Y114}
resize_pblock [get_pblocks pblock_inst_count_lower] -add {RAMB18_X4Y30:RAMB18_X5Y45}
resize_pblock [get_pblocks pblock_inst_count_lower] -add {RAMB36_X4Y15:RAMB36_X5Y22}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_count_lower]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_count_lower]

