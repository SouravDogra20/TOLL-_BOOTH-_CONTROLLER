`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 23:15:51
// Design Name: 
// Module Name: toll
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module toll(clk,rst,vehicle_detect,payment_done,gate_passed,gate_open,gate_close);
input clk,rst,vehicle_detect,payment_done,gate_passed;
output reg gate_open,gate_close;
reg [2:0] state, next_state;

parameter S0 = 3'b000,//Idle   
          S1 = 3'b001,//Vehicle _detected
          S2 = 3'b010,//Payment_Done   
          S3 = 3'b011,//Gate_open
          S4 = 3'b100;//Gate_close
always @(posedge clk or posedge rst) begin
if (rst)
state <= S0;
else
state <= next_state;
end
//state transition  block 
always @(*)begin
case(state)
S0:begin 
if(vehicle_detect)
next_state=S1;
else
next_state=S0;
end
S1:begin
if(payment_done)
next_state=S2;
else
next_state=S1;
end
S2:begin
if(payment_done)
next_state=S3;
else
next_state=S2;
end
S3:begin
if(gate_passed)
next_state=S4;
else
next_state=S3;
end 
S4: begin
if(!gate_passed)
 next_state = S0;
else
next_state = S4;
end
default:next_state=S0;
endcase
end
//output block
always @(*) begin
case (state)
S3:gate_open<=1'b1;
S4:gate_close<=1'b1;
default:begin
gate_open<=1'b0;
gate_close<=1'b0; 
end
endcase
end
endmodule

          