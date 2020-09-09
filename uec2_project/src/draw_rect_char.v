`timescale 1ns / 1ps
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
`include "_vga_macros.vh"

module draw_rect_char
    #( parameter
        X_POS   = 412,
        Y_POS   = 328,
        WIDTH   = 200,
        HEIGHT  = 112
    )
    (
    input wire          clk,
    input wire          rst,
    input wire [7:0]    char_pixels,
    input wire          enable,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output reg [9:0]    char_yx,
    output reg [3:0]    char_line
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)  

    reg [4:0] char_y, char_x;
    reg [3:0] char_line_nxt;
    wire [10:0] hcount_in_delayed, vcount_in_delayed;
    wire hs_in_delayed, vs_in_delayed, hblnk_in_delayed, vblnk_in_delayed;
    wire [11:0] rgb_in_delayed;
    reg [11:0] rgb_nxt;

    always @(posedge clk)
    begin
        if(rst) begin
            hs_out <= 0;
            vs_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
            char_yx <= 10'bx;
            char_line <= 4'bx;
        end
        else begin
            // Just pass these through.
            hs_out <= hs_in_delayed;
            vs_out <= vs_in_delayed;
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
    reg [7:0] xdiff;
    reg [8:0] ydiff;
    wire [2:0] xdiff_delayed;
    
    always @*
    begin
        if(enable && ((vcount_in >= Y_POS) && (vcount_in < Y_POS+HEIGHT) && (hcount_in >= X_POS) && (hcount_in < X_POS+WIDTH))) begin
            xdiff = hcount_in-X_POS;
            ydiff = vcount_in-Y_POS;
        end
        else begin
            xdiff = 8'bx;
            ydiff = 9'bx;
        end
    end
    
    //calculate char_line_nxt, char_x, char_y
    
    always @*
    begin
        char_line_nxt = ydiff[3:0];
        char_y = ydiff[8:4];
        char_x = xdiff[7:3];
    end
    
    always @*
    begin
        if(enable && ((vcount_in_delayed >= Y_POS) && (vcount_in_delayed < Y_POS+HEIGHT) && (hcount_in_delayed >= X_POS) && (hcount_in_delayed < X_POS+WIDTH))) begin
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
        .din({rgb_in, hcount_in, vcount_in, hs_in, vs_in, hblnk_in, vblnk_in, xdiff[2:0]}),
        .dout({rgb_in_delayed, hcount_in_delayed, vcount_in_delayed, hs_in_delayed, vs_in_delayed, hblnk_in_delayed, vblnk_in_delayed, xdiff_delayed})
    );
    
endmodule
