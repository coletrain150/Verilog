// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/10/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: parallel to serial shift register


module flex_pts_sr
#(
parameter NUM_BITS = 4,
parameter SHIFT_MSB = 1
)
(
input wire clk,
input wire n_rst,
input wire shift_enable,
input wire load_enable,
input wire [NUM_BITS-1:0] parallel_in,
output wire serial_out
);

   reg [NUM_BITS-1:0] temp;
   reg serial_output;
   assign serial_out = serial_output;
   
always_ff @ (posedge clk, negedge n_rst)
    begin
       if(1'b0 == n_rst) begin
	    temp = '1;
       end
       else if(load_enable == 1) begin
	 temp = parallel_in[NUM_BITS-1:0];	  
       end 
       else if (shift_enable == 1) begin
	    if(SHIFT_MSB == 1) begin
		 temp = {temp[NUM_BITS-2:0], 1'b0};
	    end
	    else begin
		 temp = {1'b0, temp[NUM_BITS-1:1]};
	    end
       end // if (shift_enable == 1)
    end
   always_comb
     begin
	    if(SHIFT_MSB == 1) begin
		 serial_output = temp[NUM_BITS-1];
	    end
	    else begin
		 serial_output = temp[0];
	    end
	
 
    end // always_ff @ (posedge clk, negedge n_rst)
endmodule