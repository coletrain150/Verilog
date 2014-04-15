// $Id: $
// File name:   timer.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: timer

module timer
(
    input wire clk,
    input wire n_rst,
    input wire rising_edge_found,
    input wire falling_edge_found,
    input wire stop_found,
    input wire start_found,
    output wire byte_received,
    output wire ack_prep,
    output wire check_ack,
    output wire ack_done
);

    reg check,start,nextstart,fall,clear;
    reg [7:0] count;
    assign check_ack = check;
    assign ack_done = check && fall;
    assign byte_received = ((count == 4'b1000) ? 1'b1 : 1'b0) && fall;
    assign ack_prep = byte_received;//byte_received && fall;

    flex_counter #(8,9) U1(
                    .clk(clk),
                    .n_reset(n_rst),
                    .cnt_up(rising_edge_found & start),
                    .clear(clear),
                    .counter(count),
                    .one_k_samples(check)
                    );

always_ff @ (posedge clk, negedge n_rst) begin
    if(n_rst == 1'b0) begin
        start <= 0;
    end
    else begin
        start <= nextstart;
    end
end
always_comb
begin
    nextstart = start;
    if(start_found == 1) begin
        nextstart = 1;
    end
    else if(stop_found == 1) begin
        nextstart = 0;
    end
end


always_ff @ (posedge clk, negedge n_rst) begin
    if(n_rst == 1'b0) begin
        fall <= 0;
    end
    else begin
        fall <= falling_edge_found;
    end
end
endmodule
