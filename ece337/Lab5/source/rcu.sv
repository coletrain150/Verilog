// $Id: $
// File name:   rcu.sv
// Created:     2/22/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: rcu

module rcu
(
 input wire clk,
 input wire n_rst,
 input wire start_bit_detected,
 input wire packet_done,
 input wire framing_error,
 output reg sbc_clear,
 output reg sbc_enable,
 output reg load_buffer,
 output reg enable_timer
);

   typedef enum bit [2:0]{IDLE, CLEAR, GET_DATA, CHECK_STOP, OUTPUT_BUFF, RECEIVE_ERROR} stateType;
   stateType state;
   stateType nextstate;

always_ff@(posedge clk, negedge n_rst)
  begin
     if (n_rst == 0) begin
       state <= IDLE;
     end
     else begin
	     state <= nextstate;
     end
  end

always_comb
  begin
     case(state)
       IDLE:begin
	       if(start_bit_detected==1)begin
	         nextstate = CLEAR;
	       end
	       else begin
	         nextstate = IDLE;
	       end
       end
       CLEAR:begin
	       nextstate = GET_DATA;
	     end
       GET_DATA:begin
	       if(packet_done == 1) begin
	         nextstate = RECEIVE_ERROR;
	       end
	       else begin
	         nextstate = GET_DATA;
	       end
       end
       RECEIVE_ERROR:begin
         nextstate = CHECK_STOP;
       end
       CHECK_STOP:begin
	       if(framing_error == 0) begin
	         nextstate = OUTPUT_BUFF;
	       end
	       else if(framing_error == 1) begin
	         nextstate = IDLE;
	       end
       end // case: CHECK_STOP

       OUTPUT_BUFF:begin
	       nextstate = IDLE;
       end
       default : nextstate = IDLE;
     endcase // case (state)
  end // always_comb begin

always_comb
  begin
     load_buffer=0;
     sbc_enable=0;
     sbc_clear=0;
     enable_timer=0;
     case(state)
       IDLE: begin
	       load_buffer=0;
	       sbc_enable=0;
	       sbc_clear=0;
	       enable_timer=0;
       end
       CLEAR:begin
	       sbc_clear = 1;
	       load_buffer=0;
	       sbc_enable=0;
	       enable_timer=0;
       end
       GET_DATA:begin
	       load_buffer=0;
	       sbc_enable=0;
	       sbc_clear=0;
	       enable_timer=1;
       end
       RECEIVE_ERROR:begin
        load_buffer=0;
        sbc_enable=1;
        sbc_clear=0;
        enable_timer=0;
        end
       CHECK_STOP:begin
	       load_buffer=0;
	       sbc_enable=0;
	       sbc_clear=0;
	       enable_timer=0;
       end
       OUTPUT_BUFF:begin
	       load_buffer=1;
	       sbc_enable=0;
	       sbc_clear=1;
	       enable_timer=0;
       end

     endcase // case (state)
  end // always_comb begin



endmodule // rcu
