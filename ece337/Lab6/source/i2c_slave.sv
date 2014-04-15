// $Id: $
// File name:   i2c_slave.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: top level i2c slave


module i2c_slave
(
    input wire clk,
    input wire n_rst,
    input wire scl,
    input wire sda_in,
    input wire write_enable,
    input reg [7:0] write_data,
    output wire sda_out,
    output wire fifo_empty,
    output wire fifo_full
);
reg s_sda_in, s_scl;
reg rising_edge_found, falling_edge_found;
reg tx_out;
reg [1:0] sda_mode;
reg [7:0] rx_data;
//reg [7:0] tx_data;
reg [7:0] read_data;
reg rw_mode, address_match, stop_found, start_found;
reg rx_enable;
reg tx_enable, load_data;
reg read_enable;
reg ack_prep, ack_done, check_ack, byte_received;


sync U9(
        .clk(clk),
        .n_reset(n_rst),
        .async_in(scl),
        .sync_out(s_scl)
       );

sync U10(
        .clk(clk),
        .n_reset(n_rst),
        .async_in(sda_in),
        .sync_out(s_sda_in)
        );

scl_edge U1(
            .clk(clk),
            .n_rst(n_rst),
            .scl(s_scl),
            .rising_edge_found(rising_edge_found),
            .falling_edge_found(falling_edge_found)
           );

sda_sel U2(
           .tx_out(tx_out),
           .sda_mode(sda_mode),
           .sda_out(sda_out)
          );

decode U3(
           .clk(clk),
           .n_rst(n_rst),
           .scl(s_scl),
           .sda_in(s_sda_in),
           .starting_byte(rx_data),
           .rw_mode(rw_mode),
           .address_match(address_match),
           .stop_found(stop_found),
           .start_found(start_found)
         );

rx_sr U4(
         .clk(clk),
         .n_rst(n_rst),
         .sda_in(s_sda_in),
         .rising_edge_found(rising_edge_found),
         .rx_enable(rx_enable),
         .rx_data(rx_data)
        );

tx_sr U5(
         .clk(clk),
         .n_rst(n_rst),
         .falling_edge_found(falling_edge_found),
         .tx_enable(tx_enable),
         .tx_data(read_data),
         .tx_out(tx_out),
         .load_data(load_data)
        );

tx_fifo U6(
           .clk(clk),
           .n_rst(n_rst),
           .read_enable(read_enable),
           .read_data(read_data),
           .fifo_full(fifo_full),
           .fifo_empty(fifo_empty),
           .write_enable(write_enable),
           .write_data(write_data)
          );

timer U7(
         .clk(clk),
         .n_rst(n_rst),
         .rising_edge_found(rising_edge_found),
         .falling_edge_found(falling_edge_found),
         .stop_found(stop_found),
         .start_found(start_found),
         .byte_received(byte_received),
         .ack_prep(ack_prep),
         .check_ack(check_ack),
         .ack_done(ack_done)
        );

controller U8(
              .clk(clk),
              .n_rst(n_rst),
              .stop_found(stop_found),
              .start_found(start_found),
              .byte_received(byte_received),
              .ack_prep(ack_prep),
              .check_ack(check_ack),
              .ack_done(ack_done),
              .rw_mode(rw_mode),
              .address_match(address_match),
              .sda_in(s_sda_in),
              .rx_enable(rx_enable),
              .tx_enable(tx_enable),
              .read_enable(read_enable),
              .sda_mode(sda_mode),
              .load_data(load_data)
             );

endmodule

