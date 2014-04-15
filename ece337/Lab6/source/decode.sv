// $Id: $
// File name:   decode.sv
// Created:     3/7/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: decoder


module decode
(
    input wire clk,
    input wire n_rst,
    input wire scl,
    input wire sda_in,
    input reg [7:0] starting_byte,
    output wire rw_mode,
    output wire address_match,
    output wire stop_found,
    output wire start_found
);


reg match, stop, start, nextstop, nextstart, nextmatch;
assign address_match = match;
assign stop_found = stop;
assign start_found = start;
assign rw_mode = starting_byte[0];
reg sda1, sda2, scl1, scl2;

always_ff@(posedge clk, negedge n_rst) begin
    if (n_rst == 0) begin
        start <= 0;
        stop <= 0;
        match <= 0;
    end
    else begin
        start <= nextstart;
        stop <= nextstop;
        match <= nextmatch;
    end
end
always_ff@(posedge clk, negedge n_rst) begin
    if (n_rst == 0) begin
        sda1 <= 1;
    end
    else begin
        sda1 <= sda_in;
    end
end
always_ff@(posedge clk, negedge n_rst) begin
    if (n_rst == 0) begin
        sda2<= 1;
    end
    else begin
        sda2 <= sda1;
    end
end
always_ff@(posedge clk, negedge n_rst) begin
    if (n_rst == 0) begin
        scl1 <= 1;
    end
    else begin
        scl1 <= scl;
    end
end
always_ff@(posedge clk, negedge n_rst) begin
    if (n_rst == 0) begin
        scl2 <= 1;
    end
    else begin
        scl2 <= scl1;
    end
end

always_comb
begin
    nextstart = 0;
    nextstop = 0;
    nextmatch = match;
    if(starting_byte[7:1] == 7'b1111000) begin
        nextmatch = 1;
    end
    else begin
        nextmatch = 0;
    end
    if(scl1 == 1 & scl2 == 1) begin
        if(sda1 == 0 & sda2 == 1) begin
            nextstart = 1;
        end
        else if (sda1 == 1 & sda2 == 0) begin
            nextstop = 1;
        end
    end
end


endmodule



