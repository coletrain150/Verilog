// $Id: $
// File name:   tx_sr.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: transimitting shift register
module tx_sr
(
    input wire clk,
    input wire n_rst,
    input reg [7:0] tx_data,
    input wire falling_edge_found,
    input wire tx_enable,
    input wire load_data,
    output wire tx_out
);

reg shift;


always_ff @ (posedge clk, negedge n_rst) begin
    if (n_rst == 1'b0) begin
        shift <= 0;
    end
    else begin
        shift <= falling_edge_found & tx_enable;
    end
end
flex_pts_sr U1 (.clk(clk),
                .n_rst(n_rst),
                .shift_enable(shift),
                .load_enable(load_data),
                .parallel_in(tx_data),
                .serial_out(tx_out)
                );

endmodule
