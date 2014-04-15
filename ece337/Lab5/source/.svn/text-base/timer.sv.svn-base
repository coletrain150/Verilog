// $Id: $
// File name:   timer.sv
// Created:     2/22/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: timer


module  timer
(
input wire clk,
input wire n_rst,
input wire enable_timer,
output wire shift_strobe,
output wire packet_done
);

   reg 	    nextpacket;
   //reg 	    packet;
   //reg 	    strobe;
   reg 	    nextstrobe;
   reg 	    done;
   reg 	    flag;

   assign packet_done = done;
   assign shift_strobe = flag;

/*always_ff@(posedge clk, negedge n_rst)
  begin
     if(n_rst == 1'b0) begin
	     packet<=0;
	     strobe<=0;
     end
     else begin
	     packet<=nextpacket;
    	 strobe<=nextstrobe;
     end
  end // always_ff@ (posedge clk, negedge n_rst)
*/
   flex_counter #(8, 11) U1(.clk(clk), .n_reset(n_rst), .clear(done), .cnt_up(enable_timer), .one_k_samples(flag));
   flex_counter #(8, 9) U2(.clk(clk), .n_reset(n_rst), .clear(done), .cnt_up(flag), .one_k_samples(done));


/*always_comb begin
   nextstrobe = 0;
   nextpacket = 0;
   if(flag == 1'b1) begin
      nextstrobe = 1;
   end

   else if(done == 1'b1) begin
      nextpacket = 1;
   end
end*/






endmodule