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
#// Filename: top_io_vcu118.xdc
#// Date Last Modified: 14 FEB 2022
#//
#// Board:  VCU118
#// Device: xcvu9p
#// Design Name: led_shift_count_nested
#// Purpose: Dynamic Function eXchange Tutorial
#/////////////////////////////////////////////////////////////////////////////
####################################################################################

###############################################################################
# Configuration properties for VCU118 
###############################################################################
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]


#CLK_125MHZ_P 
set_property PACKAGE_PIN AY24 [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_p]

#CLK_125MHZ_N 
set_property PACKAGE_PIN AY23 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports clk_n]


#GPIO_SW_C (SW7) 
set_property PACKAGE_PIN BD23 [get_ports rst_n]
set_property IOSTANDARD LVCMOS12 [get_ports rst_n]


#GPIO_LED_0 
set_property PACKAGE_PIN AT32 [get_ports {lower_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {lower_out[3]}]

#GPIO_LED_1 
set_property PACKAGE_PIN AV34 [get_ports {lower_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {lower_out[2]}]

#GPIO_LED_2 
set_property PACKAGE_PIN AY30 [get_ports {lower_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {lower_out[1]}]

#GPIO_LED_3 
set_property PACKAGE_PIN BB32 [get_ports {lower_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {lower_out[0]}]

#GPIO_LED_4 
set_property PACKAGE_PIN BF32 [get_ports {upper_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {upper_out[3]}]
                                          
#GPIO_LED_5      
set_property PACKAGE_PIN AU37 [get_ports {upper_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {upper_out[2]}]
                                          
#GPIO_LED_6      
set_property PACKAGE_PIN AV36 [get_ports {upper_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {upper_out[1]}]
                                          
#GPIO_LED_7     
set_property PACKAGE_PIN BA37 [get_ports {upper_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {upper_out[0]}]
