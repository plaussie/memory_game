`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 17.09.2020 12:00:28 
// Module Name: vgaCtl
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

module vgaCtl(
    input wire clk,
    input wire rst,
    input wire left,
    input wire [11:0] xpos, ypos,
    input wire [`CARD_DATA_SIZE-1:0] regfile_r_data,
    input wire start_butt_en, options_screen_en, wait_for_click_en,
               end_screen_en, update_cards_en_delayed_2tact, minute_passed,
    input wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position,
    input wire [12:0] game_time,
    input wire [7:0] discovered_pairs_ctr,
    
    output wire start_butt_pressed, difficulty_butts_pressed, back_butt_pressed, menu_butt_pressed, card_pressed,
    output wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    output wire [`CARD_ADDRESS_SIZE-1:0] card_to_test_address, card_clicked_address,
    output wire [13:0] vga_out
    );
        
    //params
    localparam
        NUM_MODULES = 7;
     
    wire [`VGA_BUS_SIZE-1:0] vga_bus [NUM_MODULES:0];
    wire [`VGA_BUS_SIZE-1:0] vga_last;
    assign vga_last = vga_bus[NUM_MODULES];
    
    //unused
    wire enable_mouse_display_out;

    //***VGA Timings Generator***//

    vga_timing MG_vga_timing (
        .pclk(clk),
        .rst(rst),
        .vga_out(vga_bus[0])
    );

    //***Background Display***//
    
    draw_image_rom 
    #(
        .X_POS(`BACKGROUND_X_POS),
        .Y_POS(`BACKGROUND_Y_POS),
        .WIDTH(`BACKGROUND_WIDTH),
        .HEIGHT(`BACKGROUND_HEIGHT),
        .ROM_WIDTH_SIZE(`BACKGROUND_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`BACKGROUND_ROM_HEIGHT_SIZE),
        .ROM_PATH(`BACKGROUND_ROM_PATH),
        .TXT_COLOR(`BACKGROUND_TXT_COLOR),
        .BACKGROUND_COLOR(`BACKGROUND_COLOR)
    )
    display_background(
        .pclk(clk),
        .rst(rst),
        .enable(1'b1),
        .vga_in(vga_bus[0]),
        .vga_out(vga_bus[1])
    ); 
    
    //***Start Button Display & Press Checker***//       

    buttonCtl
    #(
        .X_POS(`START_BUTTON_X_POS),
        .Y_POS(`START_BUTTON_Y_POS),
        .WIDTH(`START_BUTTON_WIDTH),
        .HEIGHT(`START_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`START_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`START_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`START_BUTTON_ROM_PATH),
        .TXT_COLOR(`BUTTON_TXT_COLOR),
        .BACKGROUND_COLOR(`BUTTON_COLOR)  
    )
    display_clickable_start (
        .clk(clk),
        .rst(rst),
        .enable(start_butt_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[1]),
        .button_pressed(start_butt_pressed),
        .vga_out(vga_bus[2])
    );
    

    //***OptionsScreen Display***//
    
    options_screen display_optionsscreen(
        .clk(clk),                                  
        .rst(rst),                                  
        .enable(options_screen_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3]),
        .difficulty_butts_pressed(difficulty_butts_pressed),
        .num_of_cards(num_of_cards)
    );
    
    //***Back Button Display & Press Checker***// 
        
    buttonCtl
    #(
        .X_POS(`BACK_BUTTON_X_POS),
        .Y_POS(`BACK_BUTTON_Y_POS),
        .WIDTH(`BACK_BUTTON_WIDTH),
        .HEIGHT(`BACK_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`BACK_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`BACK_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`BACK_BUTTON_ROM_PATH),
        .TXT_COLOR(`BUTTON_TXT_COLOR),
        .BACKGROUND_COLOR(`BUTTON_COLOR)
    )
    display_clickable_back (
        .clk(clk),
        .rst(rst),
        .enable(options_screen_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[3]),
        .button_pressed(back_butt_pressed),
        .vga_out(vga_bus[4])
    );
    
    //***Menu Button Display & Press Checker***// 
            
    buttonCtl
    #(
        .X_POS(`MENU_BUTTON_X_POS),
        .Y_POS(`MENU_BUTTON_Y_POS),
        .WIDTH(`MENU_BUTTON_WIDTH),
        .HEIGHT(`MENU_BUTTON_HEIGHT),
        .ROM_WIDTH_SIZE(`MENU_BUTTON_ROM_WIDTH_SIZE),
        .ROM_HEIGHT_SIZE(`MENU_BUTTON_ROM_HEIGHT_SIZE),
        .ROM_PATH(`MENU_BUTTON_ROM_PATH),
        .TXT_COLOR(`BUTTON_TXT_COLOR),
        .BACKGROUND_COLOR(`BUTTON_COLOR)
    )
    display_clickable_menu (
        .clk(clk),
        .rst(rst),
        .enable(end_screen_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[4]),
        .button_pressed(menu_butt_pressed),
        .vga_out(vga_bus[5])
    );
        
    //***Cards Display & Cards Press Checker***//
    
    cardsCtl display_clickable_cards(
        .clk(clk),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .yx_card_position(yx_card_position),
        .regfile_in(regfile_r_data),
        .regfile_sync(update_cards_en_delayed_2tact),
        .vga_in(vga_bus[5]),
        .vga_out(vga_bus[6]),
        .card_press_checker_en(wait_for_click_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .card_test_state(regfile_r_data[`CARD_STATE_SIZE-1:0]),
        .card_to_test_address(card_to_test_address),
        .card_clicked_address(card_clicked_address),
        .event_occurred(card_pressed)
    );
    
    //***EndScreen Display***//
    
    endgame_screen display_endscreen(
        .pclk(clk),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .game_over_en(minute_passed),
        .enable(end_screen_en),
        .discovered_pairs_ctr(discovered_pairs_ctr),
        .game_time(game_time),
        .vga_in(vga_bus[6]),
        .vga_out(vga_bus[7])
    );
    
    //***Mouse Display***//
    
    MouseDisplay display_mouse(
        .pixel_clk(clk),
        .xpos(xpos),
        .ypos(ypos),
        .vs_in(vga_last[`VGA_VS_BITS]),
        .hs_in(vga_last[`VGA_HS_BITS]),
        .blank(vga_last[`VGA_VBLNK_BITS]||vga_last[`VGA_HBLNK_BITS]),
        .vcount(vga_last[`VGA_VCOUNT_BITS]),
        .hcount(vga_last[`VGA_HCOUNT_BITS]),
        .red_in(vga_last[`VGA_R_BITS]),
        .green_in(vga_last[`VGA_G_BITS]),
        .blue_in(vga_last[`VGA_B_BITS]),
        .red_out(vga_out[11:8]),
        .green_out(vga_out[7:4]),
        .blue_out(vga_out[3:0]),
        .vs_out(vga_out[13]),
        .hs_out(vga_out[12]),
        .enable_mouse_display_out(enable_mouse_display_out)
    );
endmodule
