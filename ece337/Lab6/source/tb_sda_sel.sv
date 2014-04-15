// $Id: $
// File name:   tb_sda_sel.sv
// Created:     3/10/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: test bench for sda select
`timescale 1ns / 100ps
module tb_sda_sel
  ();

   reg tb_tx_out;
   reg [1:0] tb_sda_mode;
   reg tb_sda_out;

    sda_sel DUT(.tx_out(tb_tx_out), .sda_mode(tb_sda_mode), .sda_out(tb_sda_out));


initial
  begin

    tb_tx_out = 1;
    #10

    tb_sda_mode = 2'b00;
    #10
    tb_sda_mode = 2'b01;
    #10
    tb_sda_mode = 2'b10;
    #10
    tb_sda_mode = 2'b11;
    #10
    tb_tx_out = 0;
    tb_sda_mode = 2'b00;
    #10
    tb_sda_mode = 2'b01;
    #10
    tb_sda_mode = 2'b10;
    #10
    tb_sda_mode = 2'b11;
end
endmodule
