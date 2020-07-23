`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 23.07.2020 19:44:19
// Module Name: event_checker
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


module event_checker (
    input wire          clk,
    
    input wire          start,
    
    input wire [11:0]   x_begin,
    input wire [11:0]   x_end,
    input wire [11:0]   y_begin,
    input wire [11:0]   y_end,
    
    input wire          kind_of_event,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output reg          event_occured,
    
    input wire          rst
    );
    
    reg event_occured_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            event_occured <= 0;
        end
        else begin
            event_occured <= event_occured_nxt;
        end
    end
    
    always @* begin
        if(start) begin
            if(kind_of_event) begin
                if(mouse_xpos > x_begin && mouse_xpos < x_end && mouse_ypos > y_begin && mouse_ypos < y_end) begin
                    event_occured_nxt = 1;
                end
                else begin
                    event_occured_nxt = 0;
                end
            end
            else begin
                event_occured_nxt = 0;
            end
        end
        else begin
            event_occured_nxt = 0;
        end
    end
endmodule
