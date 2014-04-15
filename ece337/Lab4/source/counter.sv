// $Id: $
// File name:   flex_counter.sv
// Created:     2/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: flexivle svalable counter


module counter
#(
parameter NUM_CNT_BITS = 4
)
(
 input wire clk,
 input wire n_reset,
 input wire cnt_up,
 output wire one_k_samples
);
   reg	flagger;
   reg 	nextflag;

   assign one_k_samples = flagger;
   reg rollover_val = 10;
   reg [NUM_CNT_BITS-1:0] counter;
   reg [NUM_CNT_BITS-1:0] nextcnt;


 always_ff @ (posedge clk, negedge n_reset)
    begin
       if(1'b0 == n_reset) begin
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
     if(cnt_up == 1) begin
      nextcnt = counter + 1;
      if(nextcnt == rollover_val) begin
	     nextflag = 1;
    	 nextcnt = 1;
     end
   end
  end // always_comb begin

endmodule