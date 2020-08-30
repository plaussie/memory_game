`timescale 1 ns / 1 ps
/////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 07.07.2020 12:00:41
// Module Name: top
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
// Revision 0.30 - Added VGA bus
// Revision 0.31 - Fixed Timing Critical Error
// Revision 0.32 - Deleted mouse delay
// Revision 0.33 - Added genvar in drawing cards
// Revision 0.40 - Added regfile with its control unit
// Revision 0.50 - 2 cards can be discovered, then game stops
// Revision 0.80 - Playable version
// Revision 0.81 - Added endscreen
// Revision 0.82 - Added stopwatch
// Revision 0.83 - Added options screen
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_cards_macros.vh"
`include "_game_params.vh"
`include "_vga_macros.vh"

module top (
    inout wire ps2_clk,
    inout wire ps2_data,
    input wire clk,
    input wire rst,
    output wire vs,
    output wire hs,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b
    );
    
    //params
    localparam
        NUM_MODULES = 7;

    //***Clock Generator***//
    
    wire clk100MHz;
    wire clk65MHz;
    wire locked;

    clock_generator MG_clock (
        // Clock out ports
        .clk100MHz(clk100MHz),
        .clk65MHz(clk65MHz),
        // Status and control signals
        .reset(rst),
        .locked(locked),
        // Clock in ports
        .clk(clk)
    );
    
    //***Mouse Controller with PS2 Interface***//
    
    wire [11:0] xpos;
    wire [11:0] ypos;
    wire left;
    //unused
    wire [3:0] zpos;
    wire middle;
    wire right;
    wire new_event;
    
    MouseCtl MG_MouseCtl(
        .clk(clk65MHz),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .xpos(xpos),
        .ypos(ypos),
        .zpos(zpos),
        .left(left),
        .middle(middle),
        .right(right),
        .new_event(new_event),
        .rst(rst),
        .value(12'b0),
        .setx(1'b0),
        .sety(1'b0),
        .setmax_x(1'b0),
        .setmax_y(1'b0)
    );
    
    //***The Main State Machine***//
    wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards;
    wire [`CARD_DATA_SIZE-1:0] regfile_w_data, regfile_r_data;
    
    wire start_butt_pressed, options_butt_pressed, back_butt_pressed, card_pressed;
    wire compute_done;
    wire start_butt_en, options_butt_en, difficulty_butts_en, back_butt_en, compute_colors_en, stopwatch_en, update_cards_en,
         wait_for_click_en, write_card_en, stopwatch_disable, end_screen_en;
    wire [`CARD_ADDRESS_SIZE-1:0] card_clicked_address, write_card_address;
    wire [`CARD_STATE_SIZE-1:0] write_card_state;

    state_machine MG_state_machine(
        .clk(clk65MHz),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .start_butt_pressed(start_butt_pressed),
        .options_butt_pressed(options_butt_pressed),
        .back_butt_pressed(back_butt_pressed),
        .compute_done(compute_done),
        .card_pressed(card_pressed),
        .card_clicked_address(card_clicked_address),
        .card_clicked_color(regfile_r_data[`CARD_DATA_SIZE-1:`CARD_STATE_SIZE]),
        .start_butt_en(start_butt_en),
        .options_butt_en(options_butt_en),
        .difficulty_butts_en(difficulty_butts_en),
        .back_butt_en(back_butt_en),
        .update_cards_en(update_cards_en),
        .compute_colors_en(compute_colors_en),
        .stopwatch_en(stopwatch_en),
        .stopwatch_disable(stopwatch_disable),
        .wait_for_click_en(wait_for_click_en),
        .write_card_en(write_card_en),
        .end_screen_en(end_screen_en),
        .write_card_state(write_card_state),
        .write_card_address(write_card_address)
    );
    
    //***Stopwatch***//
    
    wire [5:0] minutes, seconds;
    
    stopwatch MG_stopwatch(
        .clk(clk65MHz),
        .rst(rst),
        .start(stopwatch_en),
        .pause(1'b0),
        .stop(stopwatch_disable),
        .minutes(minutes),
        .seconds(seconds)
        
    );
    
    //***Cards Colors Generator***//
    
    wire [`CARD_DATA_SIZE-1:0] card_write_data;
    wire [`CARD_ADDRESS_SIZE-1:0] card_write_address;

    compute_colors MG_compute_colors(
        .clk(clk65MHz),
        .rst(rst),
        .enable(compute_colors_en),
        .num_of_cards(num_of_cards),
        .done(compute_done),
        .computed_data(card_write_data),
        .computed_address(card_write_address)
    );
    
    //***update_cards_en Delayer***//
    
    wire update_cards_en_delayed_tact;
    
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delay_update_cards_en_1(
        .clk(clk65MHz),
        .rst(rst),
        .din(update_cards_en),
        .dout(update_cards_en_delayed_tact)
    );
    
    wire update_cards_en_delayed_2tact;
        
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(2)
    )
    delay_update_cards_en_2(
        .clk(clk65MHz),
        .rst(rst),
        .din(update_cards_en),
        .dout(update_cards_en_delayed_2tact)
    );

    //***Cards Positions Generator***//
    
    wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position;
    
    cards_pos_gen MG_cards_positions(
        .clk(clk65MHz),
        .rst(rst),
        .read_all_positions(update_cards_en),
        .num_of_cards(num_of_cards),
        .yx_card_position(yx_card_position)
    );
    
    //***RegFile Controller***//
    
    wire [1:0] regfile_w_enable;
    
    wire [`CARD_ADDRESS_SIZE-1:0] regfile_w_address, regfile_r_address, card_to_test_address;
    
    regfileCtl MG_colors_regfileCtl(
        .clk(clk65MHz),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .read_all_cards(update_cards_en_delayed_tact),
        .read_one_card(card_to_test_address),
        .write_data_1({card_write_data, card_write_address, compute_colors_en}),
        .write_data_2({write_card_state, write_card_address, write_card_en}),
        .regfile_w_enable(regfile_w_enable),
        .regfile_w_address(regfile_w_address),
        .regfile_w_data(regfile_w_data),
        .regfile_r_address(regfile_r_address)
    );    
    
    //***RegFile***//
    
    regfile MG_colors_regfile(
        .clk(clk65MHz),
        .w_enable(regfile_w_enable),
        .w_data(regfile_w_data),
        .w_address(regfile_w_address),
        .r_data(regfile_r_data),
        .r_address(regfile_r_address)
    );

    //***VGA Timings Generator***//
    
    //VGA bus
    wire [`VGA_BUS_SIZE-1:0] vga_bus [NUM_MODULES:0];

    vga_timing MG_vga_timing (
        .pclk(clk65MHz),
        .rst(rst),
        .vga_out(vga_bus[0])
    );

    //***Background Display***//

    draw_background display_background(
        .pclk(clk65MHz),
        .rst(rst),
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
        .ROM_ADDRESS_SIZE(`START_BUTTON_ADDRESS_SIZE),
        .ROM_PIXELS_NUM(`START_BUTTON_ROM_PIXELS_NUM),
        .ROM_PATH(`START_BUTTON_ROM_PATH)   
    )
    display_clickable_start (
        .clk(clk65MHz),
        .rst(rst),
        .enable(start_butt_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[1]),
        .button_pressed(start_butt_pressed),
        .vga_out(vga_bus[2])
    );
    
    //***Options Button Display & Press Checker***//       
    
    buttonCtl
    #(
        .X_POS(`OPTIONS_BUTTON_X_POS),
        .Y_POS(`OPTIONS_BUTTON_Y_POS),
        .WIDTH(`OPTIONS_BUTTON_WIDTH),
        .HEIGHT(`OPTIONS_BUTTON_HEIGHT),
        .ROM_ADDRESS_SIZE(`OPTIONS_BUTTON_ADDRESS_SIZE),
        .ROM_PIXELS_NUM(`OPTIONS_BUTTON_ROM_PIXELS_NUM),
        .ROM_PATH(`OPTIONS_BUTTON_ROM_PATH)   
    )
    display_clickable_options (
        .clk(clk65MHz),
        .rst(rst),
        .enable(options_butt_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[2]),
        .button_pressed(options_butt_pressed),
        .vga_out(vga_bus[3])
    );
    
    //***OptionsScreen Display***//
    
    options_screen display_optionsscreen(
        .clk(clk65MHz),                                  
        .rst(rst),                                  
        .difficulty_butts_en(difficulty_butts_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[3]),
        .vga_out(vga_bus[4]),
        .num_of_cards(num_of_cards)
    );
    
    //***Back Button Display & Press Checker***// 
        
    buttonCtl
    #(
        .X_POS(`BACK_BUTTON_X_POS),
        .Y_POS(`BACK_BUTTON_Y_POS),
        .WIDTH(`BACK_BUTTON_WIDTH),
        .HEIGHT(`BACK_BUTTON_HEIGHT),
        .ROM_ADDRESS_SIZE(`BACK_BUTTON_ADDRESS_SIZE),
        .ROM_PIXELS_NUM(`BACK_BUTTON_ROM_PIXELS_NUM),
        .ROM_PATH(`BACK_BUTTON_ROM_PATH)
    )
    display_clickable_back (
        .clk(clk65MHz),
        .rst(rst),
        .enable(back_butt_en),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(vga_bus[4]),
        .button_pressed(back_butt_pressed),
        .vga_out(vga_bus[5])
    );
        
    //***Cards Display & Cards Press Checker***//
    
    cardsCtl display_clickable_cards(
        .clk(clk65MHz),
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
        .pclk(clk65MHz),
        .rst(rst),
        .enable(end_screen_en),
        .game_time({minutes, seconds}),
        .vga_in(vga_bus[6]),
        .vga_out(vga_bus[7])
    );
    
    //***Mouse Display***//
    
    wire [`VGA_BUS_SIZE-1:0] vga_last;
    assign vga_last = vga_bus[NUM_MODULES];
    
    //unused
    wire enable_mouse_display_out;
    
    MouseDisplay display_mouse(
        .pixel_clk(clk65MHz),
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
        .red_out(r),
        .green_out(g),
        .blue_out(b),
        .vs_out(vs),
        .hs_out(hs),
        .enable_mouse_display_out(enable_mouse_display_out)
    );

endmodule
