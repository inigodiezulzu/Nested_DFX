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
#// Filename: pblock_top_vcu108.xdc
#// Date Last Modified: 14 FEB 2022
#//
#// Board:  VCU108
#// Device: xcvu095
#// Design Name: led_shift_count_nested
#// Purpose: Dynamic Function eXchange Tutorial
#/////////////////////////////////////////////////////////////////////////////
####################################################################################

#-------------------------------------------------
# pblock_inst_RP
#            for pr instance inst_RP
#-------------------------------------------------

create_pblock pblock_inst_RP
add_cells_to_pblock [get_pblocks pblock_inst_RP] [get_cells -quiet [list inst_RP]]
resize_pblock [get_pblocks pblock_inst_RP] -add {SLICE_X32Y60:SLICE_X51Y179}
resize_pblock [get_pblocks pblock_inst_RP] -add {RAMB18_X4Y24:RAMB18_X5Y71}
resize_pblock [get_pblocks pblock_inst_RP] -add {RAMB36_X4Y12:RAMB36_X5Y35}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_RP]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_RP]
