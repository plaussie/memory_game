`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 25.08.2020 18:31:31
// Module Name: endgame_screen
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivaenable 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "_vga_macros.vh"

module endgame_screen(
    input wire pclk,
    input wire rst,
    input wire enable,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)  
    
    wire [7:0] char_pixels;
    wire [9:0] char_yx;
    wire [6:0] char_code;
    wire [3:0] char_line;
    
    draw_rect_char endscreen_sign(
        .clk(pclk),
        .rst(rst),
        .char_pixels(char_pixels),
        .enable(enable),
        .vga_in(vga_in),
        .vga_out(vga_out),
        .char_yx(char_yx),
        .char_line(char_line)
    );
    
    font_rom MG_font_rom(
        .clk(pclk),
        .addr({char_code[6:0], char_line[3:0]}),
        .char_line_pixels(char_pixels)
    );
    
    char_rom_17x28 endgame_char(
        .clk(pclk),
        .char_yx(char_yx),
        .char_code(char_code)
    );
endmodule
