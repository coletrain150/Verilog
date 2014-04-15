// $Id: $
// File name:   sda_sel.sv
// Created:     3/7/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: sda_select


module sda_sel
(
input wire tx_out,
input reg [1:0] sda_mode,
output wire sda_out
);

reg select;
assign sda_out = select;
always_comb
begin
    select = 0;
    case(sda_mode)
        2'b00: begin
            select = 1;
        end
        2'b01: begin
            select = 0;
        end
        2'b10: begin
            select = 1;
        end
        2'b11: begin
            select = tx_out;
        end
    endcase
end

endmodule


