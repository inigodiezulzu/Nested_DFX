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
#// Filename: pblocks_shifters_kcu105.xdc
#// Date Last Modified: 14 FEB 2022
#//
#// Board:  KCU105
#// Device: xcku040
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
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {SLICE_X34Y195:SLICE_X42Y219}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {DSP48E2_X5Y78:DSP48E2_X6Y87}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB18_X4Y78:RAMB18_X4Y87}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB36_X4Y39:RAMB36_X4Y43}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_upper]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_upper]

#-------------------------------------------------
# pblock_inst_shift_lower
#            for pr instance inst_shift_lower
#-------------------------------------------------
create_pblock pblock_inst_shift_lower
add_cells_to_pblock [get_pblocks pblock_inst_shift_lower] [get_cells -quiet [list inst_RP/inst_shift_lower]]
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {SLICE_X34Y145:SLICE_X42Y169}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {DSP48E2_X5Y58:DSP48E2_X6Y67}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB18_X4Y58:RAMB18_X4Y67}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB36_X4Y29:RAMB36_X4Y33}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_lower]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_lower]


