//////////////////////////////////////////////////////////////////////////////
// © Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
// This file contains confidential and proprietary information of 
// Advanced Micro Devices, Inc. and is protected under U.S. and 
// international copyright and other intellectual property laws. 
//////////////////////////////////////////////////////////////////////////////
// Vendor: AMD 
// Version: 2022.1
// Application: Dynamic Function eXchange tutorial
// Filename: reconfig_shifters.v
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

   reg [34:0]  count;
   wire [3:0]  shift_out_upper;
   wire [3:0]  shift_out_lower;

// instantiate module shift, upper bits
   shift inst_shift_upper (
      .en       (rst),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (shift_out_upper) 
   );
   
// instantiate module shift, lower bits
   shift inst_shift_lower (
      .en       (rst),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (shift_out_lower) 
   );
   
      // MAIN

   always @(posedge gclk)
     if (rst)
       begin
         count <= 0;
       end
     else
       begin
         count <= count + 1;
       end
       
   always @(posedge gclk)
     if (rst)
       begin
         upper <= 4'b0000;
         lower <= 4'b0000;
       end
     else
       begin
         upper <= shift_out_upper;
         lower <= shift_out_lower;
       end
       
endmodule


// black box definition for module_shift
module shift(
   input         en,
   input         clk,
   input  [11:0] addr,
   output  [3:0] data_out);
endmodule