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
    input [6:0]cur_red,
    input [6:0]cur_yellow,
    input [6:0]cur_green,
    output [6:0]new_red,
    output [6:0]new_yellow,
    output [6:0]new_green,
    output [2:0]first_way,
    output [2:0]second_way
    );
    
    parameter RED = 2'b01, YELLOW = 2'b10, GREEN = 2'b11;
    wire [6:0]pre_counter_1, pre_counter_2;
    wire [1:0]mode_1, mode_2;
    wire [6:0]after_counter_1, after_counter_2;
    
    
    assign mode_1 = {mode[1], ~mode[1] | ~mode[0]};
    assign mode_2 = {~mode[1], mode[1] | ~mode[0]};
    assign new_red = mode_1 == RED ? after_counter_1 : (mode_2 == RED ? after_counter_2 : cur_red);
    assign new_green = mode_1 == GREEN ? after_counter_1 : (mode_2 == GREEN ? after_counter_2 : cur_green);
    assign new_yellow = mode_1 == YELLOW ? after_counter_1 : (mode_2 == YELLOW ? after_counter_2 : cur_yellow);
    assign pre_counter_1 = mode_1 == RED ? cur_red : (mode_1 == YELLOW ? cur_yellow : cur_green);
    assign pre_counter_2 = mode_2 == RED ? cur_red : (mode_2 == YELLOW ? cur_yellow : cur_green);

    
    manual_single manual_traffic_1(.enable(enable),
                                   .mode(mode_1),
                                   .increase(increase),
                                   .pre_counter(pre_counter_1),
                                   .after_counter(after_counter_1),
                                   .traffic(first_way));
    
    manual_single manual_traffic_2(.enable(enable),
                                   .mode(mode_2),
                                   .increase(increase),
                                   .pre_counter(pre_counter_2),
                                   .after_counter(after_counter_2),
                                   .traffic(second_way));
    
endmodule
