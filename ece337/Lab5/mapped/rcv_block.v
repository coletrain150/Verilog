
module rcu ( clk, n_rst, start_bit_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, start_bit_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n4, n5, n6, n7, n8, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25;
  wire   [2:0] state;
  wire   [2:0] nextstate;

  DFFSR \state_reg[0]  ( .D(nextstate[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[2]  ( .D(nextstate[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[2]) );
  DFFSR \state_reg[1]  ( .D(nextstate[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[1]) );
  INVX1 U6 ( .A(state[0]), .Y(n21) );
  INVX4 U7 ( .A(n22), .Y(enable_timer) );
  NAND2X1 U8 ( .A(state[0]), .B(state[2]), .Y(n5) );
  NAND2X1 U9 ( .A(n4), .B(n18), .Y(n6) );
  NAND2X1 U10 ( .A(n5), .B(n6), .Y(n25) );
  INVX2 U11 ( .A(state[0]), .Y(n4) );
  INVX1 U12 ( .A(n15), .Y(n16) );
  INVX1 U13 ( .A(n25), .Y(n7) );
  INVX2 U14 ( .A(n7), .Y(n8) );
  AND2X2 U15 ( .A(n16), .B(n23), .Y(sbc_enable) );
  INVX2 U16 ( .A(n4), .Y(n10) );
  INVX1 U17 ( .A(enable_timer), .Y(n11) );
  INVX2 U18 ( .A(packet_done), .Y(n19) );
  MUX2X1 U19 ( .B(n19), .A(framing_error), .S(n10), .Y(n12) );
  NAND2X1 U20 ( .A(state[1]), .B(n12), .Y(n13) );
  NOR2X1 U21 ( .A(state[2]), .B(n13), .Y(nextstate[2]) );
  NAND2X1 U22 ( .A(state[2]), .B(n10), .Y(n15) );
  NAND3X1 U23 ( .A(n25), .B(state[1]), .C(n15), .Y(n22) );
  INVX2 U24 ( .A(state[1]), .Y(n23) );
  NAND3X1 U25 ( .A(start_bit_detected), .B(n8), .C(n23), .Y(n14) );
  OAI21X1 U26 ( .A(n19), .B(n11), .C(n14), .Y(n17) );
  OR2X2 U27 ( .A(n17), .B(sbc_enable), .Y(nextstate[0]) );
  INVX2 U28 ( .A(state[2]), .Y(n18) );
  NAND3X1 U29 ( .A(n19), .B(n18), .C(n21), .Y(n20) );
  MUX2X1 U30 ( .B(n21), .A(n20), .S(state[1]), .Y(nextstate[1]) );
  NAND2X1 U31 ( .A(state[2]), .B(n23), .Y(n24) );
  NOR2X1 U32 ( .A(n10), .B(n24), .Y(load_buffer) );
  NOR2X1 U33 ( .A(state[1]), .B(n8), .Y(sbc_clear) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL11_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n3, n4, n5, n6, n7, n8, n9, n11, n12, n14, n15, n16, n17, n18, n19,
         n21, n22, n23, n43, n44, n45, n46, n47, n48, n49, n50, n51;
  assign n9 = A[5];
  assign n12 = A[4];
  assign n15 = A[3];
  assign n18 = A[2];
  assign n22 = A[1];

  XOR2X1 U3 ( .A(n6), .B(n5), .Y(SUM[6]) );
  NAND2X1 U4 ( .A(n43), .B(n4), .Y(n3) );
  NOR2X1 U5 ( .A(n5), .B(n8), .Y(n4) );
  NAND2X1 U8 ( .A(n44), .B(n7), .Y(n6) );
  NAND2X1 U10 ( .A(n9), .B(n12), .Y(n8) );
  NAND2X1 U14 ( .A(n12), .B(n43), .Y(n11) );
  XOR2X1 U17 ( .A(n17), .B(n16), .Y(SUM[3]) );
  NAND2X1 U19 ( .A(n15), .B(n18), .Y(n14) );
  XNOR2X1 U22 ( .A(n51), .B(n19), .Y(SUM[2]) );
  NAND2X1 U23 ( .A(n45), .B(n51), .Y(n17) );
  XNOR2X1 U26 ( .A(n46), .B(n23), .Y(SUM[1]) );
  NAND2X1 U28 ( .A(n22), .B(A[0]), .Y(n21) );
  NOR2X1 U33 ( .A(n14), .B(n21), .Y(n43) );
  NOR2X1 U34 ( .A(n14), .B(n21), .Y(n44) );
  AND2X2 U35 ( .A(A[0]), .B(n22), .Y(n51) );
  INVX1 U36 ( .A(n19), .Y(n45) );
  INVX1 U37 ( .A(n15), .Y(n16) );
  BUFX2 U38 ( .A(A[0]), .Y(n46) );
  INVX1 U39 ( .A(n22), .Y(n23) );
  NAND2X1 U40 ( .A(n11), .B(n9), .Y(n49) );
  NAND2X1 U41 ( .A(n47), .B(n48), .Y(n50) );
  NAND2X1 U42 ( .A(n49), .B(n50), .Y(SUM[5]) );
  INVX1 U43 ( .A(n11), .Y(n47) );
  INVX1 U44 ( .A(n9), .Y(n48) );
  XOR2X1 U45 ( .A(n44), .B(n12), .Y(SUM[4]) );
  XNOR2X1 U46 ( .A(n3), .B(A[7]), .Y(SUM[7]) );
  INVX1 U47 ( .A(n18), .Y(n19) );
  INVX2 U48 ( .A(n8), .Y(n7) );
  INVX2 U49 ( .A(A[6]), .Y(n5) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL11 ( clk, n_reset, cnt_up, clear, 
        one_k_samples );
  input clk, n_reset, cnt_up, clear;
  output one_k_samples;
  wire   N14, N17, N18, N19, N20, N21, N22, N23, n43, n44, n45, n46, n47, n48,
         n49, n50, n1, n2, n3, n4, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n51, n52, n53, n54, n55, n56, n57;
  wire   [7:0] counter;
  wire   SYNOPSYS_UNCONNECTED__0;

  DFFSR \counter_reg[0]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[0]) );
  DFFSR flagger_reg ( .D(N14), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        one_k_samples) );
  DFFSR \counter_reg[6]  ( .D(n44), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[6]) );
  DFFSR \counter_reg[5]  ( .D(n45), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[5]) );
  DFFSR \counter_reg[4]  ( .D(n46), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[4]) );
  DFFSR \counter_reg[3]  ( .D(n47), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[3]) );
  DFFSR \counter_reg[2]  ( .D(n48), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[2]) );
  DFFSR \counter_reg[1]  ( .D(n49), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[1]) );
  DFFSR \counter_reg[7]  ( .D(n43), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[7]) );
  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL11_DW01_inc_1 add_51 ( .A({
        counter[7:5], n14, counter[3:0]}), .SUM({N23, N22, N21, N20, N19, N18, 
        N17, SYNOPSYS_UNCONNECTED__0}) );
  INVX1 U12 ( .A(N17), .Y(n4) );
  AND2X2 U13 ( .A(cnt_up), .B(n52), .Y(n1) );
  INVX4 U14 ( .A(n1), .Y(n56) );
  INVX1 U15 ( .A(n33), .Y(n2) );
  NOR2X1 U16 ( .A(n56), .B(n4), .Y(n3) );
  BUFX4 U17 ( .A(counter[4]), .Y(n14) );
  NAND2X1 U18 ( .A(n57), .B(n3), .Y(n42) );
  INVX1 U19 ( .A(n2), .Y(n32) );
  INVX1 U20 ( .A(n20), .Y(n15) );
  INVX2 U21 ( .A(n20), .Y(n53) );
  NOR2X1 U22 ( .A(N21), .B(N22), .Y(n16) );
  BUFX2 U23 ( .A(n20), .Y(n17) );
  INVX1 U24 ( .A(counter[0]), .Y(n18) );
  INVX2 U25 ( .A(n18), .Y(n19) );
  INVX1 U26 ( .A(N18), .Y(n41) );
  INVX1 U27 ( .A(counter[2]), .Y(n40) );
  NOR2X1 U28 ( .A(clear), .B(cnt_up), .Y(n20) );
  INVX1 U29 ( .A(N23), .Y(n26) );
  NAND2X1 U30 ( .A(n17), .B(n21), .Y(n22) );
  NAND2X1 U31 ( .A(n22), .B(n38), .Y(n47) );
  INVX2 U32 ( .A(n39), .Y(n21) );
  INVX1 U33 ( .A(counter[3]), .Y(n39) );
  INVX1 U34 ( .A(n19), .Y(n55) );
  NAND2X1 U35 ( .A(n17), .B(n23), .Y(n24) );
  NAND2X1 U36 ( .A(n24), .B(n42), .Y(n49) );
  INVX2 U37 ( .A(n51), .Y(n23) );
  NAND2X1 U38 ( .A(n16), .B(n37), .Y(n57) );
  INVX1 U39 ( .A(counter[1]), .Y(n51) );
  INVX2 U40 ( .A(clear), .Y(n52) );
  INVX2 U41 ( .A(counter[7]), .Y(n25) );
  OAI22X1 U42 ( .A(n56), .B(n26), .C(n53), .D(n25), .Y(n43) );
  INVX2 U43 ( .A(counter[6]), .Y(n28) );
  NAND3X1 U44 ( .A(N22), .B(cnt_up), .C(n52), .Y(n27) );
  OAI21X1 U45 ( .A(n15), .B(n28), .C(n27), .Y(n44) );
  INVX2 U46 ( .A(counter[5]), .Y(n30) );
  NAND3X1 U47 ( .A(N21), .B(cnt_up), .C(n52), .Y(n29) );
  OAI21X1 U48 ( .A(n15), .B(n30), .C(n29), .Y(n45) );
  INVX2 U49 ( .A(n14), .Y(n31) );
  OAI22X1 U50 ( .A(n56), .B(n32), .C(n53), .D(n31), .Y(n46) );
  INVX2 U51 ( .A(N19), .Y(n36) );
  NOR2X1 U52 ( .A(N18), .B(n19), .Y(n34) );
  INVX2 U53 ( .A(N20), .Y(n33) );
  NAND3X1 U54 ( .A(n34), .B(N17), .C(n33), .Y(n35) );
  NOR3X1 U55 ( .A(n36), .B(N23), .C(n35), .Y(n37) );
  NAND3X1 U56 ( .A(n57), .B(N19), .C(n1), .Y(n38) );
  OAI22X1 U57 ( .A(n56), .B(n41), .C(n53), .D(n40), .Y(n48) );
  NAND2X1 U58 ( .A(n52), .B(n55), .Y(n54) );
  MUX2X1 U59 ( .B(n55), .A(n54), .S(n53), .Y(n50) );
  NOR2X1 U60 ( .A(n57), .B(n56), .Y(N14) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n45, n46, n47;
  assign n9 = A[5];
  assign n12 = A[4];
  assign n15 = A[3];
  assign n18 = A[2];
  assign n22 = A[1];
  assign n24 = A[0];

  XOR2X1 U3 ( .A(n6), .B(n5), .Y(SUM[6]) );
  NAND2X1 U4 ( .A(n46), .B(n4), .Y(n3) );
  NOR2X1 U5 ( .A(n5), .B(n8), .Y(n4) );
  XOR2X1 U7 ( .A(n11), .B(n10), .Y(SUM[5]) );
  NAND2X1 U8 ( .A(n7), .B(n46), .Y(n6) );
  NAND2X1 U10 ( .A(n9), .B(n12), .Y(n8) );
  NAND2X1 U14 ( .A(n12), .B(n46), .Y(n11) );
  XOR2X1 U17 ( .A(n17), .B(n16), .Y(SUM[3]) );
  NAND2X1 U19 ( .A(n15), .B(n18), .Y(n14) );
  XNOR2X1 U22 ( .A(n20), .B(n19), .Y(SUM[2]) );
  NAND2X1 U23 ( .A(n18), .B(n20), .Y(n17) );
  NAND2X1 U28 ( .A(n22), .B(n24), .Y(n21) );
  XNOR2X1 U35 ( .A(n45), .B(n12), .Y(SUM[4]) );
  INVX2 U36 ( .A(n45), .Y(n46) );
  INVX1 U37 ( .A(n15), .Y(n16) );
  INVX2 U38 ( .A(n47), .Y(n45) );
  INVX1 U39 ( .A(n21), .Y(n20) );
  XNOR2X1 U40 ( .A(n3), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U41 ( .A(SUM[0]), .B(n23), .Y(SUM[1]) );
  NOR2X1 U42 ( .A(n21), .B(n14), .Y(n47) );
  INVX1 U43 ( .A(n22), .Y(n23) );
  INVX1 U44 ( .A(n18), .Y(n19) );
  INVX1 U45 ( .A(n24), .Y(SUM[0]) );
  INVX2 U46 ( .A(n8), .Y(n7) );
  INVX2 U47 ( .A(A[6]), .Y(n5) );
  INVX2 U48 ( .A(n9), .Y(n10) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9 ( clk, n_reset, cnt_up, clear, 
        one_k_samples );
  input clk, n_reset, cnt_up, clear;
  output one_k_samples;
  wire   N14, N16, N17, N18, N19, N20, N21, N22, N23, n43, n44, n45, n46, n47,
         n48, n49, n50, n1, n2, n3, n4, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42;
  wire   [7:0] counter;

  DFFSR \counter_reg[0]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[0]) );
  DFFSR flagger_reg ( .D(N14), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        one_k_samples) );
  DFFSR \counter_reg[6]  ( .D(n44), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[6]) );
  DFFSR \counter_reg[5]  ( .D(n45), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[5]) );
  DFFSR \counter_reg[4]  ( .D(n46), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[4]) );
  DFFSR \counter_reg[3]  ( .D(n47), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[3]) );
  DFFSR \counter_reg[2]  ( .D(n48), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[2]) );
  DFFSR \counter_reg[1]  ( .D(n49), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[1]) );
  DFFSR \counter_reg[7]  ( .D(n43), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[7]) );
  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9_DW01_inc_1 add_51 ( .A(counter), 
        .SUM({N23, N22, N21, N20, N19, N18, N17, N16}) );
  AND2X2 U12 ( .A(n32), .B(N16), .Y(n1) );
  BUFX2 U13 ( .A(n23), .Y(n2) );
  INVX1 U14 ( .A(n27), .Y(n47) );
  NAND2X1 U15 ( .A(n29), .B(n1), .Y(n20) );
  INVX2 U16 ( .A(n34), .Y(n3) );
  INVX1 U17 ( .A(N20), .Y(n18) );
  INVX1 U18 ( .A(counter[1]), .Y(n30) );
  INVX1 U19 ( .A(counter[2]), .Y(n28) );
  INVX1 U20 ( .A(counter[0]), .Y(n35) );
  INVX2 U21 ( .A(clear), .Y(n40) );
  INVX2 U22 ( .A(cnt_up), .Y(n4) );
  NAND2X1 U23 ( .A(n40), .B(n4), .Y(n31) );
  NAND2X1 U24 ( .A(n31), .B(n40), .Y(n33) );
  INVX2 U25 ( .A(N23), .Y(n19) );
  INVX2 U26 ( .A(counter[7]), .Y(n14) );
  OAI22X1 U27 ( .A(n33), .B(n19), .C(n3), .D(n14), .Y(n43) );
  INVX2 U28 ( .A(N22), .Y(n21) );
  INVX2 U29 ( .A(counter[6]), .Y(n15) );
  OAI22X1 U30 ( .A(n33), .B(n21), .C(n3), .D(n15), .Y(n44) );
  INVX2 U31 ( .A(N21), .Y(n38) );
  INVX2 U32 ( .A(counter[5]), .Y(n16) );
  OAI22X1 U33 ( .A(n33), .B(n38), .C(n3), .D(n16), .Y(n45) );
  INVX2 U34 ( .A(counter[4]), .Y(n17) );
  OAI22X1 U35 ( .A(n33), .B(n18), .C(n3), .D(n17), .Y(n46) );
  NAND2X1 U36 ( .A(n19), .B(n38), .Y(n26) );
  INVX2 U37 ( .A(n31), .Y(n34) );
  NAND2X1 U38 ( .A(counter[3]), .B(n34), .Y(n22) );
  INVX2 U39 ( .A(N17), .Y(n32) );
  INVX2 U40 ( .A(N18), .Y(n29) );
  INVX2 U41 ( .A(N19), .Y(n23) );
  NOR3X1 U42 ( .A(N20), .B(n20), .C(n23), .Y(n39) );
  NAND3X1 U43 ( .A(n22), .B(n21), .C(n39), .Y(n25) );
  OAI21X1 U44 ( .A(n2), .B(n33), .C(n22), .Y(n24) );
  OAI21X1 U45 ( .A(n26), .B(n25), .C(n24), .Y(n27) );
  OAI22X1 U46 ( .A(n33), .B(n29), .C(n3), .D(n28), .Y(n48) );
  OAI22X1 U47 ( .A(n33), .B(n32), .C(n3), .D(n30), .Y(n49) );
  NAND2X1 U48 ( .A(n40), .B(n35), .Y(n36) );
  MUX2X1 U49 ( .B(n36), .A(n35), .S(n34), .Y(n50) );
  NOR2X1 U50 ( .A(N22), .B(N23), .Y(n37) );
  NAND3X1 U51 ( .A(n38), .B(n39), .C(n37), .Y(n42) );
  NAND2X1 U52 ( .A(cnt_up), .B(n40), .Y(n41) );
  NOR2X1 U53 ( .A(n42), .B(n41), .Y(N14) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done );
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;


  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL11 U1 ( .clk(clk), .n_reset(n_rst), 
        .cnt_up(enable_timer), .clear(packet_done), .one_k_samples(
        shift_strobe) );
  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9 U2 ( .clk(clk), .n_reset(n_rst), 
        .cnt_up(shift_strobe), .clear(packet_done), .one_k_samples(packet_done) );
