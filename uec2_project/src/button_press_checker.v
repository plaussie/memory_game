`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 23.07.2020 19:44:19
// Module Name: button_press_checker
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


module button_press_checker
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
    input wire          mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output reg          button_pressed
    );
    
    reg button_pressed_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            button_pressed <= 0;
        end
        else begin
            button_pressed <= button_pressed_nxt;
        end
    end
    
    always @* begin
        if(enable) begin
            if(mouse_left) begin
                if((mouse_xpos > X_POS) && (mouse_xpos < X_POS + WIDTH) && (mouse_ypos > Y_POS) && (mouse_ypos < Y_POS + HEIGHT)) begin
                    button_pressed_nxt = 1;
                end
                else begin
                    button_pressed_nxt = 0;
                end
            end
            else begin
                button_pressed_nxt = 0;
            end
        end
        else begin
            button_pressed_nxt = 0;
        end
    end
endmodule
