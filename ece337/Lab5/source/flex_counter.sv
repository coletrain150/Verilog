// $Id: $
// File name:   flex_counter.sv
// Created:     2/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: flexivle svalable counter


module flex_counter
#(
parameter NUM_CNT_BITS = 8,
parameter ROLLOVER_VAL = 10
)
(
 input wire clk,
 input wire n_reset,
 input wire cnt_up,
 input wire clear,
 output wire one_k_samples
);
   reg	flagger;
   reg 	nextflag;

   assign one_k_samples = flagger;
   reg [NUM_CNT_BITS-1:0] counter;
   reg [NUM_CNT_BITS-1:0] nextcnt;


 always_ff @ (posedge clk, negedge n_reset)
    begin
       if(1'b0 == n_reset) begin
	       counter <= '0;
	       flagger <= 0;
       end
       else if(clear == 1) begin
         counter <= '0;
         flagger <= 0;
       end
       else begin
	       counter <= nextcnt;
	       flagger <= nextflag;
       end
    end

always_comb
  begin
     nextflag = 0;
     nextcnt = counter;
     if (cnt_up == 1) begin
      nextcnt = counter + 1;
      if(nextcnt == ROLLOVER_VAL) begin
	     nextflag = 1;
	     nextcnt = 1;
      end
	   end
  end // always_comb begin

endmodule