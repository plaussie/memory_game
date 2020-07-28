//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:55:42
// Module Name: draw_rect_char
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

module draw_rect_char(
    input wire [10:0]   vcount_in,
    input wire [10:0]   hcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    
    input wire [11:0]   rgb_in,
    input wire [7:0]    char_pixels,
    
    output reg [10:0]   vcount_out,
    output reg [10:0]   hcount_out,
    output reg          vsync_out,
    output reg          hsync_out,
    output reg          hblnk_out,
    output reg          vblnk_out,
    
    output reg [11:0]   rgb_out,
    output reg [7:0]    char_yx,
    output reg [3:0]    char_line,
    
    input wire          clk,
    input wire          rst
    );

    localparam RECT_POS_X = 330;
    localparam RECT_POS_Y = 200;
    localparam RECT_WIDTH = 128;
    localparam RECT_HEIGHT = 256;

    reg [3:0] char_y, char_x, char_line_nxt;
    wire [10:0] hcount_in_delayed, vcount_in_delayed;
    wire hsync_in_delayed, vsync_in_delayed, hblnk_in_delayed, vblnk_in_delayed;
    wire [11:0] rgb_in_delayed;
    reg [11:0] rgb_nxt;

    always @(posedge clk)
    begin
        if(rst) begin
            hsync_out <= 0;
            vsync_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
            char_yx <= 8'bx;
            char_line <= 4'bx;
        end
        else begin
            // Just pass these through.
            hsync_out <= hsync_in_delayed;
            vsync_out <= vsync_in_delayed;
            hblnk_out <= hblnk_in_delayed;
            vblnk_out <= vblnk_in_delayed;
            hcount_out <= hcount_in_delayed;
            vcount_out <= vcount_in_delayed;
            char_yx <= {char_y, char_x};
            char_line <= char_line_nxt;
            rgb_out <= rgb_nxt;
        end
    end
    
    //calculate xdiff and ydiff
    reg [6:0] xdiff;
    reg [7:0] ydiff;
    wire [2:0] xdiff_delayed;
    
    always @*
    begin
        if((vcount_in >= RECT_POS_Y) && (vcount_in < RECT_POS_Y+RECT_HEIGHT) && (hcount_in >= RECT_POS_X) && (hcount_in < RECT_POS_X+RECT_WIDTH)) begin
            xdiff = hcount_in-RECT_POS_X;
            ydiff = vcount_in-RECT_POS_Y;
        end
        else begin
            xdiff = 7'bx;
            ydiff = 8'bx;
        end
    end
    
    //calculate char_line_nxt, char_x, char_y
    
    always @*
    begin
        char_line_nxt = ydiff[3:0];
        char_y = ydiff[7:4];
        char_x = xdiff[6:3];
    end
    
    always @*
    begin
        if((vcount_in_delayed >= RECT_POS_Y) && (vcount_in_delayed < RECT_POS_Y+RECT_HEIGHT) && (hcount_in_delayed >= RECT_POS_X) && (hcount_in_delayed < RECT_POS_X+RECT_WIDTH)) begin
            if(char_pixels[7-xdiff_delayed] == 1) begin
                rgb_nxt = 12'h0_0_0;
            end
            else begin
                rgb_nxt = rgb_in_delayed;
            end
        end
        else begin
            rgb_nxt = rgb_in_delayed;
        end
    end
   
    //delaying inputs by 2 cycles
    
    delay
    #(
        .WIDTH(41),
        .CLK_DEL(3)
    )
    delay_in_draw_rect_char (
        .clk(clk),
        .rst(rst),
        .din({rgb_in, hcount_in, vcount_in, hsync_in, vsync_in, hblnk_in, vblnk_in, xdiff[2:0]}),
        .dout({rgb_in_delayed, hcount_in_delayed, vcount_in_delayed, hsync_in_delayed, vsync_in_delayed, hblnk_in_delayed, vblnk_in_delayed, xdiff_delayed})
    );
    
endmodule