`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2023 09:54:36 AM
// Design Name: 
// Module Name: manager_tb
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


module manager_tb(

    );
    reg clk, button_0, button_1, sw_0, sw_1;
    
    wire en_led7seg;
    wire [2:0]traffic_0, traffic_1;
    wire [6:0]led7seg_0, led7seg_1;
    
    reg [7:0] counter;
         
    always #2 clk = ~clk;
    
    
    initial begin
        counter = 8'b00000000;
        clk = 1'b0;
        button_0 = 1'b1;
        button_1 = 1'b1;
        sw_0 = 1'b0;
        sw_1 = 1'b0;
        #100 sw_0 = 1'b1;
        sw_1 = 1'b1;
        for (counter = 8'b00000000; counter < 11; counter = counter + 1) begin
            #1;
            if (counter == 5) begin
                button_1 = 1'b0;
            end else if (counter == 10) begin
                button_1 = 1'b1;
                sw_1 = 1'b0;
                #1 sw_1 = 1'b1;
            end
            
            if (counter % 10 == 0) begin 
                button_0 = 1'b0;
            end else begin
                button_0 = 1'b1;
            end
        end
        
        button_0 = 1'b1;
        button_1 = 1'b1;
        
        sw_0 = 1'b0;
        sw_1 = 1'b0;
    end
    
    manager UUT(
                .clk(clk),
                .button_0(button_0),             // change traffic light in manual mode
                .button_1(button_1),             // increase time
                .sw_0(sw_0),                 // set time
                .sw_1(sw_1),                 // switch between auto mode and manual mode
                .traffic_0(traffic_0),     // traffic light on first way
                .traffic_1(traffic_1),     // traffic light on second way
                .en_led7seg(en_led7seg),              // enable 7-segment led
                .led7seg_0(led7seg_0),     
                .led7seg_1(led7seg_1)
                );
        
endmodule
