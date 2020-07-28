`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 24.07.2020 12:55:00
// Module Name: draw_one_card
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


module draw_one_card
    #( parameter
    X_POS = 50,
    Y_POS = 50,
    WIDTH = 200,
    HEIGHT = 400,
    COLOR = 12'hF_0_0
    )
    (
    input wire          do,
    
    input wire [10:0]   vcount_in,
    input wire [10:0]   hcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    
    input wire [11:0]   rgb_in,
    
    output reg [10:0]   vcount_out,
    output reg [10:0]   hcount_out,
    output reg          vsync_out,
    output reg          hsync_out,
    output reg          hblnk_out,
    output reg          vblnk_out,
    
    output reg [11:0]   rgb_out,
    
    input wire          pclk,
    input wire          rst
    );
    
    reg [11:0] rgb_nxt;
       
    always @(posedge pclk)
    begin
        if(rst) begin
            hsync_out <= 0;
            vsync_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
        end
        else begin
            // Just pass these through.
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
            // Changing color in rectangle place
            rgb_out <= rgb_nxt;
        end
    end
    
    always @*
        begin
            if (do && ((hcount_in >= X_POS) && (hcount_in < X_POS+WIDTH) && (vcount_in >= Y_POS) && (vcount_in < Y_POS+HEIGHT))) begin
                rgb_nxt <= COLOR;
            end
            else begin
                rgb_nxt <= rgb_in;
            end
        end
endmodule
