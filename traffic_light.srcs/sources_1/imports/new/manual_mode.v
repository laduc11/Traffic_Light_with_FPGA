`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 12:14:50 PM
// Design Name: 
// Module Name: manual_mode
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


module manual_mode(
    input enable,
    input [1:0]mode,
    input increase,
    input [6:0]pre_counter,
    output [6:0]after_counter,
    output [2:0]traffic
    );
    
    parameter INIT = 2'b00, RED = 2'b01, YELLOW = 2'b10, GREEN = 2'b11;
    reg [6:0]counter = 7'b0000000;
    
    assign traffic = (4'b1000 >> mode);
    assign after_counter = pre_counter + (counter & {7{enable}});
        
    always @(negedge increase) begin
        if (counter + pre_counter < 99) counter = counter + 1;
    end
    
endmodule