endmodule


module flex_stp_sr ( clk, n_rst, shift_enable, serial_in, parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n3, n11, n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n4, n5,
         n6, n7, n8, n9, n10, n30;

  DFFSR \data_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \data_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \data_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \data_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \data_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \data_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \data_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \data_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \data_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  OAI21X1 U2 ( .A(n30), .B(n1), .C(n3), .Y(n13) );
  NAND2X1 U3 ( .A(parallel_out[0]), .B(n1), .Y(n3) );
  OAI22X1 U4 ( .A(n1), .B(n10), .C(n2), .D(n30), .Y(n15) );
  OAI22X1 U6 ( .A(n1), .B(n9), .C(n2), .D(n10), .Y(n17) );
  OAI22X1 U8 ( .A(n1), .B(n8), .C(n2), .D(n9), .Y(n19) );
  OAI22X1 U10 ( .A(n1), .B(n7), .C(n2), .D(n8), .Y(n21) );
  OAI22X1 U12 ( .A(n1), .B(n6), .C(n2), .D(n7), .Y(n23) );
  OAI22X1 U14 ( .A(n1), .B(n5), .C(n2), .D(n6), .Y(n25) );
  OAI22X1 U16 ( .A(n1), .B(n4), .C(n2), .D(n5), .Y(n27) );
  OAI21X1 U19 ( .A(n2), .B(n4), .C(n11), .Y(n29) );
  NAND2X1 U20 ( .A(serial_in), .B(n2), .Y(n11) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U7 ( .A(shift_enable), .Y(n1) );
  INVX2 U9 ( .A(parallel_out[8]), .Y(n4) );
  INVX2 U11 ( .A(parallel_out[7]), .Y(n5) );
  INVX2 U13 ( .A(parallel_out[6]), .Y(n6) );
  INVX2 U15 ( .A(parallel_out[5]), .Y(n7) );
  INVX2 U17 ( .A(parallel_out[4]), .Y(n8) );
  INVX2 U18 ( .A(parallel_out[3]), .Y(n9) );
  INVX2 U21 ( .A(parallel_out[2]), .Y(n10) );
  INVX2 U31 ( .A(parallel_out[1]), .Y(n30) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, packet_data, stop_bit );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;


  flex_stp_sr U1 ( .clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), 
        .serial_in(serial_in), .parallel_out({stop_bit, packet_data}) );
endmodule


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10, n30, n31, n2, n11, n15, n17, n19,
         n21, n23, n25, n27, n29, n32, n33;

  DFFSR \rx_data_reg[7]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  AOI22X1 U4 ( .A(rx_data[0]), .B(n33), .C(packet_data[0]), .D(n11), .Y(n1) );
  AOI22X1 U6 ( .A(rx_data[1]), .B(n33), .C(packet_data[1]), .D(n11), .Y(n3) );
  AOI22X1 U8 ( .A(rx_data[2]), .B(n33), .C(packet_data[2]), .D(n11), .Y(n4) );
  AOI22X1 U10 ( .A(rx_data[3]), .B(n33), .C(packet_data[3]), .D(n11), .Y(n5)
         );
  AOI22X1 U12 ( .A(rx_data[4]), .B(n33), .C(packet_data[4]), .D(n11), .Y(n6)
         );
  AOI22X1 U14 ( .A(rx_data[5]), .B(n33), .C(packet_data[5]), .D(n11), .Y(n7)
         );
  AOI22X1 U16 ( .A(rx_data[6]), .B(n33), .C(packet_data[6]), .D(n11), .Y(n8)
         );
  AOI22X1 U18 ( .A(rx_data[7]), .B(n33), .C(packet_data[7]), .D(n11), .Y(n9)
         );
  NOR2X1 U19 ( .A(data_read), .B(n10), .Y(n30) );
  AOI21X1 U20 ( .A(data_ready), .B(n11), .C(overrun_error), .Y(n10) );
  OAI21X1 U21 ( .A(data_read), .B(n32), .C(n33), .Y(n31) );
  INVX2 U3 ( .A(load_buffer), .Y(n2) );
  INVX8 U5 ( .A(n11), .Y(n33) );
  INVX8 U7 ( .A(n2), .Y(n11) );
  INVX2 U9 ( .A(n9), .Y(n15) );
  INVX2 U11 ( .A(n8), .Y(n17) );
  INVX2 U13 ( .A(n7), .Y(n19) );
  INVX2 U15 ( .A(n6), .Y(n21) );
  INVX2 U17 ( .A(n5), .Y(n23) );
  INVX2 U22 ( .A(n4), .Y(n25) );
  INVX2 U23 ( .A(n3), .Y(n27) );
  INVX2 U34 ( .A(n1), .Y(n29) );
  INVX2 U35 ( .A(data_ready), .Y(n32) );
endmodule


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected;
  wire   old_sample, new_sample, sync_phase, n4;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U7 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX2 U6 ( .A(old_sample), .Y(n4) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n4, n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U5 ( .A(sbc_clear), .B(n4), .Y(n5) );
  AOI22X1 U6 ( .A(framing_error), .B(n3), .C(sbc_enable), .D(n2), .Y(n4) );
  INVX2 U3 ( .A(stop_bit), .Y(n2) );
  INVX2 U4 ( .A(sbc_enable), .Y(n3) );
endmodule


module rcv_block ( clk, n_rst, serial_in, data_read, rx_data, data_ready, 
        overrun_error, framing_error );
  output [7:0] rx_data;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   start_bit_detected, packet_done, sbc_clear, sbc_enable, load_buffer,
         enable_timer, shift_strobe, stop_bit;
  wire   [7:0] packet_data;

  rcu U1 ( .clk(clk), .n_rst(n_rst), .start_bit_detected(start_bit_detected), 
        .packet_done(packet_done), .framing_error(framing_error), .sbc_clear(
        sbc_clear), .sbc_enable(sbc_enable), .load_buffer(load_buffer), 
        .enable_timer(enable_timer) );
  timer U2 ( .clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), 
        .shift_strobe(shift_strobe), .packet_done(packet_done) );
  sr_9bit U3 ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), 
        .serial_in(serial_in), .packet_data(packet_data), .stop_bit(stop_bit)
         );
  rx_data_buff U4 ( .clk(clk), .n_rst(n_rst), .load_buffer(load_buffer), 
        .packet_data(packet_data), .data_read(data_read), .rx_data(rx_data), 
        .data_ready(data_ready), .overrun_error(overrun_error) );
  start_bit_det U5 ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .start_bit_detected(start_bit_detected) );
  stop_bit_chk U6 ( .clk(clk), .n_rst(n_rst), .sbc_clear(sbc_clear), 
        .sbc_enable(sbc_enable), .stop_bit(stop_bit), .framing_error(
        framing_error) );
endmodule

