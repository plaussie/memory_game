`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2020 14:27:10
// Design Name: 
// Module Name: clock_test
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


module clock_test();

    reg clk, rst;

    initial begin
        clk = 0;
        rst = 1;
    end
    
    always begin 
    #10 clk = !clk;
    end
    
    wire clk65MHz;
    wire locked;
    
    clock_generator MG_clock (
        // Clock out ports
        .clk65MHz(clk65MHz),
        // Status and control signals
        .reset(rst),
        .locked(locked),
        // Clock in ports
        .clk(clk)
    );
    
    initial begin
        #50 rst = 0;
        #100 rst = 0;
        #500 rst = 0;
        #100 rst = 0;
        
    end

endmodule
