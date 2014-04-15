// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: flex counter test bench

`timescale 1ns / 100ps
module tb_flex_counter
  ();
	localparam	CLK_PERIOD	= 2.5;
   reg tb_clk;

   reg tb_clear;

   reg tb_n_rst;

   reg tb_count_enable;

   reg [3:0] tb_rollover_val;

   reg [3:0] tb_count_out;

   reg tb_rollover_flag;




   	flex_counter DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .count_enable(tb_count_enable), .rollover_val(tb_rollover_val), .count_out(tb_count_out), .rollover_flag(tb_rollover_flag));


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

	  #10
	    tb_n_rst = 1;
	tb_clear = 0;


	#10
	tb_rollover_val = 4'b0110;
	tb_count_enable = 1;
	#10
	if(tb_count_out == 4'b0110) begin
	   if(tb_rollover_flag == 1)
	     begin
		$info("Correct value for test case");
	     end
	   else begin
	      $info("Correct value for test case");
	   end
	end


     end // initial begin

endmodule // tb_flex_counter
