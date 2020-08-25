`timescale 1ns / 1ps

module test_stopwatch();

    reg clk65MHz, rst, start, stop;
    wire minutes, seconds;
    
    stopwatch MG_stopwatch(
        .clk(clk65MHz),
        .rst(rst),
        .start(start),
        .pause(1'b0),
        .stop(stop),
        .minutes(minutes),
        .seconds(seconds)
    );

    initial begin
        clk65MHz = 0;
    end
    
    always begin 
    #15 clk65MHz = !clk65MHz;
    end
        
    initial begin
        #50 rst = 1'b0;
        #100 rst = 1'b1;
        #50 rst = 1'b0;
        #50 stop = 1'b0;
        #100 start = 1'b1;
        #50 start = 1'b0;
    end
endmodule