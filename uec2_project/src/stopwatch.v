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
    output reg [5:0] minutes,
    output reg [5:0] seconds
    );
    
    reg [5:0] minutes_nxt, seconds_nxt;
    reg [24:0] ctr, ctr_nxt;
    reg [1:0] state, state_nxt;
    
    localparam
    IDLE = 2'b00,
    COUNT = 2'b11,
    PAUSE = 2'b01;
    
    localparam
    VALUE_EQUAL_1000MS = 32500000;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            minutes <= 0;
            seconds <= 0;
            ctr <= 0;
        end
        else begin
            state <= state_nxt;
            minutes <= minutes_nxt;
            seconds <= seconds_nxt;
            ctr <= ctr_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        minutes_nxt = minutes;
        seconds_nxt = seconds;
        ctr_nxt = 0;
        
        case(state)
            IDLE: begin
                if(start) begin
                    state_nxt = COUNT;
                    seconds_nxt = 0;
                    minutes_nxt = 0;
                end
                else begin
                    state_nxt = state;
                end
            end
            COUNT: begin
                state_nxt = pause ? PAUSE :
                            stop ? IDLE : state;
                if(ctr == VALUE_EQUAL_1000MS) begin
                    ctr_nxt = 0;
                    if(seconds == 59) begin
                        seconds_nxt = 0;
                        minutes_nxt = (minutes == 59) ? 0 : (minutes + 1);
                    end
                    else begin
                        seconds_nxt = seconds + 1;
                        minutes_nxt = minutes;
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
