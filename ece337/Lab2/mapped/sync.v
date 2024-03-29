
module sync ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   out_one;

  DFFSR out_one_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(out_one) );
  DFFSR sec_out_reg ( .D(out_one), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out) );
endmodule

