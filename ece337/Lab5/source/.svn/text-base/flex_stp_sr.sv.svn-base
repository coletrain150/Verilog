// $Id: $
// File name:   flex_stp.sv
// Created:     2/4/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: serial to parallel shift register


module flex_stp_sr
#(
parameter NUM_BITS = 9,
parameter SHIFT_MSB = 0
)
(
input wire clk,
input wire n_rst,
input wire shift_enable,
input wire serial_in,
output wire [NUM_BITS-1:0] parallel_out
);

reg [NUM_BITS-1:0] data_out;
assign parallel_out = data_out; 
  always_ff @ (posedge clk, negedge n_rst)
    begin
       if(1'b0 == n_rst)
	 begin
	    data_out <= 32'b11111111111111111111111111111111;
	 end
       else if(shift_enable == 1)
	 begin
	    if(SHIFT_MSB == 1)
	      begin
		 data_out <= {data_out[NUM_BITS-2:0], serial_in};
		  
	      end
	    else
	      begin
		 data_out <= {serial_in, data_out[NUM_BITS-1:1]};
		  
	      end
	 end
    end // always_ff @ (posedge clk, negedge n_rst)
//end // for (i = 0; i <=(NUM_BITS-1); i = i + 1
//endgenerate

   
   
endmodule // flex_stp_sr
