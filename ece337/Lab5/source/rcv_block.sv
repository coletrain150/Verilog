// $Id: $
// File name:   rcv_block.sv
// Created:     2/22/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: top level block


module rcv_block
(
 input wire clk,
 input wire n_rst,
 input wire serial_in,
 input wire data_read,
 output reg [7:0] rx_data,
 output wire data_ready,
 output wire overrun_error,
 output wire framing_error
);
   reg 	     enable_timer;
   reg 	     shift_strobe;
   reg 	     packet_done;
   reg [7:0] packet_data;
   reg 	     stop_bit;
   reg 	     load_buffer;
   reg 	     start_bit_detected;
   reg 	     sbc_clear;
   reg 	     sbc_enable;


   rcu U1
     (
      .clk(clk),
      .n_rst(n_rst),
      .start_bit_detected(start_bit_detected),
      .packet_done(packet_done),
      .framing_error(framing_error),
      .sbc_clear(sbc_clear),
      .sbc_enable(sbc_enable),
      .load_buffer(load_buffer),
      .enable_timer(enable_timer)
      );


   timer U2
     (
      .clk(clk),
      .n_rst(n_rst),
      .enable_timer(enable_timer),
      .shift_strobe(shift_strobe),
      .packet_done(packet_done)
      );

   sr_9bit U3
     (
      .clk(clk),
      .n_rst(n_rst),
      .shift_strobe(shift_strobe),
      .serial_in(serial_in),
      .packet_data(packet_data),
      .stop_bit(stop_bit)
      );

   rx_data_buff U4
     (
      .clk(clk),
      .n_rst(n_rst),
      .load_buffer(load_buffer),
      .packet_data(packet_data),
      .data_read(data_read),
      .rx_data(rx_data),
      .data_ready(data_ready),
      .overrun_error(overrun_error)
      );

   start_bit_det U5
     (
      .clk(clk),
      .n_rst(n_rst),
      .serial_in(serial_in),
      .start_bit_detected(start_bit_detected)
      );

   stop_bit_chk U6
     (
      .clk(clk),
      .n_rst(n_rst),
      .sbc_clear(sbc_clear),
      .sbc_enable(sbc_enable),
      .stop_bit(stop_bit),
      .framing_error(framing_error)
      );

endmodule // rcv_block

