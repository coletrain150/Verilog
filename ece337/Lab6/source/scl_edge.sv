// $Id: $
// File name:   scl_edge.sv
// Created:     3/7/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: scl_edge detector


module scl_edge
(
    input wire clk,
    input wire n_rst,
    input wire scl,
    output wire rising_edge_found,
    output wire falling_edge_found
);

reg sec_out, third_out;


always_ff @ (posedge clk, negedge n_rst) begin
  if(1'b0 == n_rst) begin
       sec_out <= 1;
       third_out<=1;
    end
  else begin
       third_out <=sec_out;
       sec_out <= scl;
    end
end


assign rising_edge_found = sec_out & !third_out;
assign falling_edge_found = third_out & !sec_out;

endmodule


