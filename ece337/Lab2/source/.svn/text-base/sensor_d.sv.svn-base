// $Id: $
// File name:   sensor_d.sv
// Created:     1/28/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: dataflow style sensor
// :wq
// 
module sensor_d
(
input wire [3:0] sensors,
output wire error
);

   assign error = (sensors[0] || (sensors[1] && sensors[2]) || (sensors[1] && sensors[3]));
   

endmodule