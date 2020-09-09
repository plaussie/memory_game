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
`include "_vga_macros.vh"

module endgame_screen(
    input wire pclk,
    input wire rst,
    input wire enable,
    input wire game_over_en,
    input wire [5:0] discovered_pairs_ctr,
    input wire [12:0] game_time, // {seconds, hundredths_of_second}
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
     
    wire [2:0] seconds_dozens, discovered_pairs_ctr_dozens, discovered_pairs_ctr_unity; 
    wire [3:0] seconds_unity, hundredths_of_second_unity, hundredths_of_second_dozens;
    wire [7:0] char_pixels;
    wire [9:0] char_yx;
    wire [6:0] char_code;
    wire [3:0] char_line;
    

    draw_rect_char endscreen_rect(
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
    
    assign seconds_dozens = game_time[12:7]/4'd10;
    assign seconds_unity = game_time[12:7]%4'd10;
    assign hundredths_of_second_dozens = game_time[6:0]/4'd10;
    assign hundredths_of_second_unity = game_time[6:0]%4'd10;
    assign discovered_pairs_ctr_dozens = discovered_pairs_ctr/4'd10;
    assign discovered_pairs_ctr_unity = discovered_pairs_ctr%4'd10;
    
    char_rom_17x28 endgame_chars(
        .clk(pclk),
        .game_over_en(game_over_en),
        .discovered_pairs_ctr({discovered_pairs_ctr_dozens, discovered_pairs_ctr_unity}),
        .seconds_dozens_unity({seconds_dozens, seconds_unity}),
        .hundredths_of_second({hundredths_of_second_dozens, hundredths_of_second_unity}),
        .char_yx(char_yx),
        .char_code(char_code)
    );
endmodule
