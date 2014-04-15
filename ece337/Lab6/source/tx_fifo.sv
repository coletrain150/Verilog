// $Id: $
// File name:   tx_fifo.sv
// Created:     3/7/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: fifo module


module tx_fifo
(
    input wire clk,
    input wire read_enable,
    input wire n_rst,
    input wire write_enable,
    input reg [7:0] write_data,
    output reg [7:0] read_data,
    output wire fifo_empty,
    output wire fifo_full
);

fifo DUT (.r_clk(clk),
          .w_clk(clk),
          .n_rst(n_rst),
          .r_enable(read_enable),
          .w_enable(write_enable),
          .w_data(write_data),
          .r_data(read_data),
          .empty(fifo_empty),
          .full(fifo_full)
          );


endmodule