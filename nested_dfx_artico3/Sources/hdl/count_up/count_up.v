//////////////////////////////////////////////////////////////////////////////
// © Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
// This file contains confidential and proprietary information of 
// Advanced Micro Devices, Inc. and is protected under U.S. and 
// international copyright and other intellectual property laws. 
//////////////////////////////////////////////////////////////////////////////
// Vendor: AMD 
// Version: 2022.1
// Application: Dynamic Function eXchange tutorial
// Filename: count_up.v
// Date Last Modified: 14 FEB 2022
//
// Board:  KCU105, VCU108, KCU116, VCU118
// Device: xcku040, xcvu095, xcku5p, xcvu9p
// Design Name: led_shift_count_nested
// Purpose: Dynamic Function eXchange Tutorial
//////////////////////////////////////////////////////////////////////////////

// Reconfigurable Module: module_count
// Binary count up visable on 4 LEDs

module count (
   rst,
   clk,
   count_out
);

   input rst;                // Active high reset
   input clk;                // 200MHz input clock
   output [3:0] count_out;   // Output to LEDs

   reg [24:0] count;
   reg [3:0]  count_out;

   //Counter to reduce speed of output
   always @(posedge clk)
      if (rst) begin
         count <= 0;
      end
      else begin
         count <= count + 1;
      end

    always @(posedge clk)
      if (rst)
         count_out <= 4'b0000;
      else begin
         if (count == 25'b1111111111111111111111111) begin
            count_out <= count_out + 1;
         end
      end
endmodule
