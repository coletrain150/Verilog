
module sync_1 ( clk, n_reset, async_in, sync_out );
  input clk, n_reset, async_in;
  output sync_out;
  wire   out_one;

  DFFSR out_one_reg ( .D(async_in), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        out_one) );
  DFFSR sec_out_reg ( .D(out_one), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        sync_out) );
endmodule


module sync_0 ( clk, n_reset, async_in, sync_out );
  input clk, n_reset, async_in;
  output sync_out;
  wire   out_one;

  DFFSR out_one_reg ( .D(async_in), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        out_one) );
  DFFSR sec_out_reg ( .D(out_one), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        sync_out) );
endmodule


module scl_edge ( clk, n_rst, scl, rising_edge_found, falling_edge_found );
  input clk, n_rst, scl;
  output rising_edge_found, falling_edge_found;
  wire   sec_out, third_out, n3, n4;

  DFFSR sec_out_reg ( .D(scl), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sec_out) );
  DFFSR third_out_reg ( .D(sec_out), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        third_out) );
  INVX2 U5 ( .A(third_out), .Y(n3) );
  NOR2X1 U6 ( .A(sec_out), .B(n3), .Y(falling_edge_found) );
  INVX2 U7 ( .A(sec_out), .Y(n4) );
  NOR2X1 U8 ( .A(third_out), .B(n4), .Y(rising_edge_found) );
endmodule


module sda_sel ( tx_out, sda_mode, sda_out );
  input [1:0] sda_mode;
  input tx_out;
  output sda_out;
  wire   n1;

  NAND2X1 U3 ( .A(sda_mode[0]), .B(n1), .Y(sda_out) );
  NAND2X1 U4 ( .A(tx_out), .B(sda_mode[1]), .Y(n1) );
endmodule


module decode ( clk, n_rst, scl, sda_in, starting_byte, rw_mode, address_match, 
        stop_found, start_found );
  input [7:0] starting_byte;
  input clk, n_rst, scl, sda_in;
  output rw_mode, address_match, stop_found, start_found;
  wire   nextstart, nextstop, sda1, sda2, scl1, scl2, n11, n12, n13, n14, n15,
         n16, n17, n18, n8, n9, n10;
  assign rw_mode = starting_byte[0];

  DFFSR match_reg ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(address_match)
         );
  DFFSR sda1_reg ( .D(sda_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sda1) );
  DFFSR sda2_reg ( .D(sda1), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sda2) );
  DFFSR scl1_reg ( .D(scl), .CLK(clk), .R(1'b1), .S(n_rst), .Q(scl1) );
  DFFSR scl2_reg ( .D(scl1), .CLK(clk), .R(1'b1), .S(n_rst), .Q(scl2) );
  DFFSR start_reg ( .D(nextstart), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        start_found) );
  DFFSR stop_reg ( .D(nextstop), .CLK(clk), .R(n_rst), .S(1'b1), .Q(stop_found) );
  NOR2X1 U13 ( .A(n11), .B(n12), .Y(nextstop) );
  NAND2X1 U14 ( .A(sda1), .B(scl2), .Y(n12) );
  NAND2X1 U15 ( .A(scl1), .B(n10), .Y(n11) );
  NOR2X1 U16 ( .A(n13), .B(n14), .Y(nextstart) );
  NAND2X1 U17 ( .A(sda2), .B(scl2), .Y(n14) );
  NAND2X1 U18 ( .A(scl1), .B(n9), .Y(n13) );
  NOR2X1 U19 ( .A(n15), .B(n16), .Y(n18) );
  NAND3X1 U20 ( .A(starting_byte[6]), .B(starting_byte[5]), .C(
        starting_byte[7]), .Y(n16) );
  NAND3X1 U21 ( .A(starting_byte[4]), .B(n8), .C(n17), .Y(n15) );
  NOR2X1 U22 ( .A(starting_byte[3]), .B(starting_byte[2]), .Y(n17) );
  INVX2 U10 ( .A(starting_byte[1]), .Y(n8) );
  INVX2 U11 ( .A(sda1), .Y(n9) );
  INVX2 U12 ( .A(sda2), .Y(n10) );
endmodule


module flex_stp_sr ( clk, n_rst, shift_enable, serial_in, parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n3, n10, n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n4, n5, n6,
         n7, n8, n9, n27;

  DFFSR \data_out_reg[0]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  DFFSR \data_out_reg[1]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \data_out_reg[2]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \data_out_reg[3]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \data_out_reg[4]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \data_out_reg[5]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \data_out_reg[6]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \data_out_reg[7]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  OAI21X1 U2 ( .A(n9), .B(n27), .C(n3), .Y(n12) );
  NAND2X1 U3 ( .A(parallel_out[7]), .B(n27), .Y(n3) );
  OAI22X1 U4 ( .A(n1), .B(n9), .C(n27), .D(n8), .Y(n14) );
  OAI22X1 U6 ( .A(n1), .B(n8), .C(n27), .D(n7), .Y(n16) );
  OAI22X1 U8 ( .A(n1), .B(n7), .C(n27), .D(n6), .Y(n18) );
  OAI22X1 U10 ( .A(n1), .B(n6), .C(n27), .D(n5), .Y(n20) );
  OAI22X1 U12 ( .A(n1), .B(n5), .C(n27), .D(n4), .Y(n22) );
  OAI22X1 U14 ( .A(n1), .B(n4), .C(n27), .D(n2), .Y(n24) );
  OAI21X1 U17 ( .A(n1), .B(n2), .C(n10), .Y(n26) );
  NAND2X1 U18 ( .A(serial_in), .B(n1), .Y(n10) );
  BUFX2 U5 ( .A(shift_enable), .Y(n1) );
  INVX2 U7 ( .A(parallel_out[0]), .Y(n2) );
  INVX2 U9 ( .A(parallel_out[1]), .Y(n4) );
  INVX2 U11 ( .A(parallel_out[2]), .Y(n5) );
  INVX2 U13 ( .A(parallel_out[3]), .Y(n6) );
  INVX2 U15 ( .A(parallel_out[4]), .Y(n7) );
  INVX2 U16 ( .A(parallel_out[5]), .Y(n8) );
  INVX2 U19 ( .A(parallel_out[6]), .Y(n9) );
  INVX2 U28 ( .A(n1), .Y(n27) );
endmodule


module rx_sr ( clk, n_rst, sda_in, rising_edge_found, rx_enable, rx_data );
  output [7:0] rx_data;
  input clk, n_rst, sda_in, rising_edge_found, rx_enable;
  wire   shift, N0;

  DFFSR shift_reg ( .D(N0), .CLK(clk), .R(n_rst), .S(1'b1), .Q(shift) );
  AND2X2 U5 ( .A(rx_enable), .B(rising_edge_found), .Y(N0) );
  flex_stp_sr U1 ( .clk(clk), .n_rst(n_rst), .shift_enable(shift), .serial_in(
        sda_in), .parallel_out(rx_data) );
endmodule


module flex_pts_sr ( clk, n_rst, shift_enable, load_enable, parallel_in, 
        serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n29, n30, n31, n32, n33, n34, n35, n36, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46;
  wire   [6:0] temp;

  DFFSR \temp_reg[0]  ( .D(n36), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[0])
         );
  DFFSR \temp_reg[1]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[1])
         );
  DFFSR \temp_reg[2]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[2])
         );
  DFFSR \temp_reg[3]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[3])
         );
  DFFSR \temp_reg[4]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[4])
         );
  DFFSR \temp_reg[5]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[5])
         );
  DFFSR \temp_reg[6]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp[6])
         );
  DFFSR \temp_reg[7]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(serial_out) );
  AND2X2 U10 ( .A(shift_enable), .B(n13), .Y(n9) );
  NAND2X1 U11 ( .A(shift_enable), .B(n13), .Y(n10) );
  INVX2 U12 ( .A(load_enable), .Y(n13) );
  AND2X2 U13 ( .A(n17), .B(n13), .Y(n11) );
  INVX1 U14 ( .A(n12), .Y(n16) );
  AND2X2 U15 ( .A(n10), .B(n13), .Y(n12) );
  NAND2X1 U16 ( .A(shift_enable), .B(n13), .Y(n17) );
  INVX2 U17 ( .A(temp[0]), .Y(n15) );
  NAND2X1 U18 ( .A(parallel_in[0]), .B(load_enable), .Y(n14) );
  OAI21X1 U19 ( .A(n16), .B(n15), .C(n14), .Y(n36) );
  NAND2X1 U20 ( .A(temp[1]), .B(n11), .Y(n20) );
  NAND2X1 U21 ( .A(temp[0]), .B(n9), .Y(n19) );
  NAND2X1 U22 ( .A(parallel_in[1]), .B(load_enable), .Y(n18) );
  NAND3X1 U23 ( .A(n20), .B(n19), .C(n18), .Y(n35) );
  NAND2X1 U24 ( .A(temp[2]), .B(n12), .Y(n23) );
  NAND2X1 U25 ( .A(temp[1]), .B(n9), .Y(n22) );
  NAND2X1 U26 ( .A(parallel_in[2]), .B(load_enable), .Y(n21) );
  NAND3X1 U27 ( .A(n23), .B(n22), .C(n21), .Y(n34) );
  NAND2X1 U28 ( .A(temp[3]), .B(n11), .Y(n26) );
  NAND2X1 U29 ( .A(temp[2]), .B(n9), .Y(n25) );
  NAND2X1 U30 ( .A(parallel_in[3]), .B(load_enable), .Y(n24) );
  NAND3X1 U31 ( .A(n26), .B(n25), .C(n24), .Y(n33) );
  NAND2X1 U32 ( .A(temp[4]), .B(n12), .Y(n37) );
  NAND2X1 U33 ( .A(temp[3]), .B(n9), .Y(n28) );
  NAND2X1 U34 ( .A(parallel_in[4]), .B(load_enable), .Y(n27) );
  NAND3X1 U35 ( .A(n37), .B(n28), .C(n27), .Y(n32) );
  NAND2X1 U36 ( .A(temp[5]), .B(n11), .Y(n40) );
  NAND2X1 U37 ( .A(temp[4]), .B(n9), .Y(n39) );
  NAND2X1 U38 ( .A(parallel_in[5]), .B(load_enable), .Y(n38) );
  NAND3X1 U39 ( .A(n40), .B(n39), .C(n38), .Y(n31) );
  NAND2X1 U40 ( .A(temp[6]), .B(n12), .Y(n43) );
  NAND2X1 U41 ( .A(temp[5]), .B(n9), .Y(n42) );
  NAND2X1 U42 ( .A(parallel_in[6]), .B(load_enable), .Y(n41) );
  NAND3X1 U43 ( .A(n43), .B(n42), .C(n41), .Y(n30) );
  NAND2X1 U44 ( .A(serial_out), .B(n11), .Y(n46) );
  NAND2X1 U45 ( .A(temp[6]), .B(n9), .Y(n45) );
  NAND2X1 U46 ( .A(parallel_in[7]), .B(load_enable), .Y(n44) );
  NAND3X1 U47 ( .A(n46), .B(n45), .C(n44), .Y(n29) );
endmodule


