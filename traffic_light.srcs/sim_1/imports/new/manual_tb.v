`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 03:11:06 PM
// Design Name: 
// Module Name: manual_tb
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


module manual_tb(

    );
    
    reg clk, button, enable;
    reg [7:0] index;
    reg [1:0]mode;
    reg [6:0]cur_red, cur_green, cur_yellow;
    wire [2:0]first_way, second_way;
    wire [6:0]new_red, new_green, new_yellow;
    
    always #1 clk = ~clk;
    always begin
        #50 mode = mode + 1;
        enable = 1'b0;
        #2 enable = 1'b1;
    end
    
    manual_mode manual(.enable(enable),
                       .mode(mode),
                       .increase(button),
                       .cur_red(cur_red),
                       .cur_yellow(cur_yellow),
                       .cur_green(cur_green),
                       .new_red(new_red),
                       .new_yellow(new_yellow),
                       .new_green(new_green),
                       .first_way(first_way),
                       .second_way(second_way));
    
    initial begin
        clk = 1'b0;
        enable = 1'b1;
        button = 1'b1;
        mode = 2'b00;
        cur_red = 7'd5;
        cur_yellow = 7'd2;
        cur_green = 7'd3;
        
        for (index = 0; index < 10; index = index + 1) begin 
            #10 button = ~button;
            #5 button = ~button;
        end
    end
    
endmodule
