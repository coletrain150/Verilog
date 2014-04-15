// $Id: $
// File name:   tb_tx_fifo.sv
// Created:     3/10/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: test bench for tx fifo
`timescale 1ns / 100ps
module tb_tx_fifo
  ();

   localparam   CLK_PERIOD  = 2.5;
    reg tb_clk;
    reg tb_read_enable;
    reg tb_n_rst;
    reg tb_write_enable;
    reg [7:0] tb_write_data;
    reg [7:0] tb_read_data;
    reg tb_fifo_empty;
    reg tb_fifo_full;

    tx_fifo DUT(.clk(tb_clk),
                .n_rst(tb_n_rst),
                .read_enable(tb_read_enable),
                .write_enable(tb_write_enable),
                .fifo_empty(tb_fifo_empty),
                .fifo_full(tb_fifo_full),
                .write_data(tb_write_data),
                .read_data(tb_read_data)
                );



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
    tb_read_enable = 0;
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_n_rst = 1;
    @(negedge tb_clk);
    tb_write_data = 7'b1001000;
    @(negedge tb_clk);
    tb_n_rst = 1;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_data = 7'b1101000;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1011000;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1001100;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1001010;
    tb_read_enable = 1;
    @(negedge tb_clk);
    tb_read_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1011000;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1001100;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1011000;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_data = 7'b1001100;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
    @(negedge tb_clk);
    tb_write_enable = 1;
    @(negedge tb_clk);
    tb_write_enable = 0;
end
endmodule
