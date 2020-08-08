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


module event_checker
    #( parameter
        X_POS   = 312,
        Y_POS   = 284,
        WIDTH   = 400,
        HEIGHT  = 200
    )
    (
    input wire          clk,
    input wire          rst,    
    input wire          enable,
    input wire          kind_of_event,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output reg          event_occured
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
        if(enable) begin
            if(kind_of_event) begin
                if((mouse_xpos > X_POS) && (mouse_xpos < X_POS + WIDTH) && (mouse_ypos > Y_POS) && (mouse_ypos < Y_POS + HEIGHT)) begin
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
