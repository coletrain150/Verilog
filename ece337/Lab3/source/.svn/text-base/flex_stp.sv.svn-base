// $Id: $
// File name:   flex_stp.sv
// Created:     2/4/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: serial to parallel shift register


module flex_stp
#(
parameter NUM_BITS = 4
parameter SHIFT_MSB
)
(
input wire clk,
input wire n_rst = 1,
input wire shift_enable,
input wire serial_in = 1,
output wire [NUM_BITS:0] parallel_out
);

   