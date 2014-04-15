// $Id: $
// File name:   mealy.sv
// Created:     2/17/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: mealy model

module mealy
#(
  parameter reg [2:0] WAITING=3'b000,
  parameter reg [2:0] RCV1 = 3'b001,
  parameter reg [2:0] RCV11 = 3'b010,
  parameter reg [2:0] RCV110 = 3'b011
)
(
 input wire clk,
 input wire n_rst,
 input wire i,
 output reg o
);

   reg [2:0] state;
   
   reg[2:0] nextstate;
   

always@(posedge clk, negedge n_rst)
  begin
     if (n_rst == 0) begin
       state <= WAITING;
     end
     
     else begin
	state <= nextstate;
     end
  end

always@(state,i)
  begin
     case(state)
       WAITING:begin
	  if(i==1)begin
	     nextstate = RCV1;
	     o = 1'b0;
	  end
	  else begin
	     nextstate = WAITING;
	     o = 1'b0;
	  end
       end
       RCV1:begin
	  if(i==1)begin
	     nextstate = RCV11;
	     o = 1'b0;	     
	  end
	  else begin
	     nextstate = WAITING;
	     o = 1'b0;
	  end
       end
       RCV11:begin
	  if(i==0)begin
	     nextstate = RCV110;
	     o = 1'b0;
	  end
	  else begin
	     nextstate = RCV11;
	     o = 1'b0;
	  end
       end
       RCV110:begin
	  if(i==1)begin
	     nextstate = RCV1;
	     o = 1'b1;
	     
	  end
	  else begin
	     nextstate = WAITING;
	     o = 1'b0;
	  end
       end
       default : begin
	  nextstate = WAITING;
	  o = 0;
       end
       
     endcase // case (state)
  end // block: case(state)
   
endmodule // mealy