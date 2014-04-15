// $Id: $
// File name:   sensor_s.sv
// Created:     1/21/2014
// Author:      Cole Reinhold
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: sensor sturctural

module sensor_s
(
input wire [3:0] sensors,
output wire error
);

   and A1 (int_and1,sensors[1],sensors[2]);
   and A2 (int_and2,sensors[1],sensors[3]);
   or B3 (error, sensors[0], int_and1, int_and2);
   

endmodule