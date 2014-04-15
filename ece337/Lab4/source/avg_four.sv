// $Id: creinhol
// File name:   avg_four.sv
// Created:     2/18/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: avg window slider
// ..

module avg_four
(
 input wire clk,
 input wire n_reset,
 input wire [15:0] sample_data,
 input wire data_ready,
 output wire one_k_samples,
 output wire modwait,
 output wire [15:0] avg_out,
 output wire err
);

reg [15:0] out_data;
reg [1:0] op;
reg [3:0] src1;
reg [3:0] src2;
reg [3:0] dest;
reg dr;
reg test_overflow;
reg count_en;
sync U2(.clk(clk), .n_reset(n_reset), .async_in(data_ready), .sync_out(dr));
controller U1(.clk(clk), .n_reset(n_reset), .dr(dr), .overflow(test_overflow), .cnt_up(count_en), .modwait(modwait), .op(op), .src1(src1), .src2(src2), .dest(dest), .err(err));
datapath U3(.clk(clk), .n_reset(n_reset), .overflow(test_overflow), .op(op), .src1(src1), .src2(src2), .dest(dest), .ext_data(sample_data), .outreg_data(out_data));
counter U4(.clk(clk), .n_reset(n_reset), .cnt_up(count_en), .one_k_samples(one_k_samples));

assign avg_out = {2'b00, out_data[15:2]};

endmodule
