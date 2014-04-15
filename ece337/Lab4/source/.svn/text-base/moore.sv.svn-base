// $Id: $
// File name:   moore.sv
// Created:     2/17/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: moore model 1101 detector


module moore
#(
  parameter reg [2:0] WAITING=3'b000,
  parameter reg [2:0] RCV1 = 3'b001,
  parameter reg [2:0] RCV11 = 3'b010,
  parameter reg [2:0] RCV110 = 3'b011,
  parameter reg [2:0] RCV1101 = 3'b100
)
(
 input wire clk,
 input wire n_rst,
 input wire i,
 output reg o
);

   reg [2:0] state;
   
   reg[2:0] nextstate;
   assign o = (state == RCV1101) ? 1 : 0;
   

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
	  end
	  else begin
	     nextstate = WAITING;
	  end
       end
       RCV1:begin
	  if(i==1)begin
	     nextstate = RCV11;
	  end
	  else begin
	     nextstate = WAITING;
	  end
       end
       RCV11:begin
	  if(i==0)begin
	     nextstate = RCV110;
	  end
	  else begin
	     nextstate = RCV11;
	  end
       end
       RCV110:begin
	  if(i==1)begin
	     nextstate = RCV1101;
	  end
	  else begin
	     nextstate = WAITING;
	  end
       end
       RCV1101:begin
	  if(i==1)begin
	     nextstate = RCV11;
	  end
	  else begin
	     nextstate = WAITING;
	  end
       end
       default : nextstate = WAITING;
     endcase // case (state)
  end // block: case(state)
   
endmodule // moore


			
   