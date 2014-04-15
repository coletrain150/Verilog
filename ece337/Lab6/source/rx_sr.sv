// $Id: $
// File name:   rx_sr.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: receiving shift register


module rx_sr
(
    input wire clk,
    input wire n_rst,
    input wire sda_in,
    input wire rising_edge_found,
    input wire rx_enable,
    output reg [7:0] rx_data
);

reg shift;


always_ff @ (posedge clk, negedge n_rst) begin
    if (n_rst == 1'b0) begin
        shift <= 0;
    end
    else begin
        shift <= rising_edge_found & rx_enable;
    end
end
flex_stp_sr U1 (.clk(clk),
                .n_rst(n_rst),
                .shift_enable(shift),
                .serial_in(sda_in),
                .parallel_out(rx_data)
                );

endmodule
