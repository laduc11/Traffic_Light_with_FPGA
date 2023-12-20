`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 12:05:21 AM
// Design Name: 
// Module Name: single
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


module auto_single(
    input clk,
    input enable,
    input [1:0]init_state,
    input [6:0]count_red,
    input [6:0]count_yellow,
    input [6:0]count_green,
    output red,
    output yellow,
    output green,
    output reg [6:0]counter
    );
    
    parameter INIT = 2'b00, RED = 2'b01, YELLOW = 2'b10, GREEN = 2'b11;
    reg [1:0]state = INIT;
    
    assign {red, yellow, green} = (4'b1000 >> state) & {7{enable}};

    always @(posedge clk) begin
        case (state)
            INIT: begin
                if (init_state == INIT) state = RED;
                else state = init_state;
                
                case (state)
                    RED: counter = count_red - 1;
                    YELLOW: counter = count_yellow - 1;
                    GREEN: counter = count_green - 1;
                endcase
            end
            RED: begin                
                if (counter == 0) begin
                    counter = count_green;
                    state = GREEN;
                end
                counter = counter - 1;
            end
            YELLOW: begin
                if (counter == 0) begin
                    counter = count_red;
                    state = RED;
                end
                counter = counter - 1;
            end
            
            GREEN: begin
                if (counter == 0) begin
                    counter = count_yellow;
                    state = YELLOW;
                end
                counter = counter - 1;
            end
        endcase
        
        counter = counter & {7{enable}};
        state = state & {2{enable}};
    end
endmodule
