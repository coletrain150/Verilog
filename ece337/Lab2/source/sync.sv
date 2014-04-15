// $Id: $
// File name:   sync.sv
// Created:     2/3/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: sync

module sync
(
 input wire clk,
 input wire n_rst,
 input wire async_in,
 output wire sync_out
);
reg out_one, sec_out;
assign sync_out = sec_out;
   
   
   
always_ff @ (posedge clk, negedge n_rst)
begin
  if(1'b0 == n_rst)
    begin
       out_one=0;
    end
  else
    begin
       out_one = async_in;
    end
end

always_ff @ (posedge clk, negedge n_rst)
begin
  if(1'b0 == n_rst)
    begin
       sec_out=0;
    end
  else
    begin
       sec_out = out_one;
    end
end


endmodule