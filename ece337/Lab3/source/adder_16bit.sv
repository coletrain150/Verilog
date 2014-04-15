// $Id: $
// File name:   adder_16bit.sv
// Created:     2/4/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: 16 bit adder
module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);

wire [16:0] carrys;
   always @ (a)
     begin
       assert((a[0]==1'b1) || (a[0]==1'b0))
       else $error("Input 'a' of component is not a digital logic value");
     end
assign carrys[0] = carry_in;
adder_nbit #(.BIT_WIDTH(16))IX (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));

assign overflow = carrys[16];   

endmodule