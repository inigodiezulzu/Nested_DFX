//////////////////////////////////////////////////////////////////////////////
// © Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
// This file contains confidential and proprietary information of 
// Advanced Micro Devices, Inc. and is protected under U.S. and 
// international copyright and other intellectual property laws. 
//////////////////////////////////////////////////////////////////////////////
// Vendor: AMD 
// Version: 2022.1
// Application: Dynamic Function eXchange tutorial
// Filename: reconfig_counters.v
// Date Last Modified: 14 FEB 2022
//
// Board:  KCU105, VCU108, KCU116, VCU118
// Device: xcku040, xcvu095, xcku5p, xcvu9p
// Design Name: led_shift_count_nested
// Purpose: Dynamic Function eXchange Tutorial
//////////////////////////////////////////////////////////////////////////////

module reconfig_inst(
    input             rst,
    input             gclk,
    output reg [3:0]  upper,
    output reg [3:0]  lower
    );
    
wire [3:0] count_out_upper;
wire [3:0] count_out_lower;
    
   // instantiate module count, upper bits
   count inst_count_upper (
      .rst       (rst),
      .clk       (gclk),
      .count_out (count_out_upper)
   );

   // instantiate module count, lower bits
   count inst_count_lower (
      .rst       (rst),
      .clk       (gclk),
      .count_out (count_out_lower)
   );
   
   always @(posedge gclk)
     if (rst)
       begin
         upper <= 4'b0000;
         lower <= 4'b0000;
       end
     else
       begin
         upper <= count_out_upper;
         lower <= count_out_lower;
       end

endmodule


// black box definition for module_count
module count(
   input        rst,
   input        clk,
   output [3:0] count_out);
endmodule