// $Id: $
// File name:   tb_mealy.sv
// Created:     2/17/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: mealy test bench

`timescale 1ns / 100ps
module tb_mealy
  ();

   localparam	CLK_PERIOD	= 2.5;
   reg tb_clk;   
   reg tb_n_rst;
   reg tb_i;
   reg tb_o;


   	mealy DUT(.clk(tb_clk), .n_rst(tb_n_rst), .i(tb_i), .o(tb_o));



   	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

   initial
  begin
     tb_n_rst = 0;
	
     @(negedge tb_clk);
     tb_n_rst = 1;
     @(negedge tb_clk);
     tb_i = 1;
     @(negedge tb_clk);
     tb_i = 1;
     @(negedge tb_clk);
     tb_i = 0;
     @(negedge tb_clk);
     tb_i = 1;
     @(negedge tb_clk);
     tb_i = 1;
     @(negedge tb_clk);
     tb_i = 0;
     @(negedge tb_clk);
     tb_i = 1;
     @(negedge tb_clk);
     tb_i = 1;
	
	      
  end // initial begin
   
endmodule // tb_moore
