`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 09:59:06
// Design Name: 
// Module Name: toll_tb
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
module toll_tb;
reg clk, rst;
reg vehicle_detect;
reg payment_done;
reg gate_passed;
wire gate_open;
wire gate_close;

toll dut(clk,rst,vehicle_detect,payment_done,gate_passed,gate_open,gate_close);
always #5 clk = ~clk;
initial begin
 $monitor("Time=%0t | vehicle=%b payment=%b passed=%b | open=%b close=%b",
           $time, vehicle_detect, payment_done, gate_passed, gate_open, gate_close);
    // Initialize signals
clk = 0;
rst = 1;
vehicle_detect = 0;
payment_done = 0;
gate_passed = 0;
 // Release reset
 #15 rst = 0;
// -------- First Vehicle --------
#10 vehicle_detect = 1;
#10 vehicle_detect = 0;

#20 payment_done = 1;
#10 payment_done = 0;

#20 gate_passed = 1;
#10 gate_passed = 0;

// -------- Second Vehicle --------
#40 vehicle_detect = 1;
#10 vehicle_detect = 0;

#20 payment_done = 1;
#10 payment_done = 0;

#20 gate_passed = 1;
#10 gate_passed = 0;

// End simulation
#50 $finish;
end

endmodule
