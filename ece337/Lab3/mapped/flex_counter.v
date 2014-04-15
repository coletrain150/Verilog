
module flex_counter ( clk, clear, n_rst, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, clear, n_rst, count_enable;
  output rollover_flag;
  wire   n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69;

  DFFSR \counter_reg[0]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFPOSX1 flagger_reg ( .D(n34), .CLK(clk), .Q(rollover_flag) );
  DFFSR \counter_reg[1]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \counter_reg[2]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \counter_reg[3]  ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  OAI22X1 U36 ( .A(n36), .B(n37), .C(n38), .D(n39), .Y(n35) );
  OAI21X1 U37 ( .A(n40), .B(n41), .C(n42), .Y(n34) );
  OAI21X1 U38 ( .A(n43), .B(n44), .C(rollover_flag), .Y(n42) );
  NAND2X1 U39 ( .A(n_rst), .B(n45), .Y(n44) );
  NAND2X1 U40 ( .A(n46), .B(n45), .Y(n41) );
  INVX1 U41 ( .A(n_rst), .Y(n40) );
  OAI21X1 U42 ( .A(n47), .B(n37), .C(n48), .Y(n33) );
  MUX2X1 U43 ( .B(n49), .A(n50), .S(n51), .Y(n48) );
  NOR2X1 U44 ( .A(clear), .B(n38), .Y(n50) );
  NOR2X1 U45 ( .A(n39), .B(n52), .Y(n49) );
  OAI21X1 U46 ( .A(n53), .B(n37), .C(n54), .Y(n32) );
  MUX2X1 U47 ( .B(n55), .A(n56), .S(n57), .Y(n54) );
  NOR2X1 U48 ( .A(n39), .B(n58), .Y(n56) );
  AND2X1 U49 ( .A(n45), .B(n58), .Y(n55) );
  INVX1 U50 ( .A(count_out[2]), .Y(n53) );
  OAI22X1 U51 ( .A(n59), .B(n37), .C(n60), .D(n39), .Y(n31) );
  NAND2X1 U52 ( .A(n37), .B(n45), .Y(n39) );
  XOR2X1 U53 ( .A(n61), .B(n62), .Y(n60) );
  NOR2X1 U54 ( .A(n57), .B(n58), .Y(n62) );
  NAND2X1 U55 ( .A(n38), .B(n51), .Y(n58) );
  AND2X1 U56 ( .A(n63), .B(count_out[1]), .Y(n51) );
  INVX1 U57 ( .A(n52), .Y(n38) );
  NAND2X1 U58 ( .A(n63), .B(count_out[0]), .Y(n52) );
  NAND2X1 U59 ( .A(n63), .B(count_out[2]), .Y(n57) );
  NAND2X1 U60 ( .A(n63), .B(count_out[3]), .Y(n61) );
  NOR2X1 U61 ( .A(n46), .B(rollover_flag), .Y(n63) );
  INVX1 U62 ( .A(n64), .Y(n46) );
  NAND3X1 U63 ( .A(n45), .B(n43), .C(n64), .Y(n37) );
  NAND3X1 U64 ( .A(n65), .B(n66), .C(n67), .Y(n64) );
  NOR2X1 U65 ( .A(n68), .B(n69), .Y(n67) );
  XNOR2X1 U66 ( .A(rollover_val[1]), .B(n47), .Y(n69) );
  INVX1 U67 ( .A(count_out[1]), .Y(n47) );
  XNOR2X1 U68 ( .A(rollover_val[0]), .B(n36), .Y(n68) );
  INVX1 U69 ( .A(count_out[0]), .Y(n36) );
  XNOR2X1 U70 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n66) );
  XNOR2X1 U71 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n65) );
  INVX1 U72 ( .A(count_enable), .Y(n43) );
  INVX1 U73 ( .A(clear), .Y(n45) );
  INVX1 U74 ( .A(count_out[3]), .Y(n59) );
endmodule

