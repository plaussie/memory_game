//////////////////////////////////////////////////////////////////////////////////
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

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
    NUM_MODULES = 4,
    START_BUTTON_X = 412,
    START_BUTTON_Y = 328,
    START_BUTTON_WIDTH = 200,
    START_BUTTON_HEIGHT = 112,
    START_BUTTON_COLOR = 12'h0_A_A;

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
    wire [13:0] regfile_w_data, regfile_r_data;
    
    wire start_butt_pressed, card_pressed;
    wire compute_done;
    wire start_butt_en, compute_colors_en, stopwatch_en, update_cards_en, wait_for_click_en, write_card_en, stopwatch_disable, end_screen_en;
    wire [3:0] card_clicked_address, write_card_address;
    wire [1:0] write_card_state;

    state_machine MG_state_machine(
        .clk(clk65MHz),
        .rst(rst),
        .start_butt_pressed(start_butt_pressed),
        .compute_done(compute_done),
        .card_pressed(card_pressed),
        .card_clicked_address(card_clicked_address),
        .card_clicked_color(regfile_r_data[13:2]),
        .start_butt_en(start_butt_en),
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
    
    wire [13:0] card_write_data;
    wire [3:0] card_write_address;

    compute_colors MG_compute_colors(
        .clk(clk65MHz),
        .rst(rst),
        .enable(compute_colors_en),
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

    //***Cards Positions***//
    
    wire [19:0] yx_card_position;
    
    rom MG_cards_positions(
        .clk(clk65MHz),
        .rst(rst),
        .read_all_positions(update_cards_en),
        .num_of_cards(5'd12),
        .yx_card_position(yx_card_position)
    );
    
    //***RegFile Controller***//
    
    wire [1:0] regfile_w_enable;
    
    wire [3:0] regfile_w_address, regfile_r_address, card_to_test_address;
    
    regfileCtl MG_colors_regfileCtl(
        .clk(clk65MHz),
        .rst(rst),
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
    
    //***Card Press Checker with returned card index***// na ten moment, bez zwracania, kt�ra karta

    card_press_checker MG_card_press_checker (
        .clk(clk65MHz),
        .rst(rst),
        .enable(wait_for_click_en),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .card_test_state(regfile_r_data[1:0]),
        .card_to_test_address(card_to_test_address),
        .card_clicked_address(card_clicked_address),
        .event_occurred(card_pressed)
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
    
    //***Start Button Press Checker***//       

    event_checker
    #(
        .X_POS(START_BUTTON_X),
        .Y_POS(START_BUTTON_Y),
        .WIDTH(START_BUTTON_WIDTH),
        .HEIGHT(START_BUTTON_HEIGHT)    
    )
    MG_check_if_left_clicked_start_butt (
        .clk(clk65MHz),
        .enable(start_butt_en),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .event_occurred(start_butt_pressed),
        .rst(rst)
    );
    
    //***Start Button Display***//
    wire [15:0] pixel_address;
    wire [11:0] rgb_start_button;
    
    draw_rect 
    #(
        .X_POS(START_BUTTON_X),
        .Y_POS(START_BUTTON_Y),
        .WIDTH(START_BUTTON_WIDTH),
        .HEIGHT(START_BUTTON_HEIGHT),
        .COLOR(12'h0_A_A)
    )
    display_start_button(
        .pclk(clk65MHz),
        .rst(rst),
        .enable(start_butt_en),
        .rgb_pixel(rgb_start_button),
        .vga_in(vga_bus[1]),
        .pixel_address(pixel_address),
        .vga_out(vga_bus[2])
    );
    start_image_rom start_image(
        .clk(clk65MHz),
        .address(pixel_address),
        .rgb(rgb_start_button)
    );
    
    //***Cards Display***//
    
    draw_cards display_cards(
        .pclk(clk65MHz),
        .rst(rst),
        .num_of_cards(5'd12),
        .yx_card_position(yx_card_position),
        .regfile_in(regfile_r_data),
        .regfile_sync(update_cards_en_delayed_2tact),
        .regfile_sync_done(),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3])
    );
    
    //***EndScreen Display***//
    
    endgame_screen display_endscreen(
        .pclk(clk65MHz),
        .rst(rst),
        .enable(end_screen_en),
        .game_time({minutes, seconds}),
        .vga_in(vga_bus[3]),
        .vga_out(vga_bus[4])
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
        .vs_in(vga_last[37]),
        .hs_in(vga_last[36]),
        .blank(vga_last[34]||vga_last[35]),
        .vcount(vga_last[33:23]),
        .hcount(vga_last[22:12]),
        .red_in(vga_last[11:8]),
        .green_in(vga_last[7:4]),
        .blue_in(vga_last[3:0]),
        .red_out(r),
        .green_out(g),
        .blue_out(b),
        .vs_out(vs),
        .hs_out(hs),
        .enable_mouse_display_out(enable_mouse_display_out)
    );

endmodule