module tx_sr ( clk, n_rst, tx_data, falling_edge_found, tx_enable, load_data, 
        tx_out );
  input [7:0] tx_data;
  input clk, n_rst, falling_edge_found, tx_enable, load_data;
  output tx_out;
  wire   shift, N0;

  DFFSR shift_reg ( .D(N0), .CLK(clk), .R(n_rst), .S(1'b1), .Q(shift) );
  AND2X2 U5 ( .A(tx_enable), .B(falling_edge_found), .Y(N0) );
  flex_pts_sr U1 ( .clk(clk), .n_rst(n_rst), .shift_enable(shift), 
        .load_enable(load_data), .parallel_in(tx_data), .serial_out(tx_out) );
endmodule


module fiforam ( wclk, wenable, waddr, raddr, wdata, rdata );
  input [2:0] waddr;
  input [2:0] raddr;
  input [7:0] wdata;
  output [7:0] rdata;
  input wclk, wenable;
  wire   \fiforeg[0][7] , \fiforeg[0][6] , \fiforeg[0][5] , \fiforeg[0][4] ,
         \fiforeg[0][3] , \fiforeg[0][2] , \fiforeg[0][1] , \fiforeg[0][0] ,
         \fiforeg[1][7] , \fiforeg[1][6] , \fiforeg[1][5] , \fiforeg[1][4] ,
         \fiforeg[1][3] , \fiforeg[1][2] , \fiforeg[1][1] , \fiforeg[1][0] ,
         \fiforeg[2][7] , \fiforeg[2][6] , \fiforeg[2][5] , \fiforeg[2][4] ,
         \fiforeg[2][3] , \fiforeg[2][2] , \fiforeg[2][1] , \fiforeg[2][0] ,
         \fiforeg[3][7] , \fiforeg[3][6] , \fiforeg[3][5] , \fiforeg[3][4] ,
         \fiforeg[3][3] , \fiforeg[3][2] , \fiforeg[3][1] , \fiforeg[3][0] ,
         \fiforeg[4][7] , \fiforeg[4][6] , \fiforeg[4][5] , \fiforeg[4][4] ,
         \fiforeg[4][3] , \fiforeg[4][2] , \fiforeg[4][1] , \fiforeg[4][0] ,
         \fiforeg[5][7] , \fiforeg[5][6] , \fiforeg[5][5] , \fiforeg[5][4] ,
         \fiforeg[5][3] , \fiforeg[5][2] , \fiforeg[5][1] , \fiforeg[5][0] ,
         \fiforeg[6][7] , \fiforeg[6][6] , \fiforeg[6][5] , \fiforeg[6][4] ,
         \fiforeg[6][3] , \fiforeg[6][2] , \fiforeg[6][1] , \fiforeg[6][0] ,
         \fiforeg[7][7] , \fiforeg[7][6] , \fiforeg[7][5] , \fiforeg[7][4] ,
         \fiforeg[7][3] , \fiforeg[7][2] , \fiforeg[7][1] , \fiforeg[7][0] ,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n1,
         n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330;

  DFFPOSX1 \fiforeg_reg[7][7]  ( .D(n212), .CLK(wclk), .Q(\fiforeg[7][7] ) );
  DFFPOSX1 \fiforeg_reg[6][7]  ( .D(n213), .CLK(wclk), .Q(\fiforeg[6][7] ) );
  DFFPOSX1 \fiforeg_reg[5][7]  ( .D(n214), .CLK(wclk), .Q(\fiforeg[5][7] ) );
  DFFPOSX1 \fiforeg_reg[4][7]  ( .D(n215), .CLK(wclk), .Q(\fiforeg[4][7] ) );
  DFFPOSX1 \fiforeg_reg[3][7]  ( .D(n216), .CLK(wclk), .Q(\fiforeg[3][7] ) );
  DFFPOSX1 \fiforeg_reg[2][7]  ( .D(n217), .CLK(wclk), .Q(\fiforeg[2][7] ) );
  DFFPOSX1 \fiforeg_reg[1][7]  ( .D(n218), .CLK(wclk), .Q(\fiforeg[1][7] ) );
  DFFPOSX1 \fiforeg_reg[0][7]  ( .D(n219), .CLK(wclk), .Q(\fiforeg[0][7] ) );
  DFFPOSX1 \fiforeg_reg[7][6]  ( .D(n220), .CLK(wclk), .Q(\fiforeg[7][6] ) );
  DFFPOSX1 \fiforeg_reg[6][6]  ( .D(n221), .CLK(wclk), .Q(\fiforeg[6][6] ) );
  DFFPOSX1 \fiforeg_reg[5][6]  ( .D(n222), .CLK(wclk), .Q(\fiforeg[5][6] ) );
  DFFPOSX1 \fiforeg_reg[4][6]  ( .D(n223), .CLK(wclk), .Q(\fiforeg[4][6] ) );
  DFFPOSX1 \fiforeg_reg[3][6]  ( .D(n224), .CLK(wclk), .Q(\fiforeg[3][6] ) );
  DFFPOSX1 \fiforeg_reg[2][6]  ( .D(n225), .CLK(wclk), .Q(\fiforeg[2][6] ) );
  DFFPOSX1 \fiforeg_reg[1][6]  ( .D(n226), .CLK(wclk), .Q(\fiforeg[1][6] ) );
  DFFPOSX1 \fiforeg_reg[0][6]  ( .D(n227), .CLK(wclk), .Q(\fiforeg[0][6] ) );
  DFFPOSX1 \fiforeg_reg[7][5]  ( .D(n228), .CLK(wclk), .Q(\fiforeg[7][5] ) );
  DFFPOSX1 \fiforeg_reg[6][5]  ( .D(n229), .CLK(wclk), .Q(\fiforeg[6][5] ) );
  DFFPOSX1 \fiforeg_reg[5][5]  ( .D(n230), .CLK(wclk), .Q(\fiforeg[5][5] ) );
  DFFPOSX1 \fiforeg_reg[4][5]  ( .D(n231), .CLK(wclk), .Q(\fiforeg[4][5] ) );
  DFFPOSX1 \fiforeg_reg[3][5]  ( .D(n232), .CLK(wclk), .Q(\fiforeg[3][5] ) );
  DFFPOSX1 \fiforeg_reg[2][5]  ( .D(n233), .CLK(wclk), .Q(\fiforeg[2][5] ) );
  DFFPOSX1 \fiforeg_reg[1][5]  ( .D(n234), .CLK(wclk), .Q(\fiforeg[1][5] ) );
  DFFPOSX1 \fiforeg_reg[0][5]  ( .D(n235), .CLK(wclk), .Q(\fiforeg[0][5] ) );
  DFFPOSX1 \fiforeg_reg[7][4]  ( .D(n236), .CLK(wclk), .Q(\fiforeg[7][4] ) );
  DFFPOSX1 \fiforeg_reg[6][4]  ( .D(n237), .CLK(wclk), .Q(\fiforeg[6][4] ) );
  DFFPOSX1 \fiforeg_reg[5][4]  ( .D(n238), .CLK(wclk), .Q(\fiforeg[5][4] ) );
  DFFPOSX1 \fiforeg_reg[4][4]  ( .D(n239), .CLK(wclk), .Q(\fiforeg[4][4] ) );
  DFFPOSX1 \fiforeg_reg[3][4]  ( .D(n240), .CLK(wclk), .Q(\fiforeg[3][4] ) );
  DFFPOSX1 \fiforeg_reg[2][4]  ( .D(n241), .CLK(wclk), .Q(\fiforeg[2][4] ) );
  DFFPOSX1 \fiforeg_reg[1][4]  ( .D(n242), .CLK(wclk), .Q(\fiforeg[1][4] ) );
  DFFPOSX1 \fiforeg_reg[0][4]  ( .D(n243), .CLK(wclk), .Q(\fiforeg[0][4] ) );
  DFFPOSX1 \fiforeg_reg[7][3]  ( .D(n244), .CLK(wclk), .Q(\fiforeg[7][3] ) );
  DFFPOSX1 \fiforeg_reg[6][3]  ( .D(n245), .CLK(wclk), .Q(\fiforeg[6][3] ) );
  DFFPOSX1 \fiforeg_reg[5][3]  ( .D(n246), .CLK(wclk), .Q(\fiforeg[5][3] ) );
  DFFPOSX1 \fiforeg_reg[4][3]  ( .D(n247), .CLK(wclk), .Q(\fiforeg[4][3] ) );
  DFFPOSX1 \fiforeg_reg[3][3]  ( .D(n248), .CLK(wclk), .Q(\fiforeg[3][3] ) );
  DFFPOSX1 \fiforeg_reg[2][3]  ( .D(n249), .CLK(wclk), .Q(\fiforeg[2][3] ) );
  DFFPOSX1 \fiforeg_reg[1][3]  ( .D(n250), .CLK(wclk), .Q(\fiforeg[1][3] ) );
  DFFPOSX1 \fiforeg_reg[0][3]  ( .D(n251), .CLK(wclk), .Q(\fiforeg[0][3] ) );
  DFFPOSX1 \fiforeg_reg[7][2]  ( .D(n252), .CLK(wclk), .Q(\fiforeg[7][2] ) );
  DFFPOSX1 \fiforeg_reg[6][2]  ( .D(n253), .CLK(wclk), .Q(\fiforeg[6][2] ) );
  DFFPOSX1 \fiforeg_reg[5][2]  ( .D(n254), .CLK(wclk), .Q(\fiforeg[5][2] ) );
  DFFPOSX1 \fiforeg_reg[4][2]  ( .D(n255), .CLK(wclk), .Q(\fiforeg[4][2] ) );
  DFFPOSX1 \fiforeg_reg[3][2]  ( .D(n256), .CLK(wclk), .Q(\fiforeg[3][2] ) );
  DFFPOSX1 \fiforeg_reg[2][2]  ( .D(n257), .CLK(wclk), .Q(\fiforeg[2][2] ) );
  DFFPOSX1 \fiforeg_reg[1][2]  ( .D(n258), .CLK(wclk), .Q(\fiforeg[1][2] ) );
  DFFPOSX1 \fiforeg_reg[0][2]  ( .D(n259), .CLK(wclk), .Q(\fiforeg[0][2] ) );
  DFFPOSX1 \fiforeg_reg[7][1]  ( .D(n260), .CLK(wclk), .Q(\fiforeg[7][1] ) );
  DFFPOSX1 \fiforeg_reg[6][1]  ( .D(n261), .CLK(wclk), .Q(\fiforeg[6][1] ) );
  DFFPOSX1 \fiforeg_reg[5][1]  ( .D(n262), .CLK(wclk), .Q(\fiforeg[5][1] ) );
  DFFPOSX1 \fiforeg_reg[4][1]  ( .D(n263), .CLK(wclk), .Q(\fiforeg[4][1] ) );
  DFFPOSX1 \fiforeg_reg[3][1]  ( .D(n264), .CLK(wclk), .Q(\fiforeg[3][1] ) );
  DFFPOSX1 \fiforeg_reg[2][1]  ( .D(n265), .CLK(wclk), .Q(\fiforeg[2][1] ) );
  DFFPOSX1 \fiforeg_reg[1][1]  ( .D(n266), .CLK(wclk), .Q(\fiforeg[1][1] ) );
  DFFPOSX1 \fiforeg_reg[0][1]  ( .D(n267), .CLK(wclk), .Q(\fiforeg[0][1] ) );
  DFFPOSX1 \fiforeg_reg[7][0]  ( .D(n275), .CLK(wclk), .Q(\fiforeg[7][0] ) );
  DFFPOSX1 \fiforeg_reg[6][0]  ( .D(n268), .CLK(wclk), .Q(\fiforeg[6][0] ) );
  DFFPOSX1 \fiforeg_reg[5][0]  ( .D(n269), .CLK(wclk), .Q(\fiforeg[5][0] ) );
  DFFPOSX1 \fiforeg_reg[4][0]  ( .D(n270), .CLK(wclk), .Q(\fiforeg[4][0] ) );
  DFFPOSX1 \fiforeg_reg[3][0]  ( .D(n271), .CLK(wclk), .Q(\fiforeg[3][0] ) );
  DFFPOSX1 \fiforeg_reg[2][0]  ( .D(n272), .CLK(wclk), .Q(\fiforeg[2][0] ) );
  DFFPOSX1 \fiforeg_reg[1][0]  ( .D(n273), .CLK(wclk), .Q(\fiforeg[1][0] ) );
  DFFPOSX1 \fiforeg_reg[0][0]  ( .D(n274), .CLK(wclk), .Q(\fiforeg[0][0] ) );
  NAND3X1 U93 ( .A(n92), .B(n93), .C(n94), .Y(rdata[7]) );
  NOR2X1 U94 ( .A(n95), .B(n96), .Y(n94) );
  NAND3X1 U99 ( .A(n101), .B(n102), .C(n103), .Y(rdata[6]) );
  NOR2X1 U100 ( .A(n104), .B(n105), .Y(n103) );
  NAND3X1 U105 ( .A(n106), .B(n107), .C(n108), .Y(rdata[5]) );
  NOR2X1 U106 ( .A(n109), .B(n110), .Y(n108) );
  NAND3X1 U111 ( .A(n111), .B(n112), .C(n113), .Y(rdata[4]) );
  NOR2X1 U112 ( .A(n114), .B(n115), .Y(n113) );
  NAND3X1 U117 ( .A(n116), .B(n117), .C(n118), .Y(rdata[3]) );
  NOR2X1 U118 ( .A(n119), .B(n120), .Y(n118) );
  NAND3X1 U123 ( .A(n121), .B(n122), .C(n123), .Y(rdata[2]) );
  NOR2X1 U124 ( .A(n124), .B(n125), .Y(n123) );
  NAND3X1 U129 ( .A(n126), .B(n127), .C(n128), .Y(rdata[1]) );
  NOR2X1 U130 ( .A(n129), .B(n130), .Y(n128) );
  NAND3X1 U135 ( .A(n131), .B(n132), .C(n133), .Y(rdata[0]) );
  NOR2X1 U136 ( .A(n134), .B(n135), .Y(n133) );
  NAND3X1 U138 ( .A(raddr[0]), .B(n329), .C(raddr[2]), .Y(n98) );
  NAND3X1 U139 ( .A(n330), .B(n329), .C(raddr[2]), .Y(n97) );
  NAND3X1 U141 ( .A(raddr[1]), .B(raddr[0]), .C(raddr[2]), .Y(n100) );
  NAND3X1 U142 ( .A(raddr[1]), .B(n330), .C(raddr[2]), .Y(n99) );
  NAND3X1 U144 ( .A(n330), .B(n328), .C(raddr[1]), .Y(n136) );
  NAND3X1 U145 ( .A(raddr[0]), .B(n328), .C(raddr[1]), .Y(n137) );
  NAND3X1 U147 ( .A(n329), .B(n328), .C(n330), .Y(n138) );
  NAND3X1 U148 ( .A(n329), .B(n328), .C(raddr[0]), .Y(n139) );
  INVX2 U2 ( .A(n59), .Y(n1) );
  INVX4 U3 ( .A(n1), .Y(n2) );
  BUFX4 U4 ( .A(n308), .Y(n3) );
  BUFX4 U5 ( .A(n60), .Y(n4) );
  INVX8 U6 ( .A(n4), .Y(n312) );
  INVX8 U7 ( .A(n54), .Y(n55) );
  INVX4 U8 ( .A(n299), .Y(n54) );
  INVX8 U9 ( .A(n2), .Y(n308) );
  INVX4 U10 ( .A(n294), .Y(n46) );
  BUFX2 U11 ( .A(wenable), .Y(n42) );
  NOR2X1 U12 ( .A(n56), .B(n57), .Y(n5) );
  INVX2 U13 ( .A(waddr[0]), .Y(n6) );
  INVX2 U14 ( .A(waddr[0]), .Y(n7) );
  INVX1 U15 ( .A(waddr[0]), .Y(n62) );
  INVX4 U16 ( .A(n58), .Y(n8) );
  INVX4 U17 ( .A(n8), .Y(n9) );
  NAND2X1 U18 ( .A(n284), .B(n283), .Y(n10) );
  NAND2X1 U19 ( .A(n284), .B(n283), .Y(n11) );
  NAND2X1 U20 ( .A(n186), .B(n185), .Y(n12) );
  NAND2X1 U21 ( .A(n186), .B(n185), .Y(n13) );
  NAND2X1 U22 ( .A(n152), .B(n151), .Y(n14) );
  NAND2X1 U23 ( .A(n152), .B(n151), .Y(n15) );
  INVX4 U24 ( .A(n48), .Y(n16) );
  INVX4 U25 ( .A(n48), .Y(n49) );
  INVX2 U26 ( .A(waddr[1]), .Y(n17) );
  INVX2 U27 ( .A(waddr[1]), .Y(n63) );
  NAND3X1 U28 ( .A(n66), .B(n67), .C(n65), .Y(n18) );
  NAND2X1 U29 ( .A(n69), .B(n18), .Y(n19) );
  NAND2X1 U30 ( .A(n70), .B(n69), .Y(n20) );
  NAND2X1 U31 ( .A(n203), .B(n202), .Y(n21) );
  NAND2X1 U32 ( .A(n203), .B(n202), .Y(n22) );
  NAND2X1 U33 ( .A(n169), .B(n168), .Y(n23) );
  NAND2X1 U34 ( .A(n169), .B(n168), .Y(n24) );
  NAND2X1 U35 ( .A(n87), .B(n86), .Y(n25) );
  NAND2X1 U36 ( .A(n87), .B(n86), .Y(n26) );
  NAND2X1 U37 ( .A(n69), .B(n18), .Y(n27) );
  NAND2X1 U38 ( .A(n70), .B(n69), .Y(n28) );
  INVX4 U39 ( .A(waddr[2]), .Y(n61) );
  INVX4 U40 ( .A(n46), .Y(n29) );
  INVX4 U41 ( .A(n46), .Y(n47) );
  INVX8 U42 ( .A(n9), .Y(n310) );
  NAND2X1 U43 ( .A(n284), .B(n283), .Y(n30) );
  NAND2X1 U44 ( .A(n284), .B(n283), .Y(n31) );
  NAND2X1 U45 ( .A(n203), .B(n202), .Y(n32) );
  NAND2X1 U46 ( .A(n203), .B(n202), .Y(n33) );
  NAND2X1 U47 ( .A(n186), .B(n185), .Y(n34) );
  NAND2X1 U48 ( .A(n186), .B(n185), .Y(n35) );
  NAND2X1 U49 ( .A(n169), .B(n168), .Y(n36) );
  NAND2X1 U50 ( .A(n169), .B(n168), .Y(n37) );
  NAND2X1 U51 ( .A(n152), .B(n151), .Y(n38) );
  NAND2X1 U52 ( .A(n152), .B(n151), .Y(n39) );
  NAND2X1 U53 ( .A(n87), .B(n86), .Y(n40) );
  NAND2X1 U54 ( .A(n87), .B(n86), .Y(n41) );
  INVX4 U55 ( .A(n300), .Y(n52) );
  INVX4 U56 ( .A(n293), .Y(n48) );
  NAND2X1 U57 ( .A(n307), .B(n306), .Y(n43) );
  NAND2X1 U58 ( .A(n307), .B(n306), .Y(n44) );
  INVX2 U59 ( .A(wenable), .Y(n295) );
  NAND2X1 U60 ( .A(n307), .B(n306), .Y(n45) );
  INVX4 U61 ( .A(n296), .Y(n50) );
  INVX8 U62 ( .A(n50), .Y(n51) );
  INVX8 U63 ( .A(n52), .Y(n53) );
  INVX2 U64 ( .A(\fiforeg[1][0] ), .Y(n71) );
  NAND3X1 U65 ( .A(waddr[2]), .B(waddr[0]), .C(n17), .Y(n294) );
  INVX2 U66 ( .A(\fiforeg[5][0] ), .Y(n77) );
  NAND3X1 U67 ( .A(waddr[1]), .B(n7), .C(waddr[2]), .Y(n293) );
  INVX2 U68 ( .A(\fiforeg[6][0] ), .Y(n76) );
  OAI22X1 U69 ( .A(n77), .B(n47), .C(n16), .D(n76), .Y(n57) );
  NAND3X1 U70 ( .A(waddr[2]), .B(waddr[1]), .C(waddr[0]), .Y(n296) );
  INVX2 U71 ( .A(\fiforeg[7][0] ), .Y(n75) );
  OAI21X1 U72 ( .A(n51), .B(n75), .C(n295), .Y(n56) );
  NOR2X1 U73 ( .A(n56), .B(n57), .Y(n67) );
  NAND3X1 U74 ( .A(n63), .B(n6), .C(n61), .Y(n58) );
  NAND3X1 U75 ( .A(waddr[0]), .B(n63), .C(n61), .Y(n59) );
  AOI22X1 U76 ( .A(\fiforeg[0][0] ), .B(n8), .C(\fiforeg[1][0] ), .D(n308), 
        .Y(n66) );
  NAND3X1 U77 ( .A(waddr[1]), .B(n6), .C(n61), .Y(n60) );
  NAND3X1 U78 ( .A(waddr[1]), .B(n61), .C(waddr[0]), .Y(n300) );
  INVX2 U79 ( .A(\fiforeg[3][0] ), .Y(n74) );
  NAND3X1 U80 ( .A(n17), .B(waddr[2]), .C(n62), .Y(n299) );
  INVX2 U81 ( .A(\fiforeg[4][0] ), .Y(n78) );
  OAI22X1 U82 ( .A(n53), .B(n74), .C(n55), .D(n78), .Y(n64) );
  AOI21X1 U83 ( .A(\fiforeg[2][0] ), .B(n312), .C(n64), .Y(n65) );
  NAND3X1 U84 ( .A(n66), .B(n5), .C(n65), .Y(n70) );
  INVX2 U85 ( .A(wdata[0]), .Y(n68) );
  NAND2X1 U86 ( .A(n42), .B(n68), .Y(n69) );
  MUX2X1 U87 ( .B(n71), .A(n20), .S(n3), .Y(n273) );
  INVX2 U88 ( .A(\fiforeg[0][0] ), .Y(n72) );
  MUX2X1 U89 ( .B(n72), .A(n20), .S(n310), .Y(n274) );
  INVX2 U90 ( .A(\fiforeg[2][0] ), .Y(n73) );
  MUX2X1 U91 ( .B(n73), .A(n19), .S(n312), .Y(n272) );
  INVX2 U92 ( .A(n55), .Y(n314) );
  MUX2X1 U95 ( .B(n78), .A(n19), .S(n314), .Y(n270) );
  INVX2 U96 ( .A(n53), .Y(n315) );
  MUX2X1 U97 ( .B(n74), .A(n27), .S(n315), .Y(n271) );
  INVX2 U98 ( .A(n51), .Y(n317) );
  MUX2X1 U101 ( .B(n75), .A(n27), .S(n317), .Y(n275) );
  INVX2 U102 ( .A(n47), .Y(n318) );
  MUX2X1 U103 ( .B(n77), .A(n28), .S(n318), .Y(n269) );
  INVX2 U104 ( .A(n16), .Y(n319) );
  MUX2X1 U107 ( .B(n76), .A(n28), .S(n319), .Y(n268) );
  OAI22X1 U108 ( .A(n99), .B(n76), .C(n100), .D(n75), .Y(n134) );
  OAI22X1 U109 ( .A(n97), .B(n78), .C(n98), .D(n77), .Y(n135) );
  AOI22X1 U110 ( .A(\fiforeg[0][0] ), .B(n325), .C(\fiforeg[1][0] ), .D(n324), 
        .Y(n131) );
  AOI22X1 U113 ( .A(\fiforeg[2][0] ), .B(n327), .C(\fiforeg[3][0] ), .D(n326), 
        .Y(n132) );
  INVX2 U114 ( .A(\fiforeg[1][1] ), .Y(n88) );
  INVX2 U115 ( .A(\fiforeg[5][1] ), .Y(n142) );
  INVX2 U116 ( .A(\fiforeg[6][1] ), .Y(n141) );
  OAI22X1 U119 ( .A(n47), .B(n142), .C(n16), .D(n141), .Y(n80) );
  INVX2 U120 ( .A(\fiforeg[7][1] ), .Y(n140) );
  OAI21X1 U121 ( .A(n51), .B(n140), .C(n295), .Y(n79) );
  NOR2X1 U122 ( .A(n79), .B(n80), .Y(n84) );
  AOI22X1 U125 ( .A(\fiforeg[0][1] ), .B(n8), .C(\fiforeg[1][1] ), .D(n308), 
        .Y(n83) );
  INVX2 U126 ( .A(\fiforeg[3][1] ), .Y(n91) );
  INVX2 U127 ( .A(\fiforeg[4][1] ), .Y(n143) );
  OAI22X1 U128 ( .A(n53), .B(n91), .C(n55), .D(n143), .Y(n81) );
  AOI21X1 U131 ( .A(\fiforeg[2][1] ), .B(n312), .C(n81), .Y(n82) );
  NAND3X1 U132 ( .A(n83), .B(n84), .C(n82), .Y(n87) );
  INVX2 U133 ( .A(wdata[1]), .Y(n85) );
  NAND2X1 U134 ( .A(n42), .B(n85), .Y(n86) );
  MUX2X1 U137 ( .B(n88), .A(n26), .S(n308), .Y(n266) );
  INVX2 U140 ( .A(\fiforeg[0][1] ), .Y(n89) );
  MUX2X1 U143 ( .B(n89), .A(n26), .S(n8), .Y(n267) );
  INVX2 U146 ( .A(\fiforeg[2][1] ), .Y(n90) );
  MUX2X1 U149 ( .B(n90), .A(n25), .S(n312), .Y(n265) );
  MUX2X1 U150 ( .B(n143), .A(n25), .S(n314), .Y(n263) );
  MUX2X1 U151 ( .B(n91), .A(n41), .S(n315), .Y(n264) );
  MUX2X1 U152 ( .B(n140), .A(n41), .S(n317), .Y(n260) );
  MUX2X1 U153 ( .B(n142), .A(n40), .S(n318), .Y(n262) );
  MUX2X1 U154 ( .B(n141), .A(n40), .S(n319), .Y(n261) );
  OAI22X1 U155 ( .A(n99), .B(n141), .C(n100), .D(n140), .Y(n129) );
  OAI22X1 U156 ( .A(n97), .B(n143), .C(n98), .D(n142), .Y(n130) );
  AOI22X1 U157 ( .A(\fiforeg[0][1] ), .B(n325), .C(\fiforeg[1][1] ), .D(n324), 
        .Y(n126) );
  AOI22X1 U158 ( .A(\fiforeg[2][1] ), .B(n327), .C(\fiforeg[3][1] ), .D(n326), 
        .Y(n127) );
  INVX2 U159 ( .A(\fiforeg[1][2] ), .Y(n153) );
  INVX2 U160 ( .A(\fiforeg[5][2] ), .Y(n159) );
  INVX2 U161 ( .A(\fiforeg[6][2] ), .Y(n158) );
  OAI22X1 U162 ( .A(n29), .B(n159), .C(n49), .D(n158), .Y(n145) );
  INVX2 U163 ( .A(\fiforeg[7][2] ), .Y(n157) );
  OAI21X1 U164 ( .A(n51), .B(n157), .C(n295), .Y(n144) );
  NOR2X1 U165 ( .A(n144), .B(n145), .Y(n149) );
  AOI22X1 U166 ( .A(\fiforeg[0][2] ), .B(n8), .C(\fiforeg[1][2] ), .D(n308), 
        .Y(n148) );
  INVX2 U167 ( .A(\fiforeg[3][2] ), .Y(n156) );
  INVX2 U168 ( .A(\fiforeg[4][2] ), .Y(n160) );
  OAI22X1 U169 ( .A(n53), .B(n156), .C(n55), .D(n160), .Y(n146) );
  AOI21X1 U170 ( .A(\fiforeg[2][2] ), .B(n312), .C(n146), .Y(n147) );
  NAND3X1 U171 ( .A(n149), .B(n148), .C(n147), .Y(n152) );
  INVX2 U172 ( .A(wdata[2]), .Y(n150) );
  NAND2X1 U173 ( .A(n42), .B(n150), .Y(n151) );
  MUX2X1 U174 ( .B(n153), .A(n15), .S(n308), .Y(n258) );
  INVX2 U175 ( .A(\fiforeg[0][2] ), .Y(n154) );
  MUX2X1 U176 ( .B(n154), .A(n15), .S(n8), .Y(n259) );
  INVX2 U177 ( .A(\fiforeg[2][2] ), .Y(n155) );
  MUX2X1 U178 ( .B(n155), .A(n14), .S(n312), .Y(n257) );
  MUX2X1 U179 ( .B(n160), .A(n14), .S(n314), .Y(n255) );
  MUX2X1 U180 ( .B(n156), .A(n38), .S(n315), .Y(n256) );
  MUX2X1 U181 ( .B(n157), .A(n38), .S(n317), .Y(n252) );
  MUX2X1 U182 ( .B(n159), .A(n39), .S(n318), .Y(n254) );
  MUX2X1 U183 ( .B(n158), .A(n39), .S(n319), .Y(n253) );
  OAI22X1 U184 ( .A(n99), .B(n158), .C(n100), .D(n157), .Y(n124) );
  OAI22X1 U185 ( .A(n97), .B(n160), .C(n98), .D(n159), .Y(n125) );
  AOI22X1 U186 ( .A(\fiforeg[0][2] ), .B(n325), .C(\fiforeg[1][2] ), .D(n324), 
        .Y(n121) );
  AOI22X1 U187 ( .A(\fiforeg[2][2] ), .B(n327), .C(\fiforeg[3][2] ), .D(n326), 
        .Y(n122) );
  INVX2 U188 ( .A(\fiforeg[1][3] ), .Y(n170) );
  INVX2 U189 ( .A(\fiforeg[5][3] ), .Y(n176) );
  INVX2 U190 ( .A(\fiforeg[6][3] ), .Y(n175) );
  OAI22X1 U191 ( .A(n47), .B(n176), .C(n16), .D(n175), .Y(n162) );
  INVX2 U192 ( .A(\fiforeg[7][3] ), .Y(n174) );
  OAI21X1 U193 ( .A(n51), .B(n174), .C(n295), .Y(n161) );
  NOR2X1 U194 ( .A(n161), .B(n162), .Y(n166) );
  AOI22X1 U195 ( .A(\fiforeg[0][3] ), .B(n8), .C(\fiforeg[1][3] ), .D(n308), 
        .Y(n165) );
  INVX2 U196 ( .A(\fiforeg[3][3] ), .Y(n173) );
  INVX2 U197 ( .A(\fiforeg[4][3] ), .Y(n177) );
  OAI22X1 U198 ( .A(n53), .B(n173), .C(n55), .D(n177), .Y(n163) );
  AOI21X1 U199 ( .A(\fiforeg[2][3] ), .B(n312), .C(n163), .Y(n164) );
  NAND3X1 U200 ( .A(n165), .B(n166), .C(n164), .Y(n169) );
  INVX2 U201 ( .A(wdata[3]), .Y(n167) );
  NAND2X1 U202 ( .A(n42), .B(n167), .Y(n168) );
  MUX2X1 U203 ( .B(n170), .A(n24), .S(n3), .Y(n250) );
  INVX2 U204 ( .A(\fiforeg[0][3] ), .Y(n171) );
  MUX2X1 U205 ( .B(n171), .A(n24), .S(n310), .Y(n251) );
  INVX2 U206 ( .A(\fiforeg[2][3] ), .Y(n172) );
  MUX2X1 U207 ( .B(n172), .A(n23), .S(n312), .Y(n249) );
  MUX2X1 U208 ( .B(n177), .A(n23), .S(n314), .Y(n247) );
  MUX2X1 U209 ( .B(n173), .A(n37), .S(n315), .Y(n248) );
  MUX2X1 U210 ( .B(n174), .A(n37), .S(n317), .Y(n244) );
  MUX2X1 U211 ( .B(n176), .A(n36), .S(n318), .Y(n246) );
  MUX2X1 U212 ( .B(n175), .A(n36), .S(n319), .Y(n245) );
  OAI22X1 U213 ( .A(n99), .B(n175), .C(n100), .D(n174), .Y(n119) );
  OAI22X1 U214 ( .A(n97), .B(n177), .C(n98), .D(n176), .Y(n120) );
  AOI22X1 U215 ( .A(\fiforeg[0][3] ), .B(n325), .C(\fiforeg[1][3] ), .D(n324), 
        .Y(n116) );
  AOI22X1 U216 ( .A(\fiforeg[2][3] ), .B(n327), .C(\fiforeg[3][3] ), .D(n326), 
        .Y(n117) );
  INVX2 U217 ( .A(\fiforeg[1][4] ), .Y(n187) );
  INVX2 U218 ( .A(\fiforeg[5][4] ), .Y(n193) );
  INVX2 U219 ( .A(\fiforeg[6][4] ), .Y(n192) );
  OAI22X1 U220 ( .A(n29), .B(n193), .C(n49), .D(n192), .Y(n179) );
  INVX2 U221 ( .A(\fiforeg[7][4] ), .Y(n191) );
  OAI21X1 U222 ( .A(n51), .B(n191), .C(n295), .Y(n178) );
  NOR2X1 U223 ( .A(n178), .B(n179), .Y(n183) );
  AOI22X1 U224 ( .A(\fiforeg[0][4] ), .B(n8), .C(\fiforeg[1][4] ), .D(n308), 
        .Y(n182) );
  INVX2 U225 ( .A(\fiforeg[3][4] ), .Y(n190) );
  INVX2 U226 ( .A(\fiforeg[4][4] ), .Y(n194) );
  OAI22X1 U227 ( .A(n53), .B(n190), .C(n55), .D(n194), .Y(n180) );
  AOI21X1 U228 ( .A(\fiforeg[2][4] ), .B(n312), .C(n180), .Y(n181) );
  NAND3X1 U229 ( .A(n183), .B(n182), .C(n181), .Y(n186) );
  INVX2 U230 ( .A(wdata[4]), .Y(n184) );
  NAND2X1 U231 ( .A(n42), .B(n184), .Y(n185) );
  MUX2X1 U232 ( .B(n187), .A(n13), .S(n308), .Y(n242) );
  INVX2 U233 ( .A(\fiforeg[0][4] ), .Y(n188) );
  MUX2X1 U234 ( .B(n188), .A(n13), .S(n310), .Y(n243) );
  INVX2 U235 ( .A(\fiforeg[2][4] ), .Y(n189) );
  MUX2X1 U236 ( .B(n189), .A(n12), .S(n312), .Y(n241) );
  MUX2X1 U237 ( .B(n194), .A(n12), .S(n314), .Y(n239) );
  MUX2X1 U238 ( .B(n190), .A(n34), .S(n315), .Y(n240) );
  MUX2X1 U239 ( .B(n191), .A(n34), .S(n317), .Y(n236) );
  MUX2X1 U240 ( .B(n193), .A(n35), .S(n318), .Y(n238) );
  MUX2X1 U241 ( .B(n192), .A(n35), .S(n319), .Y(n237) );
  OAI22X1 U242 ( .A(n99), .B(n192), .C(n100), .D(n191), .Y(n114) );
  OAI22X1 U243 ( .A(n97), .B(n194), .C(n98), .D(n193), .Y(n115) );
  AOI22X1 U244 ( .A(\fiforeg[0][4] ), .B(n325), .C(\fiforeg[1][4] ), .D(n324), 
        .Y(n111) );
  AOI22X1 U245 ( .A(\fiforeg[2][4] ), .B(n327), .C(\fiforeg[3][4] ), .D(n326), 
        .Y(n112) );
  INVX2 U246 ( .A(\fiforeg[1][5] ), .Y(n204) );
  INVX2 U247 ( .A(\fiforeg[5][5] ), .Y(n210) );
  INVX2 U248 ( .A(\fiforeg[6][5] ), .Y(n209) );
  OAI22X1 U249 ( .A(n47), .B(n210), .C(n16), .D(n209), .Y(n196) );
  INVX2 U250 ( .A(\fiforeg[7][5] ), .Y(n208) );
  OAI21X1 U251 ( .A(n51), .B(n208), .C(n295), .Y(n195) );
  NOR2X1 U252 ( .A(n195), .B(n196), .Y(n200) );
  AOI22X1 U253 ( .A(\fiforeg[0][5] ), .B(n8), .C(\fiforeg[1][5] ), .D(n308), 
        .Y(n199) );
  INVX2 U254 ( .A(\fiforeg[3][5] ), .Y(n207) );
  INVX2 U255 ( .A(\fiforeg[4][5] ), .Y(n211) );
  OAI22X1 U256 ( .A(n53), .B(n207), .C(n55), .D(n211), .Y(n197) );
  AOI21X1 U257 ( .A(\fiforeg[2][5] ), .B(n312), .C(n197), .Y(n198) );
  NAND3X1 U258 ( .A(n199), .B(n200), .C(n198), .Y(n203) );
  INVX2 U259 ( .A(wdata[5]), .Y(n201) );
  NAND2X1 U260 ( .A(n42), .B(n201), .Y(n202) );
  MUX2X1 U261 ( .B(n204), .A(n22), .S(n3), .Y(n234) );
  INVX2 U262 ( .A(\fiforeg[0][5] ), .Y(n205) );
  MUX2X1 U263 ( .B(n205), .A(n22), .S(n310), .Y(n235) );
  INVX2 U264 ( .A(\fiforeg[2][5] ), .Y(n206) );
  MUX2X1 U265 ( .B(n206), .A(n21), .S(n312), .Y(n233) );
  MUX2X1 U266 ( .B(n211), .A(n21), .S(n314), .Y(n231) );
  MUX2X1 U267 ( .B(n207), .A(n33), .S(n315), .Y(n232) );
  MUX2X1 U268 ( .B(n208), .A(n33), .S(n317), .Y(n228) );
  MUX2X1 U269 ( .B(n210), .A(n32), .S(n318), .Y(n230) );
  MUX2X1 U270 ( .B(n209), .A(n32), .S(n319), .Y(n229) );
  OAI22X1 U271 ( .A(n99), .B(n209), .C(n100), .D(n208), .Y(n109) );
  OAI22X1 U272 ( .A(n97), .B(n211), .C(n98), .D(n210), .Y(n110) );
  AOI22X1 U273 ( .A(\fiforeg[0][5] ), .B(n325), .C(\fiforeg[1][5] ), .D(n324), 
        .Y(n106) );
  AOI22X1 U274 ( .A(\fiforeg[2][5] ), .B(n327), .C(\fiforeg[3][5] ), .D(n326), 
        .Y(n107) );
  INVX2 U275 ( .A(\fiforeg[1][6] ), .Y(n285) );
  INVX2 U276 ( .A(\fiforeg[5][6] ), .Y(n291) );
  INVX2 U277 ( .A(\fiforeg[6][6] ), .Y(n290) );
  OAI22X1 U278 ( .A(n29), .B(n291), .C(n49), .D(n290), .Y(n277) );
  INVX2 U279 ( .A(\fiforeg[7][6] ), .Y(n289) );
  OAI21X1 U280 ( .A(n51), .B(n289), .C(n295), .Y(n276) );
  NOR2X1 U281 ( .A(n276), .B(n277), .Y(n281) );
  AOI22X1 U282 ( .A(\fiforeg[0][6] ), .B(n8), .C(\fiforeg[1][6] ), .D(n308), 
        .Y(n280) );
  INVX2 U283 ( .A(\fiforeg[3][6] ), .Y(n288) );
  INVX2 U284 ( .A(\fiforeg[4][6] ), .Y(n292) );
  OAI22X1 U285 ( .A(n53), .B(n288), .C(n55), .D(n292), .Y(n278) );
  AOI21X1 U286 ( .A(\fiforeg[2][6] ), .B(n312), .C(n278), .Y(n279) );
  NAND3X1 U287 ( .A(n281), .B(n280), .C(n279), .Y(n284) );
  INVX2 U288 ( .A(wdata[6]), .Y(n282) );
  NAND2X1 U289 ( .A(n42), .B(n282), .Y(n283) );
  MUX2X1 U290 ( .B(n285), .A(n11), .S(n308), .Y(n226) );
  INVX2 U291 ( .A(\fiforeg[0][6] ), .Y(n286) );
  MUX2X1 U292 ( .B(n286), .A(n11), .S(n310), .Y(n227) );
  INVX2 U293 ( .A(\fiforeg[2][6] ), .Y(n287) );
  MUX2X1 U294 ( .B(n287), .A(n10), .S(n312), .Y(n225) );
  MUX2X1 U295 ( .B(n292), .A(n10), .S(n314), .Y(n223) );
  MUX2X1 U296 ( .B(n288), .A(n30), .S(n315), .Y(n224) );
  MUX2X1 U297 ( .B(n289), .A(n30), .S(n317), .Y(n220) );
  MUX2X1 U298 ( .B(n291), .A(n31), .S(n318), .Y(n222) );
  MUX2X1 U299 ( .B(n290), .A(n31), .S(n319), .Y(n221) );
  OAI22X1 U300 ( .A(n99), .B(n290), .C(n100), .D(n289), .Y(n104) );
  OAI22X1 U301 ( .A(n97), .B(n292), .C(n98), .D(n291), .Y(n105) );
  AOI22X1 U302 ( .A(\fiforeg[0][6] ), .B(n325), .C(\fiforeg[1][6] ), .D(n324), 
        .Y(n101) );
  AOI22X1 U303 ( .A(\fiforeg[2][6] ), .B(n327), .C(\fiforeg[3][6] ), .D(n326), 
        .Y(n102) );
  INVX2 U304 ( .A(\fiforeg[1][7] ), .Y(n309) );
  INVX2 U305 ( .A(\fiforeg[5][7] ), .Y(n322) );
  INVX2 U306 ( .A(\fiforeg[6][7] ), .Y(n321) );
  OAI22X1 U307 ( .A(n322), .B(n29), .C(n321), .D(n49), .Y(n298) );
  INVX2 U308 ( .A(\fiforeg[7][7] ), .Y(n320) );
  OAI21X1 U309 ( .A(n320), .B(n51), .C(n295), .Y(n297) );
  NOR2X1 U310 ( .A(n297), .B(n298), .Y(n304) );
  AOI22X1 U311 ( .A(n8), .B(\fiforeg[0][7] ), .C(n308), .D(\fiforeg[1][7] ), 
        .Y(n303) );
  INVX2 U312 ( .A(\fiforeg[3][7] ), .Y(n316) );
  INVX2 U313 ( .A(\fiforeg[4][7] ), .Y(n323) );
  OAI22X1 U314 ( .A(n316), .B(n53), .C(n323), .D(n55), .Y(n301) );
  AOI21X1 U315 ( .A(n312), .B(\fiforeg[2][7] ), .C(n301), .Y(n302) );
  NAND3X1 U316 ( .A(n303), .B(n304), .C(n302), .Y(n307) );
  INVX2 U317 ( .A(wdata[7]), .Y(n305) );
  NAND2X1 U318 ( .A(n42), .B(n305), .Y(n306) );
  MUX2X1 U319 ( .B(n309), .A(n43), .S(n308), .Y(n218) );
  INVX2 U320 ( .A(\fiforeg[0][7] ), .Y(n311) );
  MUX2X1 U321 ( .B(n311), .A(n45), .S(n8), .Y(n219) );
  INVX2 U322 ( .A(\fiforeg[2][7] ), .Y(n313) );
  MUX2X1 U323 ( .B(n313), .A(n44), .S(n312), .Y(n217) );
  MUX2X1 U324 ( .B(n323), .A(n43), .S(n314), .Y(n215) );
  MUX2X1 U325 ( .B(n316), .A(n45), .S(n315), .Y(n216) );
  MUX2X1 U326 ( .B(n320), .A(n44), .S(n317), .Y(n212) );
  MUX2X1 U327 ( .B(n322), .A(n43), .S(n318), .Y(n214) );
  MUX2X1 U328 ( .B(n321), .A(n45), .S(n319), .Y(n213) );
  OAI22X1 U329 ( .A(n99), .B(n321), .C(n100), .D(n320), .Y(n95) );
  OAI22X1 U330 ( .A(n97), .B(n323), .C(n98), .D(n322), .Y(n96) );
  AOI22X1 U331 ( .A(\fiforeg[0][7] ), .B(n325), .C(\fiforeg[1][7] ), .D(n324), 
        .Y(n92) );
  AOI22X1 U332 ( .A(\fiforeg[2][7] ), .B(n327), .C(\fiforeg[3][7] ), .D(n326), 
        .Y(n93) );
  INVX2 U333 ( .A(n139), .Y(n324) );
  INVX2 U334 ( .A(n138), .Y(n325) );
  INVX2 U335 ( .A(n137), .Y(n326) );
  INVX2 U336 ( .A(n136), .Y(n327) );
  INVX2 U337 ( .A(raddr[2]), .Y(n328) );
  INVX2 U338 ( .A(raddr[1]), .Y(n329) );
  INVX2 U339 ( .A(raddr[0]), .Y(n330) );
endmodule


module write_ptr ( wclk, rst_n, wenable, wptr, wptr_nxt );
  output [3:0] wptr;
  output [3:0] wptr_nxt;
  input wclk, rst_n, wenable;
  wire   n9, n10, n11, n12, n13, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40;
  wire   [2:0] binary_nxt;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(binary_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(binary_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(binary_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(wptr_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[0]) );
  INVX1 U11 ( .A(n33), .Y(n9) );
  INVX2 U12 ( .A(n34), .Y(n10) );
  INVX4 U13 ( .A(wenable), .Y(n11) );
  INVX8 U14 ( .A(n11), .Y(n12) );
  BUFX2 U15 ( .A(binary_r[1]), .Y(n13) );
  BUFX4 U16 ( .A(binary_r[0]), .Y(n16) );
  OR2X1 U17 ( .A(n12), .B(n10), .Y(n26) );
  XNOR2X1 U18 ( .A(n28), .B(binary_nxt[1]), .Y(wptr_nxt[1]) );
  XNOR2X1 U19 ( .A(n32), .B(n9), .Y(wptr_nxt[3]) );
  XOR2X1 U20 ( .A(n12), .B(n16), .Y(binary_nxt[0]) );
  NAND2X1 U21 ( .A(n13), .B(n16), .Y(n25) );
  INVX2 U22 ( .A(n25), .Y(n18) );
  INVX2 U23 ( .A(binary_r[0]), .Y(n30) );
  INVX2 U24 ( .A(binary_r[1]), .Y(n29) );
  NAND2X1 U25 ( .A(n30), .B(n29), .Y(n19) );
  OAI21X1 U26 ( .A(n13), .B(wenable), .C(n19), .Y(n17) );
  AOI21X1 U27 ( .A(n18), .B(n12), .C(n17), .Y(binary_nxt[1]) );
  NAND2X1 U28 ( .A(n13), .B(n30), .Y(n22) );
  INVX2 U29 ( .A(n19), .Y(n20) );
  AOI22X1 U30 ( .A(n16), .B(n29), .C(n20), .D(n12), .Y(n21) );
  OAI21X1 U31 ( .A(n12), .B(n22), .C(n21), .Y(wptr_nxt[0]) );
  INVX2 U32 ( .A(binary_r[2]), .Y(n34) );
  NOR2X1 U33 ( .A(n29), .B(n34), .Y(n24) );
  NOR2X1 U34 ( .A(n30), .B(n11), .Y(n23) );
  AOI22X1 U35 ( .A(n25), .B(n34), .C(n24), .D(n23), .Y(n27) );
  NAND2X1 U36 ( .A(n27), .B(n26), .Y(n28) );
  INVX2 U37 ( .A(n28), .Y(binary_nxt[2]) );
  NOR2X1 U38 ( .A(n30), .B(n29), .Y(n31) );
  NAND3X1 U39 ( .A(wenable), .B(n31), .C(n10), .Y(n32) );
  INVX2 U40 ( .A(binary_r[3]), .Y(n33) );
  NAND2X1 U41 ( .A(n13), .B(n33), .Y(n40) );
  NAND2X1 U42 ( .A(wenable), .B(n16), .Y(n39) );
  NAND3X1 U43 ( .A(binary_r[1]), .B(binary_r[0]), .C(n34), .Y(n37) );
  XOR2X1 U44 ( .A(binary_r[3]), .B(binary_r[2]), .Y(n36) );
  NOR2X1 U45 ( .A(wenable), .B(n33), .Y(n35) );
  AOI22X1 U46 ( .A(n37), .B(n36), .C(n35), .D(n34), .Y(n38) );
  OAI21X1 U47 ( .A(n40), .B(n39), .C(n38), .Y(wptr_nxt[2]) );
endmodule


module write_fifo_ctrl ( wclk, rst_n, wenable, rptr, wenable_fifo, wptr, waddr, 
        full_flag );
  input [3:0] rptr;
  output [3:0] wptr;
  output [2:0] waddr;
  input wclk, rst_n, wenable;
  output wenable_fifo, full_flag;
  wire   n30, n31, n32, \gray_wptr[2] , N5, n2, n4, n18, n19, n20, n22, n23,
         n24, n25, n26, n27, n28, n29;
  wire   [3:0] wptr_nxt;
  wire   [3:0] wrptr_r2;
  wire   [3:0] wrptr_r1;

  DFFSR \wrptr_r1_reg[3]  ( .D(rptr[3]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[3]) );
  DFFSR \wrptr_r1_reg[2]  ( .D(rptr[2]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[2]) );
  DFFSR \wrptr_r1_reg[1]  ( .D(rptr[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[1]) );
  DFFSR \wrptr_r1_reg[0]  ( .D(rptr[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[0]) );
  DFFSR \wrptr_r2_reg[3]  ( .D(wrptr_r1[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[3]) );
  DFFSR \wrptr_r2_reg[2]  ( .D(wrptr_r1[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[2]) );
  DFFSR \wrptr_r2_reg[1]  ( .D(wrptr_r1[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[1]) );
  DFFSR \wrptr_r2_reg[0]  ( .D(wrptr_r1[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[0]) );
  DFFSR full_flag_r_reg ( .D(N5), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        full_flag) );
  DFFSR \waddr_reg[2]  ( .D(\gray_wptr[2] ), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(n30) );
  DFFSR \waddr_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        n31) );
  DFFSR \waddr_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        n32) );
  write_ptr WPU1 ( .wclk(wclk), .rst_n(rst_n), .wenable(n18), .wptr(wptr), 
        .wptr_nxt(wptr_nxt) );
  BUFX4 U15 ( .A(n32), .Y(waddr[0]) );
  XOR2X1 U16 ( .A(wrptr_r2[3]), .B(wrptr_r2[2]), .Y(n2) );
  XOR2X1 U17 ( .A(wptr_nxt[2]), .B(n2), .Y(n22) );
  AND2X2 U18 ( .A(wenable), .B(n28), .Y(wenable_fifo) );
  INVX2 U19 ( .A(full_flag), .Y(n28) );
  INVX2 U20 ( .A(n30), .Y(n4) );
  INVX4 U21 ( .A(n4), .Y(waddr[2]) );
  INVX4 U22 ( .A(n29), .Y(n18) );
  INVX1 U23 ( .A(wptr_nxt[2]), .Y(n19) );
  INVX2 U24 ( .A(n19), .Y(n20) );
  BUFX4 U25 ( .A(n31), .Y(waddr[1]) );
  XOR2X1 U26 ( .A(wptr_nxt[1]), .B(wrptr_r2[1]), .Y(n27) );
  XOR2X1 U27 ( .A(wptr_nxt[3]), .B(wrptr_r2[3]), .Y(n25) );
  XNOR2X1 U28 ( .A(n22), .B(wptr_nxt[3]), .Y(n24) );
  XNOR2X1 U29 ( .A(wptr_nxt[0]), .B(wrptr_r2[0]), .Y(n23) );
  NAND3X1 U30 ( .A(n25), .B(n24), .C(n23), .Y(n26) );
  NOR2X1 U31 ( .A(n27), .B(n26), .Y(N5) );
  NAND2X1 U32 ( .A(wenable), .B(n28), .Y(n29) );
  XOR2X1 U33 ( .A(n20), .B(wptr_nxt[3]), .Y(\gray_wptr[2] ) );
endmodule


module read_ptr ( rclk, rst_n, renable, rptr, rptr_nxt );
  output [3:0] rptr;
  output [3:0] rptr_nxt;
  input rclk, rst_n, renable;
  wire   \binary_nxt[0] , n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n28, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n63, n64;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(\binary_nxt[0] ), .CLK(rclk), .R(rst_n), .S(
        1'b1), .Q(binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(n63), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(n61), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(n15), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(n15), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(n26), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(n23), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(n12), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[0]) );
  INVX1 U11 ( .A(n13), .Y(n9) );
  INVX2 U12 ( .A(renable), .Y(n45) );
  AND2X1 U13 ( .A(renable), .B(n53), .Y(n28) );
  INVX2 U14 ( .A(n58), .Y(n10) );
  INVX1 U15 ( .A(binary_r[3]), .Y(n58) );
  BUFX2 U16 ( .A(renable), .Y(n13) );
  INVX1 U17 ( .A(rptr_nxt[0]), .Y(n11) );
  INVX1 U18 ( .A(n11), .Y(n12) );
  INVX1 U19 ( .A(rptr_nxt[3]), .Y(n14) );
  INVX1 U20 ( .A(n14), .Y(n15) );
  INVX2 U21 ( .A(binary_r[1]), .Y(n16) );
  INVX4 U22 ( .A(n16), .Y(n17) );
  BUFX4 U23 ( .A(binary_r[2]), .Y(n18) );
  INVX4 U24 ( .A(n45), .Y(n19) );
  AND2X2 U25 ( .A(n17), .B(n31), .Y(n20) );
  INVX1 U26 ( .A(binary_r[2]), .Y(n41) );
  AND2X1 U27 ( .A(n20), .B(n21), .Y(n53) );
  AND2X1 U28 ( .A(n18), .B(binary_r[3]), .Y(n21) );
  INVX1 U29 ( .A(rptr_nxt[1]), .Y(n22) );
  INVX1 U30 ( .A(n22), .Y(n23) );
  AND2X2 U31 ( .A(n18), .B(n20), .Y(n24) );
  INVX2 U32 ( .A(n24), .Y(n51) );
  INVX1 U33 ( .A(rptr_nxt[2]), .Y(n25) );
  INVX1 U34 ( .A(n25), .Y(n26) );
  BUFX4 U35 ( .A(n64), .Y(rptr_nxt[3]) );
  NOR2X1 U36 ( .A(n28), .B(n52), .Y(n64) );
  INVX1 U37 ( .A(n17), .Y(n42) );
  NAND2X1 U38 ( .A(n59), .B(n60), .Y(rptr_nxt[2]) );
  OR2X1 U39 ( .A(n57), .B(n18), .Y(n54) );
  INVX2 U40 ( .A(binary_r[0]), .Y(n30) );
  INVX4 U41 ( .A(n30), .Y(n31) );
  XOR2X1 U42 ( .A(n19), .B(n31), .Y(\binary_nxt[0] ) );
  INVX2 U43 ( .A(n31), .Y(n33) );
  NAND2X1 U44 ( .A(n33), .B(n42), .Y(n48) );
  INVX2 U45 ( .A(n48), .Y(n34) );
  NAND2X1 U46 ( .A(n17), .B(n31), .Y(n43) );
  OAI22X1 U47 ( .A(n9), .B(n43), .C(n17), .D(n19), .Y(n32) );
  NOR2X1 U48 ( .A(n34), .B(n32), .Y(n63) );
  AOI22X1 U49 ( .A(n33), .B(n42), .C(n17), .D(n31), .Y(n37) );
  OAI21X1 U50 ( .A(n31), .B(n34), .C(n43), .Y(n35) );
  NAND2X1 U51 ( .A(n35), .B(n13), .Y(n36) );
  OAI21X1 U52 ( .A(n19), .B(n37), .C(n36), .Y(n38) );
  INVX2 U53 ( .A(n38), .Y(rptr_nxt[0]) );
  NAND2X1 U54 ( .A(n57), .B(n41), .Y(n47) );
  INVX2 U55 ( .A(n47), .Y(n40) );
  OAI22X1 U56 ( .A(n18), .B(n19), .C(n9), .D(n51), .Y(n39) );
  NOR2X1 U57 ( .A(n40), .B(n39), .Y(n61) );
  AOI22X1 U58 ( .A(n18), .B(n17), .C(n42), .D(n41), .Y(n46) );
  NAND3X1 U59 ( .A(n48), .B(n47), .C(n43), .Y(n44) );
  OAI22X1 U60 ( .A(renable), .B(n46), .C(n45), .D(n44), .Y(n50) );
  OAI21X1 U61 ( .A(n48), .B(n47), .C(n51), .Y(n49) );
  NOR2X1 U62 ( .A(n50), .B(n49), .Y(rptr_nxt[1]) );
  OAI22X1 U63 ( .A(renable), .B(binary_r[3]), .C(n10), .D(n24), .Y(n52) );
  NOR2X1 U64 ( .A(renable), .B(n18), .Y(n56) );
  XOR2X1 U65 ( .A(binary_r[3]), .B(n18), .Y(n55) );
  NAND2X1 U66 ( .A(n17), .B(n31), .Y(n57) );
  AOI22X1 U67 ( .A(n56), .B(n10), .C(n55), .D(n54), .Y(n60) );
  NAND3X1 U68 ( .A(n20), .B(n58), .C(n13), .Y(n59) );
endmodule


module read_fifo_ctrl ( rclk, rst_n, renable, wptr, rptr, raddr, empty_flag );
  input [3:0] wptr;
  output [3:0] rptr;
  output [2:0] raddr;
  input rclk, rst_n, renable;
  output empty_flag;
  wire   renable_p2, \gray_rptr[2] , N3, n1, n2, n3, n4, n17, n18, n19, n20,
         n21, n22, n23;
  wire   [3:0] rptr_nxt;
  wire   [3:0] rwptr_r2;
  wire   [3:0] rwptr_r1;

  DFFSR \rwptr_r1_reg[3]  ( .D(wptr[3]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[3]) );
  DFFSR \rwptr_r1_reg[2]  ( .D(wptr[2]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[2]) );
  DFFSR \rwptr_r1_reg[1]  ( .D(wptr[1]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[1]) );
  DFFSR \rwptr_r1_reg[0]  ( .D(wptr[0]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[0]) );
  DFFSR \rwptr_r2_reg[3]  ( .D(rwptr_r1[3]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[3]) );
  DFFSR \rwptr_r2_reg[2]  ( .D(rwptr_r1[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[2]) );
  DFFSR \rwptr_r2_reg[1]  ( .D(rwptr_r1[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[1]) );
  DFFSR \rwptr_r2_reg[0]  ( .D(rwptr_r1[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[0]) );
  DFFSR empty_flag_r_reg ( .D(N3), .CLK(rclk), .R(1'b1), .S(rst_n), .Q(
        empty_flag) );
  DFFSR \raddr_reg[2]  ( .D(\gray_rptr[2] ), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(raddr[2]) );
  DFFSR \raddr_reg[1]  ( .D(rptr_nxt[1]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        raddr[1]) );
  DFFSR \raddr_reg[0]  ( .D(n3), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(raddr[0])
         );
  read_ptr RPU1 ( .rclk(rclk), .rst_n(rst_n), .renable(renable_p2), .rptr(rptr), .rptr_nxt(rptr_nxt) );
  INVX2 U15 ( .A(rwptr_r2[2]), .Y(n1) );
  XOR2X1 U16 ( .A(rptr_nxt[2]), .B(n1), .Y(n18) );
  INVX1 U17 ( .A(rptr_nxt[0]), .Y(n2) );
  INVX1 U18 ( .A(n2), .Y(n3) );
  XNOR2X1 U19 ( .A(n4), .B(rptr_nxt[3]), .Y(\gray_rptr[2] ) );
  INVX1 U20 ( .A(rptr_nxt[2]), .Y(n4) );
  INVX1 U21 ( .A(empty_flag), .Y(n23) );
  XNOR2X1 U22 ( .A(rptr_nxt[1]), .B(rwptr_r2[1]), .Y(n17) );
  NAND2X1 U23 ( .A(n17), .B(n18), .Y(n22) );
  XNOR2X1 U24 ( .A(rptr_nxt[3]), .B(rwptr_r2[3]), .Y(n20) );
  XNOR2X1 U25 ( .A(rptr_nxt[0]), .B(rwptr_r2[0]), .Y(n19) );
  NAND2X1 U26 ( .A(n19), .B(n20), .Y(n21) );
  NOR2X1 U27 ( .A(n22), .B(n21), .Y(N3) );
  AND2X2 U28 ( .A(renable), .B(n23), .Y(renable_p2) );
endmodule


module fifo ( r_clk, w_clk, n_rst, r_enable, w_enable, w_data, r_data, empty, 
        full );
  input [7:0] w_data;
  output [7:0] r_data;
  input r_clk, w_clk, n_rst, r_enable, w_enable;
  output empty, full;
  wire   wenable_fifo;
  wire   [2:0] waddr;
  wire   [2:0] raddr;
  wire   [3:0] rptr;
  wire   [3:0] wptr;

  fiforam UFIFORAM ( .wclk(w_clk), .wenable(wenable_fifo), .waddr(waddr), 
        .raddr(raddr), .wdata(w_data), .rdata(r_data) );
  write_fifo_ctrl UWFC ( .wclk(w_clk), .rst_n(n_rst), .wenable(w_enable), 
        .rptr(rptr), .wenable_fifo(wenable_fifo), .wptr(wptr), .waddr(waddr), 
        .full_flag(full) );
  read_fifo_ctrl URFC ( .rclk(r_clk), .rst_n(n_rst), .renable(r_enable), 
        .wptr(wptr), .rptr(rptr), .raddr(raddr), .empty_flag(empty) );
endmodule


module tx_fifo ( clk, read_enable, n_rst, write_enable, write_data, read_data, 
        fifo_empty, fifo_full );
  input [7:0] write_data;
  output [7:0] read_data;
  input clk, read_enable, n_rst, write_enable;
  output fifo_empty, fifo_full;


  fifo DUT ( .r_clk(clk), .w_clk(clk), .n_rst(n_rst), .r_enable(read_enable), 
        .w_enable(write_enable), .w_data(write_data), .r_data(read_data), 
        .empty(fifo_empty), .full(fifo_full) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n11, n12, n15, n17, n18, n22, n24,
         net7954, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61;
  assign n9 = A[5];
  assign n12 = A[4];
  assign n15 = A[3];
  assign n18 = A[2];
  assign n22 = A[1];
  assign n24 = A[0];

  NAND2X1 U4 ( .A(n1), .B(n4), .Y(n3) );
  NOR2X1 U5 ( .A(n5), .B(n8), .Y(n4) );
  NAND2X1 U8 ( .A(n7), .B(n1), .Y(n6) );
  NAND2X1 U10 ( .A(n9), .B(n12), .Y(n8) );
  NAND2X1 U14 ( .A(n12), .B(n1), .Y(n11) );
  NAND2X1 U23 ( .A(n57), .B(n61), .Y(n17) );
  NAND2X1 U35 ( .A(n6), .B(n56), .Y(n47) );
  NAND2X1 U36 ( .A(n45), .B(n46), .Y(n48) );
  NAND2X1 U37 ( .A(n47), .B(n48), .Y(SUM[6]) );
  INVX1 U38 ( .A(n6), .Y(n45) );
  INVX1 U39 ( .A(n56), .Y(n46) );
  INVX1 U40 ( .A(n5), .Y(n56) );
  XOR2X1 U41 ( .A(n49), .B(n50), .Y(SUM[1]) );
  INVX1 U42 ( .A(n24), .Y(n49) );
  INVX2 U43 ( .A(n22), .Y(n50) );
  INVX1 U44 ( .A(n49), .Y(net7954) );
  INVX2 U45 ( .A(A[7]), .Y(n55) );
  INVX1 U46 ( .A(n15), .Y(n51) );
  INVX2 U47 ( .A(n51), .Y(n52) );
  BUFX4 U48 ( .A(n18), .Y(n57) );
  XNOR2X1 U49 ( .A(n53), .B(n57), .Y(SUM[2]) );
  NAND2X1 U50 ( .A(n24), .B(n22), .Y(n53) );
  XNOR2X1 U51 ( .A(n3), .B(n54), .Y(SUM[7]) );
  INVX8 U52 ( .A(n55), .Y(n54) );
  AND2X2 U53 ( .A(n22), .B(n24), .Y(n59) );
  AND2X2 U54 ( .A(n15), .B(n18), .Y(n60) );
  AND2X2 U55 ( .A(n60), .B(n59), .Y(n58) );
  INVX1 U56 ( .A(n8), .Y(n7) );
  AND2X2 U57 ( .A(n59), .B(n60), .Y(n1) );
  XNOR2X1 U58 ( .A(n11), .B(n9), .Y(SUM[5]) );
  XNOR2X1 U59 ( .A(n17), .B(n52), .Y(SUM[3]) );
  XOR2X1 U60 ( .A(n58), .B(n12), .Y(SUM[4]) );
  INVX1 U61 ( .A(net7954), .Y(SUM[0]) );
  AND2X2 U62 ( .A(n22), .B(n24), .Y(n61) );
  INVX2 U63 ( .A(A[6]), .Y(n5) );
endmodule


module flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9 ( clk, n_reset, cnt_up, clear, 
        counter, one_k_samples );
  output [7:0] counter;
  input clk, n_reset, cnt_up, clear;
  output one_k_samples;
  wire   n28, n30, n31, n29, N14, N15, N16, N17, N18, N19, N20, N21, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, net6897, net6899, net6903, net6904,
         net6906, net6907, net6908, net6910, net7387, net7391, net7394,
         net7396, net7826, net7825, net7859, net7872, net7896, net8000,
         net8006, net8038, net6902, net6900, net7335, net6916, n1, n2, n3, n4,
         n14, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  assign counter[0] = net7387;
  assign counter[3] = net7391;
  assign counter[1] = net7396;

  DFFSR \counter_reg[0]  ( .D(n49), .CLK(clk), .R(n_reset), .S(1'b1), .Q(n31)
         );
  DFFSR flagger_reg ( .D(n41), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        one_k_samples) );
  DFFSR \counter_reg[6]  ( .D(n43), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[6]) );
  DFFSR \counter_reg[5]  ( .D(n44), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[5]) );
  DFFSR \counter_reg[4]  ( .D(n45), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[4]) );
  DFFSR \counter_reg[3]  ( .D(n46), .CLK(clk), .R(n_reset), .S(1'b1), .Q(n28)
         );
  DFFSR \counter_reg[2]  ( .D(n47), .CLK(clk), .R(n_reset), .S(1'b1), .Q(n29)
         );
  DFFSR \counter_reg[1]  ( .D(n48), .CLK(clk), .R(n_reset), .S(1'b1), .Q(n30)
         );
  DFFSR \counter_reg[7]  ( .D(n42), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        counter[7]) );
  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9_DW01_inc_1 add_52 ( .A({
        counter[7:4], net8038, n18, net8000, net7394}), .SUM({N21, N20, N19, 
        N18, N17, N16, N15, N14}) );
  NOR2X1 U12 ( .A(N20), .B(N21), .Y(n1) );
  INVX1 U13 ( .A(N21), .Y(n20) );
  AND2X2 U14 ( .A(n1), .B(net6916), .Y(net7872) );
  BUFX4 U15 ( .A(n31), .Y(net7394) );
  BUFX2 U16 ( .A(net7394), .Y(net7387) );
  NAND3X1 U17 ( .A(N14), .B(n3), .C(N17), .Y(n2) );
  NOR2X1 U18 ( .A(N15), .B(N16), .Y(n3) );
  NOR2X1 U19 ( .A(N18), .B(n2), .Y(net7335) );
  AND2X2 U20 ( .A(net6910), .B(net7335), .Y(net6916) );
  INVX2 U21 ( .A(N19), .Y(net6910) );
  NAND2X1 U22 ( .A(net6916), .B(n1), .Y(net6900) );
  NAND2X1 U23 ( .A(net6916), .B(n1), .Y(net7896) );
  OAI22X1 U24 ( .A(n4), .B(net6902), .C(net6897), .D(net6903), .Y(n48) );
  NAND2X1 U25 ( .A(net6900), .B(net7826), .Y(n4) );
  INVX1 U26 ( .A(N15), .Y(net6902) );
  OR2X2 U27 ( .A(cnt_up), .B(clear), .Y(net6897) );
  INVX1 U28 ( .A(net8000), .Y(net6903) );
  INVX2 U29 ( .A(net7825), .Y(net7826) );
  OAI22X1 U30 ( .A(n4), .B(net6906), .C(net6897), .D(net6907), .Y(n46) );
  NAND2X1 U31 ( .A(net6900), .B(net7826), .Y(net7859) );
  INVX1 U32 ( .A(counter[5]), .Y(n23) );
  INVX1 U33 ( .A(counter[7]), .Y(n19) );
  BUFX2 U34 ( .A(n28), .Y(net8038) );
  BUFX2 U35 ( .A(n20), .Y(n14) );
  INVX1 U36 ( .A(N20), .Y(n22) );
  BUFX2 U37 ( .A(net6910), .Y(net8006) );
  BUFX4 U38 ( .A(n30), .Y(net8000) );
  BUFX2 U39 ( .A(n29), .Y(n18) );
  INVX1 U40 ( .A(counter[4]), .Y(n24) );
  BUFX2 U41 ( .A(n18), .Y(counter[2]) );
  NAND2X1 U42 ( .A(net7896), .B(net7826), .Y(n16) );
  NAND2X1 U43 ( .A(net7896), .B(net7826), .Y(n17) );
  INVX1 U44 ( .A(counter[2]), .Y(n25) );
  MUX2X1 U45 ( .B(n16), .A(net6897), .S(net7387), .Y(n49) );
  NAND2X1 U46 ( .A(net6897), .B(net6899), .Y(net7825) );
  INVX1 U47 ( .A(net6903), .Y(net7396) );
  INVX2 U48 ( .A(net6907), .Y(net7391) );
  INVX1 U49 ( .A(net8038), .Y(net6907) );
  INVX1 U50 ( .A(N18), .Y(net6908) );
  INVX1 U51 ( .A(N17), .Y(net6906) );
  INVX1 U52 ( .A(N16), .Y(net6904) );
  INVX2 U53 ( .A(clear), .Y(net6899) );
  OAI22X1 U54 ( .A(n16), .B(n14), .C(net6897), .D(n19), .Y(n42) );
  INVX2 U55 ( .A(counter[6]), .Y(n21) );
  OAI22X1 U56 ( .A(n17), .B(n22), .C(net6897), .D(n21), .Y(n43) );
  OAI22X1 U57 ( .A(n17), .B(net8006), .C(net6897), .D(n23), .Y(n44) );
  OAI22X1 U58 ( .A(net7859), .B(net6908), .C(net6897), .D(n24), .Y(n45) );
  OAI22X1 U59 ( .A(net7859), .B(net6904), .C(net6897), .D(n25), .Y(n47) );
  INVX2 U60 ( .A(one_k_samples), .Y(n27) );
  NAND2X1 U61 ( .A(net7872), .B(net6899), .Y(n26) );
  MUX2X1 U62 ( .B(n27), .A(n26), .S(net6897), .Y(n41) );
endmodule


module timer ( clk, n_rst, rising_edge_found, falling_edge_found, stop_found, 
        start_found, byte_received, ack_prep, check_ack, ack_done );
  input clk, n_rst, rising_edge_found, falling_edge_found, stop_found,
         start_found;
  output byte_received, ack_prep, check_ack, ack_done;
  wire   byte_received, fall, _0_net_, start, n6, n7, n8, n9, n10, n11, n3, n4,
         n5;
  wire   [7:0] count;
  assign ack_prep = byte_received;

  DFFSR start_reg ( .D(n11), .CLK(clk), .R(n_rst), .S(1'b1), .Q(start) );
  DFFSR fall_reg ( .D(falling_edge_found), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        fall) );
  AND2X2 U6 ( .A(check_ack), .B(fall), .Y(ack_done) );
  NOR2X1 U12 ( .A(n6), .B(n7), .Y(byte_received) );
  NAND3X1 U13 ( .A(fall), .B(count[3]), .C(n8), .Y(n7) );
  NOR2X1 U14 ( .A(count[1]), .B(count[0]), .Y(n8) );
  NAND3X1 U15 ( .A(n9), .B(n5), .C(n10), .Y(n6) );
  NOR2X1 U16 ( .A(count[4]), .B(count[2]), .Y(n10) );
  NOR2X1 U17 ( .A(count[7]), .B(count[6]), .Y(n9) );
  flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9 U1 ( .clk(clk), .n_reset(n_rst), 
        .cnt_up(_0_net_), .clear(1'b0), .counter(count), .one_k_samples(
        check_ack) );
  INVX2 U7 ( .A(start), .Y(n4) );
  INVX2 U8 ( .A(start_found), .Y(n3) );
  OAI21X1 U9 ( .A(stop_found), .B(n4), .C(n3), .Y(n11) );
  AND2X2 U10 ( .A(rising_edge_found), .B(start), .Y(_0_net_) );
  INVX2 U11 ( .A(count[5]), .Y(n5) );
endmodule


module controller ( clk, n_rst, stop_found, start_found, byte_received, 
        ack_prep, check_ack, ack_done, rw_mode, address_match, sda_in, 
        rx_enable, tx_enable, read_enable, load_data, sda_mode );
  output [1:0] sda_mode;
  input clk, n_rst, stop_found, start_found, byte_received, ack_prep,
         check_ack, ack_done, rw_mode, address_match, sda_in;
  output rx_enable, tx_enable, read_enable, load_data;
  wire   n5, n6, n7, n8, n9, n12, n13, n14, n15, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63;
  wire   [3:0] state;
  wire   [3:0] nextstate;

  DFFSR \state_reg[0]  ( .D(nextstate[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[1]  ( .D(nextstate[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[1]) );
  DFFSR \state_reg[2]  ( .D(nextstate[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[2]) );
  DFFSR \state_reg[3]  ( .D(nextstate[3]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[3]) );
  INVX2 U7 ( .A(state[3]), .Y(n14) );
  INVX1 U8 ( .A(byte_received), .Y(n46) );
  INVX4 U9 ( .A(n7), .Y(load_data) );
  INVX1 U10 ( .A(n35), .Y(n5) );
  INVX2 U11 ( .A(n52), .Y(n6) );
  OR2X1 U12 ( .A(state[1]), .B(state[0]), .Y(n12) );
  INVX2 U13 ( .A(n47), .Y(n8) );
  OR2X2 U14 ( .A(n44), .B(n37), .Y(n7) );
  INVX1 U15 ( .A(n37), .Y(n18) );
  INVX1 U16 ( .A(state[2]), .Y(n52) );
  INVX2 U17 ( .A(n32), .Y(n9) );
  AND2X2 U18 ( .A(n18), .B(n5), .Y(sda_mode[1]) );
  INVX1 U19 ( .A(state[1]), .Y(n32) );
  NOR2X1 U20 ( .A(n12), .B(n13), .Y(read_enable) );
  INVX1 U21 ( .A(read_enable), .Y(n62) );
  NAND2X1 U22 ( .A(state[3]), .B(state[2]), .Y(n13) );
  INVX1 U23 ( .A(n14), .Y(n15) );
  INVX1 U24 ( .A(load_data), .Y(n61) );
  NAND2X1 U25 ( .A(n5), .B(n52), .Y(n38) );
  INVX2 U26 ( .A(n38), .Y(n22) );
  NAND3X1 U27 ( .A(n14), .B(n32), .C(n22), .Y(n17) );
  INVX2 U28 ( .A(n17), .Y(rx_enable) );
  NAND2X1 U29 ( .A(state[2]), .B(n14), .Y(n37) );
  NAND2X1 U30 ( .A(n9), .B(sda_mode[1]), .Y(n59) );
  INVX2 U31 ( .A(n59), .Y(tx_enable) );
  NOR2X1 U32 ( .A(rx_enable), .B(tx_enable), .Y(n30) );
  INVX2 U33 ( .A(state[0]), .Y(n35) );
  NAND2X1 U34 ( .A(state[1]), .B(n35), .Y(n44) );
  INVX2 U35 ( .A(n44), .Y(n47) );
  NAND2X1 U36 ( .A(start_found), .B(n52), .Y(n19) );
  MUX2X1 U37 ( .B(n63), .A(n19), .S(n15), .Y(n28) );
  OAI21X1 U38 ( .A(stop_found), .B(n35), .C(n19), .Y(n20) );
  NAND2X1 U39 ( .A(n20), .B(n14), .Y(n26) );
  OAI21X1 U40 ( .A(n63), .B(sda_in), .C(n32), .Y(n21) );
  INVX2 U41 ( .A(n21), .Y(n24) );
  AOI21X1 U42 ( .A(address_match), .B(rw_mode), .C(n15), .Y(n23) );
  OAI21X1 U43 ( .A(n24), .B(n23), .C(n22), .Y(n25) );
  OAI21X1 U44 ( .A(n9), .B(n26), .C(n25), .Y(n27) );
  AOI21X1 U45 ( .A(n47), .B(n28), .C(n27), .Y(n29) );
  NAND3X1 U46 ( .A(n30), .B(n61), .C(n29), .Y(nextstate[0]) );
  OAI21X1 U47 ( .A(byte_received), .B(n59), .C(n61), .Y(n31) );
  INVX2 U48 ( .A(n31), .Y(n54) );
  NAND3X1 U49 ( .A(state[2]), .B(n32), .C(n35), .Y(n60) );
  INVX2 U50 ( .A(start_found), .Y(n34) );
  INVX2 U51 ( .A(stop_found), .Y(n33) );
  NAND2X1 U52 ( .A(n34), .B(n33), .Y(n42) );
  NAND3X1 U53 ( .A(ack_done), .B(n15), .C(n35), .Y(n36) );
  OAI21X1 U54 ( .A(n37), .B(n42), .C(n36), .Y(n40) );
  NOR2X1 U55 ( .A(n15), .B(n38), .Y(n39) );
  MUX2X1 U56 ( .B(n40), .A(n39), .S(n9), .Y(n41) );
  NAND3X1 U57 ( .A(n54), .B(n60), .C(n41), .Y(nextstate[2]) );
  INVX2 U58 ( .A(n42), .Y(n48) );
  NOR2X1 U59 ( .A(n6), .B(n14), .Y(n43) );
  OAI21X1 U60 ( .A(n48), .B(n8), .C(n43), .Y(n45) );
  OAI21X1 U61 ( .A(n59), .B(n46), .C(n45), .Y(nextstate[3]) );
  NAND2X1 U62 ( .A(sda_in), .B(n15), .Y(n51) );
  NAND2X1 U63 ( .A(n9), .B(n5), .Y(n50) );
  OAI21X1 U64 ( .A(n48), .B(n14), .C(n47), .Y(n49) );
  OAI21X1 U65 ( .A(n51), .B(n50), .C(n49), .Y(n53) );
  NAND2X1 U66 ( .A(n53), .B(n52), .Y(n58) );
  AND2X2 U67 ( .A(n54), .B(n62), .Y(n57) );
  INVX2 U68 ( .A(n60), .Y(n55) );
  AOI22X1 U69 ( .A(ack_done), .B(n55), .C(ack_prep), .D(rx_enable), .Y(n56) );
  NAND3X1 U70 ( .A(n58), .B(n57), .C(n56), .Y(nextstate[1]) );
  OAI21X1 U71 ( .A(n15), .B(n60), .C(n59), .Y(sda_mode[0]) );
  INVX2 U72 ( .A(check_ack), .Y(n63) );
endmodule


module i2c_slave ( clk, n_rst, scl, sda_in, write_enable, write_data, sda_out, 
        fifo_empty, fifo_full );
  input [7:0] write_data;
  input clk, n_rst, scl, sda_in, write_enable;
  output sda_out, fifo_empty, fifo_full;
  wire   s_scl, s_sda_in, rising_edge_found, falling_edge_found, tx_out,
         rw_mode, address_match, stop_found, start_found, rx_enable, tx_enable,
         load_data, read_enable, byte_received, ack_prep, check_ack, ack_done;
  wire   [1:0] sda_mode;
  wire   [7:0] rx_data;
  wire   [7:0] read_data;

  sync_1 U9 ( .clk(clk), .n_reset(n_rst), .async_in(scl), .sync_out(s_scl) );
  sync_0 U10 ( .clk(clk), .n_reset(n_rst), .async_in(sda_in), .sync_out(
        s_sda_in) );
  scl_edge U1 ( .clk(clk), .n_rst(n_rst), .scl(s_scl), .rising_edge_found(
        rising_edge_found), .falling_edge_found(falling_edge_found) );
  sda_sel U2 ( .tx_out(tx_out), .sda_mode(sda_mode), .sda_out(sda_out) );
  decode U3 ( .clk(clk), .n_rst(n_rst), .scl(s_scl), .sda_in(s_sda_in), 
        .starting_byte(rx_data), .rw_mode(rw_mode), .address_match(
        address_match), .stop_found(stop_found), .start_found(start_found) );
  rx_sr U4 ( .clk(clk), .n_rst(n_rst), .sda_in(s_sda_in), .rising_edge_found(
        rising_edge_found), .rx_enable(rx_enable), .rx_data(rx_data) );
  tx_sr U5 ( .clk(clk), .n_rst(n_rst), .tx_data(read_data), 
        .falling_edge_found(falling_edge_found), .tx_enable(tx_enable), 
        .load_data(load_data), .tx_out(tx_out) );
  tx_fifo U6 ( .clk(clk), .read_enable(read_enable), .n_rst(n_rst), 
        .write_enable(write_enable), .write_data(write_data), .read_data(
        read_data), .fifo_empty(fifo_empty), .fifo_full(fifo_full) );
  timer U7 ( .clk(clk), .n_rst(n_rst), .rising_edge_found(rising_edge_found), 
        .falling_edge_found(falling_edge_found), .stop_found(stop_found), 
        .start_found(start_found), .byte_received(byte_received), .ack_prep(
        ack_prep), .check_ack(check_ack), .ack_done(ack_done) );
  controller U8 ( .clk(clk), .n_rst(n_rst), .stop_found(stop_found), 
        .start_found(start_found), .byte_received(byte_received), .ack_prep(
        ack_prep), .check_ack(check_ack), .ack_done(ack_done), .rw_mode(
        rw_mode), .address_match(address_match), .sda_in(s_sda_in), 
        .rx_enable(rx_enable), .tx_enable(tx_enable), .read_enable(read_enable), .load_data(load_data), .sda_mode(sda_mode) );
endmodule

