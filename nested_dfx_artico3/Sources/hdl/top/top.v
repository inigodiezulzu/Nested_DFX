//////////////////////////////////////////////////////////////////////////////
// © Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
// This file contains confidential and proprietary information of 
// Advanced Micro Devices, Inc. and is protected under U.S. and 
// international copyright and other intellectual property laws. 
//////////////////////////////////////////////////////////////////////////////
// Vendor: AMD 
// Version: 2022.1
// Application: Dynamic Function eXchange tutorial
// Filename: top.v
// Date Last Modified: 14 FEB 2022
//
// Board:  KCU105, VCU108, KCU116, VCU118
// Device: xcku040, xcvu095, xcku5p, xcvu9p
// Design Name: led_shift_count_nested
// Purpose: Dynamic Function eXchange Tutorial
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
//  Top-level, static design
//////////////////////////////////////////////////////////////////////////////

module top(
   input            clk_p,       // 200MHz differential input clock
   input            clk_n,       // 200MHz differential input clock
   input            rst_n,       // Reset mapped to center push button
   output reg [3:0] upper_out,   // mapped to general purpose LEDs[4-7]
   output reg [3:0] lower_out    // mapped to general purpose LEDs[0-3]
);

   wire        rst;
   wire        gclk;
   wire [3:0]  upper;
   wire [3:0]  lower;
   
   assign rst = rst_n;

   // instantiate clock module to divide 200MHz to 100MHz
   clocks U0_clocks (
      .clk_p(clk_p),
      .clk_n(clk_n),
      .rst(rst),
      .clk_out(gclk)
   );
 
   // instantiate top-level reconfigurable partition
   reconfig_inst inst_RP (
      .rst       (rst),
      .gclk       (gclk),
      .upper     (upper),
      .lower     (lower)
   );
   
   always @(posedge gclk)
     if (rst)
       begin
         upper_out <= 4'b0;
         lower_out <= 4'b0;
       end
     else
       begin
         upper_out <= upper;
         lower_out <= lower;
       end

endmodule



// black box definition for reconfig_inst
module reconfig_inst(
   input rst,
   input gclk,
   output [3:0] upper,
   output [3:0] lower
   );
endmodule