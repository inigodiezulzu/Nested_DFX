###############################################################################
# Configuration properties for ZCU108 
###############################################################################
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]


#CLK_125MHZ_P 
set_property PACKAGE_PIN AL8 [get_ports clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_p]

#CLK_125MHZ_N 
set_property PACKAGE_PIN AL7 [get_ports clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_n]


#GPIO_SW_C (SW7) 
set_property PACKAGE_PIN AG13 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


#GPIO_LED_0 
set_property PACKAGE_PIN AG14 [get_ports {lower_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lower_out[3]}]

#GPIO_LED_1 
set_property PACKAGE_PIN AF13 [get_ports {lower_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lower_out[2]}]

#GPIO_LED_2 
set_property PACKAGE_PIN AE13 [get_ports {lower_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lower_out[1]}]

#GPIO_LED_3 
set_property PACKAGE_PIN AJ14 [get_ports {lower_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lower_out[0]}]

#GPIO_LED_4 
set_property PACKAGE_PIN AJ15 [get_ports {upper_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {upper_out[3]}]
                                          
#GPIO_LED_5      
set_property PACKAGE_PIN AH13 [get_ports {upper_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {upper_out[2]}]
                                          
#GPIO_LED_6      
set_property PACKAGE_PIN AH14 [get_ports {upper_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {upper_out[1]}]
                                          
#GPIO_LED_7     
set_property PACKAGE_PIN AL12 [get_ports {upper_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {upper_out[0]}]


