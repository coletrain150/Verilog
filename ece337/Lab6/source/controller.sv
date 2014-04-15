// $Id: $
// File name:   controller.sv
// Created:     3/11/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: controller
module controller
(
    input wire clk,
    input wire n_rst,
    input wire stop_found,
    input wire start_found,
    input wire byte_received,
    input wire ack_prep,
    input wire check_ack,
    input wire ack_done,
    input wire rw_mode,
    input wire address_match,
    input wire sda_in,
    output reg rx_enable,
    output reg tx_enable,
    output reg read_enable,
    output reg load_data,
    output reg [1:0] sda_mode
);

 typedef enum bit [3:0]{IDLE, READING, PREP, ACK_OR_NACK, ACK, NACK, LOAD, SHIFT, LOADNEW, CHECK_ACK_OR_NACK, NACK2,CHECK_SDA,LOAD2} stateType;
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
           if(start_found==1)begin
             nextstate = READING;
           end
           else begin
             nextstate = IDLE;
           end
       end
       READING:begin
            if(ack_prep == 1) begin
                nextstate = ACK_OR_NACK;
            end
            else begin
                nextstate = READING;
            end
         end
       PREP:begin
            if(check_ack == 1) begin
              nextstate = ACK_OR_NACK;
            end
            else begin
              nextstate = PREP;
            end
        end
       ACK_OR_NACK:begin
            if(address_match == 1 & rw_mode == 1) begin
                nextstate = ACK;
            end
            else begin
                nextstate = NACK;
            end
        end
        NACK:begin
            if(stop_found == 1) begin
                nextstate = IDLE;
            end
            else if(start_found == 1) begin
                nextstate = READING;
            end
            else begin
                nextstate = NACK;
            end
        end
        ACK:begin
           if(ack_done == 1) begin
             nextstate = LOAD;
           end
           else begin
             nextstate = ACK;
           end
            end // case: CHECK_STOP
        LOAD:begin
            nextstate = SHIFT;
        end
        LOAD2:begin
            nextstate = LOAD;
          end
        SHIFT:begin
            if(byte_received == 1) begin
                nextstate = CHECK_ACK_OR_NACK;
            end
            else begin
                nextstate = SHIFT;
            end
        end
        CHECK_ACK_OR_NACK:begin
            if(check_ack == 1 && sda_in == 0) begin
                nextstate = LOADNEW;
            end
            //else if (check == 1)begin
             //   nextstate = LOADNEW;
            //end
            else begin
                nextstate = CHECK_ACK_OR_NACK;
              end
        end
        CHECK_SDA: begin
          if(sda_in == 1) begin
            nextstate = NACK2;
          end
          else if(sda_in == 0) begin
            nextstate = LOADNEW;
          end
        end
        LOADNEW:begin
            if(ack_done == 1) begin
              nextstate = LOAD2;
            end
            //else begin
            //  nextstate = LOADNEW;
            //  end
            else begin
              nextstate = LOADNEW;
            end

        end
        NACK2:begin
            if(start_found == 1) begin
                nextstate = READING;
            end
            else if(stop_found == 1) begin
                nextstate = IDLE;
            end
            else begin
                nextstate = NACK2;
            end
        end
       default : nextstate = IDLE;
     endcase // case (state)
  end // always_comb begin

always_comb
  begin
    rx_enable = 0;
    tx_enable = 0;
    read_enable = 0;
    load_data = 0;
    sda_mode = 2'b00;
    case(state)
      IDLE:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      READING:begin
        rx_enable = 1;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      PREP:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      ACK_OR_NACK:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      ACK:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b01;
      end
      NACK:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b10;
      end
      LOAD:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 1;
        sda_mode = 2'b00;
      end
      SHIFT:begin
        rx_enable = 0;
        tx_enable = 1;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b11;
      end
      LOADNEW:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      LOAD2:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 1;
        load_data = 0;
        sda_mode = 2'b00;
      end
      CHECK_ACK_OR_NACK:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      CHECK_SDA:begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
      NACK2 :begin
        rx_enable = 0;
        tx_enable = 0;
        read_enable = 0;
        load_data = 0;
        sda_mode = 2'b00;
      end
     endcase // case (state)
  end // always_comb begin

endmodule
