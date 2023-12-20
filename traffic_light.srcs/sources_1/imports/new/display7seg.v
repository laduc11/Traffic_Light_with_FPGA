`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 05:10:25 PM
// Design Name: 
// Module Name: display7seg
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


module display7seg(
    input [3:0] number,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
    );
    
    reg [3:0]temp;
    
    // a = -B-D + C + BD + A
    // b = -B + -C-D + CD
    // c = -C + D + B 
    // d = -B-D + -BC + B-CD + C-D + A
    // e = -B-D + C-D
    // f = -C-D + B-C + B-D + A
    // g = -BC + B-C + A + B-D
    assign a = (~temp[0] & ~temp[2]) | temp[1] | (temp[2] & temp[0]) | temp[3];
    assign b = ~temp[2] | (~temp[1] & ~temp[0]) | (temp[1] & temp[0]);
    assign c = ~temp[1] | temp [0] | temp[2];
    assign d = (~temp[2] & ~temp[0]) | (~temp[2] & temp[1]) | (~temp[2] & ~temp[1] & temp[0]) | (temp[1] & ~temp[0]) | temp[3];
    assign e = (~temp[2] & ~temp[0]) | (temp[1] & ~temp[0]);
    assign f = (temp[1] & ~temp[0]) | (temp[2] & ~temp[1]) | (temp[2] & ~temp[0]) | temp[3];
    assign g = (~temp[2] & temp[1]) | (temp[2] & ~temp[1]) | temp[3] | (temp[2] & ~temp[0]);
    
    always @(*) begin
        if (number > 4'b1001) temp = 4'b0000;
        else temp = number;
    end
endmodule
