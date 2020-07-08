//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:57:42
// Module Name: draw_rect_ctl
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.10 - File Copied from UEC2 Lab
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps


module draw_rect_ctl(
    input wire          clk,
    input wire          rst,
    input wire          mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output reg [11:0]   xpos,
    output reg [11:0]   ypos
    );
    
    localparam STATE_DOWN = 2'b01;
    localparam STATE_UP = 2'b10;
    localparam STATE_END = 2'b11;
    localparam STATE_DEFAULT = 2'b00;
    
    localparam COUNTER_LIMIT_VAL = 2_000_000; //every 0.05s acceleration increase or decrease by ACCELERATION_CONST
    localparam ACCELERATION_CONST = 2;
    localparam SCREEN_HEIGHT = 600;
    localparam RECT_HEIGHT = 64;
    
    reg [11:0] xpos_nxt, ypos_nxt, xpos_temp, ypos_temp, xpos_temp_nxt, ypos_temp_nxt, ypos_upper_limit, ypos_upper_limit_nxt;
    reg [1:0] state, state_nxt;
    reg [21:0] counter, counter_nxt, counter_time, counter_time_nxt;//, counter_max, counter_max_nxt; //max = 4 194 304
    reg [8:0]  acceleration, acceleration_nxt;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst) begin
            xpos <= 0;
            ypos <= 0;
            xpos_temp <= 0;
            ypos_temp <= 0;
            ypos_upper_limit <= 0;
            state <= STATE_DEFAULT;
            counter <= 0;
            counter_time <= COUNTER_LIMIT_VAL;
            acceleration <= 0;
        end
        else begin
            xpos <= xpos_nxt;
            ypos <= ypos_nxt;
            xpos_temp <= xpos_temp_nxt;
            ypos_temp <= ypos_temp_nxt;
            ypos_upper_limit <= ypos_upper_limit_nxt;
            state <= state_nxt;
            counter <= counter_nxt;
            counter_time <= counter_time_nxt;
            acceleration <= acceleration_nxt;
        end
    end
    
    always @*
    begin
        case(state)
        STATE_DOWN: begin
            xpos_nxt = xpos_temp;
            ypos_nxt = ypos_temp;
            if(counter_time == COUNTER_LIMIT_VAL) begin
                counter_time_nxt = 0;
                acceleration_nxt = acceleration+ACCELERATION_CONST;
            end
            else begin
                counter_time_nxt = counter_time+1;
                acceleration_nxt = acceleration;
            end
            if(ypos_temp == (SCREEN_HEIGHT-RECT_HEIGHT)) begin
                state_nxt = STATE_UP;
                counter_nxt = 0;
                xpos_temp_nxt = xpos_temp;
                ypos_temp_nxt = ypos_temp;
                if((SCREEN_HEIGHT-ypos_upper_limit)/2 < (SCREEN_HEIGHT-ypos_upper_limit)) begin
                    ypos_upper_limit_nxt = SCREEN_HEIGHT-((SCREEN_HEIGHT-ypos_upper_limit)/2);
                end
                else begin
                    ypos_upper_limit_nxt = ypos_upper_limit+1;
                end
                acceleration_nxt = acceleration*2/3;
            end
            else if(counter >= COUNTER_LIMIT_VAL) begin
                state_nxt = state;
                counter_nxt = 0;
                xpos_temp_nxt = xpos_temp;
                ypos_temp_nxt = ypos_temp+1;
                ypos_upper_limit_nxt = ypos_upper_limit;
            end
            else begin
                state_nxt = state;
                counter_nxt = counter+acceleration;
                xpos_temp_nxt = xpos_temp;
                ypos_temp_nxt = ypos_temp;
                ypos_upper_limit_nxt = ypos_upper_limit;
            end
        end
        STATE_UP: begin
            xpos_nxt = xpos_temp;
            ypos_nxt = ypos_temp;
            xpos_temp_nxt = xpos_temp;
            ypos_upper_limit_nxt = ypos_upper_limit;
            if(ypos_upper_limit >= (SCREEN_HEIGHT-RECT_HEIGHT)) begin
                state_nxt = STATE_END;
                counter_nxt = counter;
                counter_time_nxt = counter_time;
                acceleration_nxt = acceleration;
                ypos_temp_nxt = ypos_temp;
            end
            else begin
                if(counter_time == COUNTER_LIMIT_VAL) begin
                    counter_time_nxt = 0;
                    if((acceleration-ACCELERATION_CONST) < acceleration) begin
                        acceleration_nxt = acceleration-ACCELERATION_CONST;
                    end
                    else begin
                        acceleration_nxt = 0;
                    end
                end
                else begin
                    counter_time_nxt = counter_time+1;
                    acceleration_nxt = acceleration;
                end
                if(acceleration_nxt == 0) begin
                    state_nxt = STATE_DOWN;
                    counter_nxt = 0;
                    ypos_temp_nxt = ypos_temp;
                    acceleration_nxt = 0;
                    ypos_upper_limit_nxt = ypos_temp;
                end
                else if(counter >= COUNTER_LIMIT_VAL) begin
                    state_nxt = state;
                    counter_nxt = 0;
                    ypos_temp_nxt = ypos_temp-1;   
                end
                else begin
                    state_nxt = state;
                    counter_nxt = counter+acceleration;
                    ypos_temp_nxt = ypos_temp;
                end
            end
        end
        STATE_END: begin
            xpos_nxt = xpos_temp;
            ypos_nxt = ypos_temp;
            ypos_upper_limit_nxt = ypos_upper_limit;
            counter_nxt = counter;
            acceleration_nxt = 0;
            counter_time_nxt = 0;
            state_nxt = state;
            xpos_temp_nxt = xpos_temp;
            ypos_temp_nxt = ypos_temp;
        end
        default: begin
            xpos_temp_nxt = mouse_xpos;
            ypos_temp_nxt = mouse_ypos;
            xpos_nxt = mouse_xpos;
            ypos_nxt = mouse_ypos;
            counter_nxt = 0;
            acceleration_nxt = 0;
            counter_time_nxt = 0;
            if(mouse_left) begin
                state_nxt = STATE_DOWN;
                ypos_upper_limit_nxt = mouse_ypos;
            end
            else begin
                state_nxt = state;
                ypos_upper_limit_nxt = ypos_upper_limit;
            end
        end
        endcase
    end
endmodule
