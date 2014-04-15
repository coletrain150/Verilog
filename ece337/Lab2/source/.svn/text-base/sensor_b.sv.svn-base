// $Id: $
// File name:   sensor_b.sv
// Created:     1/28/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: behavioral style sensor
module sensor_b
(
input wire [3:0] sensors,
output reg error
);


always @ (sensors[3:0]) begin
  if (sensors[0] || (sensors[1] && sensors[2]) || (sensors[1] && sensors[3]))begin
    error = 1'b1;
  end else begin
    error = 1'b0;
  end
end
endmodule