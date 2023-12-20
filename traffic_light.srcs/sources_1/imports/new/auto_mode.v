`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2023 04:18:55 PM
// Design Name: 
// Module Name: auto_mode
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


module auto_mode(
    input clk,
    input enable,
    input [6:0]count_red,
    input [6:0]count_yellow,
    input [6:0]count_green,
    output [2:0]first_way,
    output [2:0]second_way,
    output [6:0]first_counter,
    output [6:0]second_counter
    );
    
 parameter RED = 2'b01, YELLOW = 2'b10, GREEN = 2'b11;
 wire red1, yellow1, green1;
 wire red2, yellow2, green2;
 
 auto_single traffic_1(.clk(clk), 
                  .enable(enable), 
                  .init_state(RED),
                  .count_red(count_red), 
                  .count_yellow(count_yellow),
                  .count_green(count_green),
                  .red(red1),
                  .yellow(yellow1),
                  .green(green1),
                  .counter(first_counter));
 auto_single traffic_2(.clk(clk), 
                  .enable(enable), 
                  .init_state(GREEN),
                  .count_red(count_red), 
                  .count_yellow(count_yellow),
                  .count_green(count_green),
                  .red(red2),
                  .yellow(yellow2),
                  .green(green2),
                  .counter(second_counter));               
   
   assign first_way = {red1, yellow1, green1};
   assign second_way = {red2, yellow2, green2};
endmodule
