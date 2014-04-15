// $Id: $
// File name:   tb_scl_edge.sv
// Created:     3/10/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: test bench for scl edge decector
`timescale 1ns / 100ps
module tb_scl_edge
  ();

   localparam   CLK_PERIOD  = 2.5;
    reg tb_clk;
    reg tb_n_rst;
    reg tb_scl;
    reg tb_rising_edge_found;
    reg tb_falling_edge_found;


    scl_edge DUT(.clk(tb_clk), .n_rst(tb_n_rst), .scl(tb_scl), .rising_edge_found(tb_rising_edge_found), .falling_edge_found(tb_falling_edge_found));



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
     tb_scl = 0;
     @(negedge tb_clk);
     tb_scl = 1;
     @(negedge tb_clk);
     tb_scl = 0;
    end
endmodule
