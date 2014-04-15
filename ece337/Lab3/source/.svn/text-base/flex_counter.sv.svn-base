// $Id: $
// File name:   flex_counter.sv
// Created:     2/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: flexivle svalable counter


module flex_counter
#(
parameter NUM_CNT_BITS = 4
)
(
 input wire clk,
 input wire clear,
 input wire n_rst,
 input wire count_enable,
 input wire [NUM_CNT_BITS-1:0] rollover_val,
 output wire [NUM_CNT_BITS-1:0] count_out,
 output wire rollover_flag
);
   reg	flagger = 0;
   assign rollover_flag = flagger;
   
   reg [NUM_CNT_BITS-1:0] counter;
   reg [NUM_CNT_BITS-1:0] nextcnt = 0;
   
   assign count_out = counter;
   
 always_ff @ (posedge clk, negedge n_rst)
    begin
       if(1'b0 == n_rst) begin
	  counter <= '0;
	  //flagger <= 0;
       end
       
       else if(clear == 1) begin
	  counter <= '0;
          //flagger <= 0;
       end
       
       else begin
	  //rollover_flag<=flagger;
	  counter <= nextcnt;
       end
 
    end
   
always_comb
  begin
     if(nextcnt == rollover_val) begin
	flagger = 1;
	nextcnt = 1;
     end
     else if(count_enable == 1) begin
	if(flagger == 1) begin
	   flagger = 0;
	   nextcnt = 1;
	end 
	else begin
	   nextcnt = nextcnt + 1;
	   flagger = 0;
	   
	end
	
     end // if (count_enable == 1)
  end // always_comb begin
   
	


endmodule