`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 25.08.2020 21:31:03
// Module Name: stopwatch
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stopwatch(
    input wire clk,
    input wire rst,
    input wire start,
    input wire pause,
    input wire stop,
    output reg minute_passed,
    output reg [5:0] seconds,
    output reg [6:0] hundredths_of_second
    );
    
    reg minute_passed_nxt;
    reg [5:0] seconds_nxt;
    reg [6:0] hundredths_of_second_nxt;
    reg [25:0] ctr, ctr_nxt;
    reg [1:0] state, state_nxt;
    
    localparam
    IDLE = 2'b00,
    COUNT = 2'b11,
    PAUSE = 2'b01;
    
    localparam
    VALUE_EQUAL_ONE_SEC = 65_000_000,
    VALUE_EQUAL_TEN_MS = 650_000;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            seconds <= 0;
            hundredths_of_second <= 0;
            ctr <= 0;
            minute_passed <= 0;
        end
        else begin
            state <= state_nxt;
            seconds <= seconds_nxt;
            hundredths_of_second <= hundredths_of_second_nxt;
            ctr <= ctr_nxt;
            minute_passed <= minute_passed_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        seconds_nxt = seconds;
        hundredths_of_second_nxt = hundredths_of_second;
        ctr_nxt = 0;
        minute_passed_nxt = minute_passed;
        
        case(state)
            IDLE: begin
                if(start) begin
                    state_nxt = COUNT;
                    seconds_nxt = 0;
                    hundredths_of_second_nxt = 0;
                    minute_passed_nxt = 0;
                end
                else begin
                    state_nxt = state;
                end
            end
            COUNT: begin
                state_nxt = pause ? PAUSE :
                            stop ? IDLE : state;
                if(ctr == VALUE_EQUAL_TEN_MS) begin
                    ctr_nxt = 0;
                    if(hundredths_of_second == 99) begin
                        if(seconds == 59) begin
                           minute_passed_nxt = 1'b1; 
                           seconds_nxt = 0;
                           hundredths_of_second_nxt = 0;
                        end
                        else begin
                            hundredths_of_second_nxt = 0;
                            seconds_nxt = seconds + 1;
                        end
                    end
                    else begin
                        hundredths_of_second_nxt = hundredths_of_second + 1;
                        seconds_nxt = seconds;
                    end
                end
                else begin
                    ctr_nxt = ctr + 1;
                end
            end
            
            PAUSE: begin
                state_nxt = start ? COUNT :
                            stop ? IDLE : state;
                ctr_nxt = ctr;
            end
        endcase
    end
endmodule
