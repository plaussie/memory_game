`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 25.08.2020 18:31:31
// Module Name: endgame_screen
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
`include "_vga_macros.vh"
`include "_cards_macros.vh" 
`include "_game_params.vh"

module endgame_screen(
    input wire pclk,
    input wire rst,
    input wire enable,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire game_over_en,
    input wire [7:0] discovered_pairs_ctr,
    input wire [12:0] game_time, // {seconds, hundredths_of_second}
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
     
    wire [7:0] char_pixels;
    wire [9:0] char_yx;
    wire [6:0] char_code;
    wire [3:0] char_line;  
    wire [13:0] final_score; 
    wire [12:0] mult_time_result, mult_discovered_pairs_result;
    wire [5:0] time_multiplier, discovered_pairs_multiplier;
    wire points_calculated; 

    draw_rect_char
    #(
        .X_POS(`END_POPUP_X_POS),
        .Y_POS(`END_POPUP_Y_POS),
        .WIDTH(`END_POPUP_WIDTH),
        .HEIGHT(`END_POPUP_HEIGHT)
    )    
    endgame_rect(
        .clk(pclk),
        .rst(rst),
        .char_pixels(char_pixels),
        .enable(enable),
        .vga_in(vga_in),
        .vga_out(vga_out),
        .char_yx(char_yx),
        .char_line(char_line)
    );
    
    font_rom endgame_font_rom(
        .clk(pclk),
        .addr({char_code[6:0], char_line[3:0]}),
        .char_line_pixels(char_pixels)
    );

    points_calculator MG_points_calculator(
        .clk(pclk),
        .rst(rst),
        .enable(enable),
        .mult_time_result(mult_time_result),
        .mult_discovered_pairs_result(mult_discovered_pairs_result),
        .num_of_cards(num_of_cards),
        .discovered_pairs_ctr(discovered_pairs_ctr),
        .seconds(game_time[12:7]),
        .discovered_pairs_multiplier(discovered_pairs_multiplier),
        .time_multiplier(time_multiplier),
        .points_calculated(points_calculated),
        .points(final_score)
    );
    
    multiplier MG_discovered_pairs_multiplier(
        .CLK(pclk),
        .A(discovered_pairs_multiplier),
        .CE(enable),
        .P(mult_discovered_pairs_result)
    );
    
    multiplier MG_time_multiplier(        
        .CLK(pclk),
        .A(time_multiplier),
        .CE(enable),
        .P(mult_time_result)
    );
    
    char_rom_32x32 endgame_char_rom(
        .clk(pclk),
        .rst(rst),
        .points_calculated(points_calculated),
        .enable(enable),
        .game_over_en(game_over_en),
        .game_time(game_time),
        .final_score(final_score),
        .char_yx(char_yx),
        .char_code(char_code)
    );
endmodule
