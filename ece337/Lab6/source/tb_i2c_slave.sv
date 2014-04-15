// $Id: $
// File name:   tb_i2c_slave.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: test bench for i2c
`timescale 1ns / 100ps
module tb_i2c_slave
  ();

    localparam   CLK_PERIOD  = 10;
    localparam   SCL_PERIOD  = 300;
    reg tb_clk;
    reg tb_n_rst;
    reg tb_scl;
    reg tb_sda_in;
    reg tb_sda_out;
    reg tb_write_enable;
    reg [7:0] tb_write_data;
    reg tb_fifo_full;
    reg tb_fifo_empty;


    i2c_slave DUT(
                .clk(tb_clk),
                .n_rst(tb_n_rst),
                .scl(tb_scl),
                .sda_in(tb_sda_in),
                .sda_out(tb_sda_out),
                .write_enable(tb_write_enable),
                .write_data(tb_write_data),
                .fifo_empty(tb_fifo_empty),
                .fifo_full(tb_fifo_full)
                );



    always
    begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end

    always
    begin
        tb_scl = 1'b0;
        #(SCL_PERIOD*2.0/3.0)
        tb_scl = 1'b1;
        #(SCL_PERIOD/3.0);
    end

initial
  begin

     tb_n_rst = 0;
     @(negedge tb_clk);
     tb_n_rst = 1;
     @(negedge tb_clk);
     tb_write_data = 7'b11110000;
     @(negedge tb_clk);
     tb_write_enable = 1'b1;
     @(negedge tb_clk);
     tb_write_enable = 1'b0;
     @(posedge tb_scl);
     tb_sda_in = 1'b1;
     #50
     tb_sda_in = 1'b0;
    end

endmodule


