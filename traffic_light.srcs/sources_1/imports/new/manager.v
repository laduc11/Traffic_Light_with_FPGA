`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 04:47:41 PM
// Design Name: 
// Module Name: manager
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


module manager(
    input clk,
    input button_0,             // change traffic light in manual mode
    input button_1,             // increase time
    input sw_0,                 // set time
    input sw_1,                 // switch between auto mode and manual mode
    output [2:0]traffic_0,      // traffic light on first way
    output [2:0]traffic_1,      // traffic light on second way
    output en_led7seg,          // enable 7-segment led
    output [6:0]led7seg_0,     
    output [6:0]led7seg_1
    );
    
    parameter AUTO = 1'b0, MANUAL = 1'b1;
    parameter RED_GREEN = 2'b00, RED_YELLOW = 2'b01, GREEN_RED = 2'b10, YELLOW_RED = 2'b11;
    
    wire mode;
    
    reg [1:0]manual_state = 2'b00;      // RED_GREEN = 00, RED_YELLOW = 01, GREEN_RED = 10, YELLOW_RED = 11
    reg [6:0]cur_red = 7'd5, cur_yellow = 7'd2, cur_green = 7'd3;
    reg [3:0]first_number, second_number;
    
    wire [6:0]new_red, new_yellow, new_green;
    wire [2:0]auto_traffic_1, auto_traffic_2;
    wire [2:0]manual_traffic_1, manual_traffic_2;
    wire [6:0]first_counter, second_counter;
    
    // update the period of red, yellow, green light
    always @(posedge clk) begin
        cur_red = (new_red & {7{sw_0 & mode}}) | (cur_red & {7{~sw_0 | ~mode}});
        cur_yellow = (new_yellow & {7{sw_0 & mode}}) | (cur_yellow & {7{~sw_0 | ~mode}});
        cur_green = (new_green & {7{sw_0 & mode}}) | (cur_green & {7{~sw_0 | ~mode}});
    end
    
    // define mode
    assign mode = sw_1;
    
    // display traffic light
    assign traffic_0 = mode == AUTO ? auto_traffic_1 : manual_traffic_1;
    assign traffic_1 = mode == AUTO ? auto_traffic_2 : manual_traffic_2;
    
    // turn on or turn off 7-segment led
    assign en_led7seg = ~mode;
    
    // update number to display on 7-segment led
    always @(first_counter or second_counter) begin
        first_number = first_counter % 10;
        second_number = second_counter % 10;
    end
    
    always @(negedge button_0) begin
        case (manual_state)
            RED_GREEN: manual_state = RED_YELLOW;
            RED_YELLOW: manual_state = GREEN_RED;
            GREEN_RED: manual_state = YELLOW_RED;
            YELLOW_RED: manual_state = RED_GREEN;
        endcase
    end
        
    auto_mode auto(.clk(clk),
                   .enable(~mode),
                   .count_red(cur_red),
                   .count_yellow(cur_yellow),
                   .count_green(cur_green),
                   .first_way(auto_traffic_1),
                   .second_way(auto_traffic_2),
                   .first_counter(first_counter),
                   .second_counter(second_counter));
    
    manual_mode manual(.enable(mode),
                       .mode(manual_state),
                       .increase(button_1),
                       .cur_red(cur_red),
                       .cur_yellow(cur_yellow),
                       .cur_green(cur_green),
                       .new_red(new_red),
                       .new_yellow(new_yellow),
                       .new_green(new_green),
                       .first_way(manual_traffic_1),
                       .second_way(manual_traffic_2));
    
    display7seg display1(.number(first_number),
                        .a(led7seg_0[6]),
                        .b(led7seg_0[5]),
                        .c(led7seg_0[4]),
                        .d(led7seg_0[3]),
                        .e(led7seg_0[2]),
                        .f(led7seg_0[1]),
                        .g(led7seg_0[0]));
                        
    display7seg display2(.number(second_number),
                        .a(led7seg_1[6]),
                        .b(led7seg_1[5]),
                        .c(led7seg_1[4]),
                        .d(led7seg_1[3]),
                        .e(led7seg_1[2]),
                        .f(led7seg_1[1]),
                        .g(led7seg_1[0]));
endmodule
