// $Id: $
// File name:   adder_4bit.sv
// Created:     2/1/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: 4 bit adder.

module adder_4bit
(
input wire [3:0] a,
input wire [3:0] b,
input wire carry_in,
output wire [3:0] sum,
output wire overflow 
);

wire [4:0] carrys;

assign carrys[0] = carry_in;

adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]),
		  .sum(sum[i]), .carry_out(carrys[i+1]));

assign overflow = carrys[4];   


endmodule