`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 01:09:19 AM
// Design Name: 
// Module Name: tb_single
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


module tb_single();

reg clk;
reg enable;
reg [6:0]count_red, count_yellow, count_green;
wire [6:0]first_counter, second_counter;
wire [2:0]first_way, second_way;

always #1 clk = ~clk;

auto_mode UUT(.clk(clk), 
           .count_red(count_red), 
           .count_yellow(count_yellow), 
           .count_green(count_green),
           .first_way(first_way),
           .second_way(second_way),
           .enable(enable),
           .first_counter(first_counter),
           .second_counter(second_counter));
           
initial begin
    clk = 1'b0;
    enable = 1'b1;
    count_red = 5;
    count_yellow = 2;
    count_green = 3;
end

initial begin
//    #20 enable = 1'b0;
//    #20 enable = 1'b1;
end


endmodule
