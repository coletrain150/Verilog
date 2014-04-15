// $Id: $
// File name:   tb_adder_16bit.sv
// Created:     2/4/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: 16 bit adder test bench


`timescale 1ns / 100ps

module tb_adder_16bit
();
  

	// Declare Design Under Test (DUT) portmap signals
        wire	[15:0] tb_a;
	wire	[15:0] tb_b;
	wire	tb_carry_in;
	wire	[15:0] tb_sum;
	wire	tb_carry_out;


   localparam NUM_TEST_CASES = 16;

   reg [32:0] 	tmp_input;
   reg [16:0] 	i;
   reg [16:0]	expected_output;
   reg 		no_match;
   

	adder_16bit DUT(.a(tb_a), .b(tb_b), .carry_in(tb_carry_in), .sum(tb_sum), .overflow(tb_carry_out));

   	assign tb_a					= tmp_input[15:0];
	assign tb_b					= tmp_input[31:16];
        assign tb_carry_in	                        = tmp_input[32];
	always @ (expected_output)
	  begin
	     assert(expected_output[15:0] == tb_sum)
	       no_match = 0;
             else
               no_match= 1;
	  end
   initial
     begin
	// Initialize test inputs for DUT
	tmp_input = 33'b000000000000000000000000000000000;
	
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;



	#10;
	
	// Initialize test inputs for DUT
	tmp_input = 33'b100000000000000000000000000000000;
	
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;


	#10;
	
	// Initialize test inputs for DUT
	tmp_input = 33'b000000001000000000111100000000011;
	
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;


	#10;
	
	// Initialize test inputs for DUT
	tmp_input = 33'b111111111111111110000000000000001;
	
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;

	#10;
	
	// Initialize test inputs for DUT
	tmp_input = 33'b000000000000100000000000000001101;
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;

	// Initialize test inputs for DUT
	tmp_input = 33'b110110001100100110010101111111111;
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;
	// Initialize test inputs for DUT
	tmp_input = 33'b111111111111100110010101111111111;
	// Wait for a bit to allow this process to catch up with assign statements triggered
	// by test input assignment above
	#1;		
	// Calculate the expected outputs
	expected_output = tb_a + tb_b + tb_carry_in;
	// Wait for DUT to process the inputs
	#10;      
     end
endmodule