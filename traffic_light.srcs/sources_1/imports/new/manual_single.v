`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 11:29:53 PM
// Design Name: 
// Module Name: manual_single
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


module manual_single(
    input enable,
    input [1:0]mode,
    input increase,
    input [6:0]pre_counter,
    output [6:0]after_counter,
    output [2:0]traffic
    );

//    parameter INIT = 2'b00, RED = 2'b01, YELLOW = 2'b10, GREEN = 2'b11;
    reg [6:0]counter = 7'b0000000;
    reg rst = 1'b0;         // active low

    assign traffic = (4'b1000 >> (mode & {2{enable}}));
    assign after_counter = pre_counter + counter;
    
    always @(negedge increase or negedge enable) begin
        if (~enable) counter = 7'b0000000;
        else if (counter + pre_counter < 99) counter = counter + 1;
    end
    
    
endmodule
