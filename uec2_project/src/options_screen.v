`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 30.08.2020 22:12:47
// Module Name: options_screen
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

`include "_cards_macros.vh"
`include "_game_params.vh"
`include "_vga_macros.vh"

module options_screen(
    input wire clk,
    input wire rst,
    input wire difficulty_butts_en,
    input wire mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output reg [`CARD_MAX_NUM_SIZE-1:0] num_of_cards
    );
    
    wire easy_butt_pressed, normal_butt_pressed, hard_butt_pressed;
    
    reg [`CARD_MAX_NUM_SIZE-1:0] num_of_cards_nxt;
    wire [`VGA_BUS_SIZE-1:0] vga_internal_bus [`CARD_LEVEL_NUM:0];
    assign vga_internal_bus[0] = vga_in;
    assign vga_out = vga_internal_bus[`CARD_LEVEL_NUM];
    
    //***Easy Button Display & Press Checker***//       
    
    buttonCtl
    #(
        .X_POS(`EASY_BUTTON_X_POS),
        .Y_POS(`EASY_BUTTON_Y_POS),
        .WIDTH(`EASY_BUTTON_WIDTH),
        .HEIGHT(`EASY_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`EASY_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`EASY_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`EASY_BUTTON_ROM_PATH)
    )
    display_clickable_easy (
        .clk(clk),
        .rst(rst),
        .enable(difficulty_butts_en),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .vga_in(vga_internal_bus[0]),
        .button_pressed(easy_butt_pressed),
        .vga_out(vga_internal_bus[1])
    );
    
    //***Normal Button Display & Press Checker***// 
    
    buttonCtl
    #(
        .X_POS(`NORMAL_BUTTON_X_POS),
        .Y_POS(`NORMAL_BUTTON_Y_POS),
        .WIDTH(`NORMAL_BUTTON_WIDTH),
        .HEIGHT(`NORMAL_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`NORMAL_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`NORMAL_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`NORMAL_BUTTON_ROM_PATH)
    )
    display_clickable_normal (
        .clk(clk),
        .rst(rst),
        .enable(difficulty_butts_en),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .vga_in(vga_internal_bus[1]),
        .button_pressed(normal_butt_pressed),
        .vga_out(vga_internal_bus[2])
    );
    
    //***Hard Button Display & Press Checker***// 
    
    buttonCtl
    #(
        .X_POS(`HARD_BUTTON_X_POS),
        .Y_POS(`HARD_BUTTON_Y_POS),
        .WIDTH(`HARD_BUTTON_WIDTH),
        .HEIGHT(`HARD_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`HARD_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`HARD_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`HARD_BUTTON_ROM_PATH)
    )
    display_clickable_hard (
        .clk(clk),
        .rst(rst),
        .enable(difficulty_butts_en),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .vga_in(vga_internal_bus[2]),
        .button_pressed(hard_butt_pressed),
        .vga_out(vga_internal_bus[3])
    );
    
    always @(posedge clk) begin
        if(rst) begin
            num_of_cards <= `CARD_NUM_NORMAL;
        end
        else begin
            num_of_cards <= num_of_cards_nxt;
        end
    end
    
    always @* begin
        num_of_cards_nxt = easy_butt_pressed ? `CARD_NUM_EASY :
                           normal_butt_pressed ? `CARD_NUM_NORMAL :
                           hard_butt_pressed ? `CARD_NUM_HARD : num_of_cards;
    end
endmodule
