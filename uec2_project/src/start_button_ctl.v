`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 23.07.2020 18:40:43
// Module Name: start_button_ctl
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


module start_button_ctl
    #( parameter
        X_POS   = 312,
        Y_POS   = 284,
        WIDTH   = 400,
        HEIGHT  = 200,
        COLOR   = 12'h0_A_A
    )
    (
    input wire          clk,
    input wire          rst,
    input wire          mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    output reg [11:0]   color_out
    );
    
    reg [11:0] color_out_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            color_out <= 12'h0_A_A;
        end
        else begin
            color_out <= color_out_nxt;
        end
    end
    
    always @* begin
        if(mouse_left) begin
            if(mouse_xpos > X_POS && mouse_xpos < X_POS+WIDTH && mouse_ypos > Y_POS && mouse_ypos < Y_POS+HEIGHT) begin
                color_out_nxt = 12'h0_F_0;
            end
            else begin
                color_out_nxt = color_out;
            end
        end
        else begin
            color_out_nxt = color_out;
        end
    end
endmodule
