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
// It is a module created only for testing. Do not use this.
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module top_testing (
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
    NUM_MODULES = 3,
    START_BUTTON_X = 312,
    START_BUTTON_Y = 284,
    START_BUTTON_WIDTH = 400,
    START_BUTTON_HEIGHT = 200,
    START_BUTTON_COLOR = 12'h0_A_A;
    
    //VGA bus
    wire [`VGA_BUS_SIZE-1:0] vga_bus [NUM_MODULES:0];

    //CLOCK GENERATING
    
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

    
    //MOUSE Controller
    
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
    
    //VGA TIMINGS GENERATING

    vga_timing MG_vga_timing (
        .pclk(clk65MHz),
        .rst(rst),
        .vga_out(vga_bus[0])
    );

    //DISPLAY BACKGROUND

    draw_background display_background(
        .pclk(clk65MHz),
        .rst(rst),
        .vga_in(vga_bus[0]),
        .vga_out(vga_bus[1])
    );
    
    //State machine for all game
    wire start_butt_pressed, card_pressed;
    wire compute_done;
    wire start_butt_en, compute_colors_en, update_cards_en;

    state_machine MG_state_machine(
        .clk(clk65MHz),
        .rst(rst),
        .start_butt_pressed(start_butt_pressed),
        .compute_done(compute_done),
        .card_pressed(card_pressed),
        .start_butt_en(start_butt_en),
        .update_cards_en(update_cards_en),
        .compute_colors_en(compute_colors_en)
    );
    
    wire [13:0] card_write_data;
    wire [3:0] card_write_address;
    //wire compute_colors_en_delayed;
    compute_colors MG_compute_colors(
        .clk(clk65MHz),
        .rst(rst),
        .enable(compute_colors_en),
        .done(compute_done),
        .computed_data(card_write_data),
        .computed_address(card_write_address)
    );
    
    //Delay update_cards_en
    
    /*
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delayed_compute_colors_en(
        .clk(clk65MHz),
        .rst(rst),
        .din(compute_colors_en),
        .dout(compute_colors_en_delayed)
    );*/
    
    //modu³ zamiana obszaru na adres -- do zrobienia
    
    // regfileCtl 
    wire regfile_w_enable;
    wire [13:0] regfile_w_data, regfile_r_data;
    wire [3:0] regfile_w_address, regfile_r_address;
    
    regfileCtl MG_regfileCtl(
        .clk(clk65MHz),
        .rst(rst),
        .update_cards_en(update_cards_en),
        .write_data_1({card_write_data, card_write_address, compute_colors_en}),
        .regfile_w_enable(regfile_w_enable),
        .regfile_w_address(regfile_w_address),
        .regfile_w_data(regfile_w_data),
        .regfile_r_address(regfile_r_address)
    );
    
    
    // regfile
    
    regfile MG_regfile(
        .clk(clk65MHz),
        .w_enable(compute_colors_en),
        .w_data(card_write_data),
        .w_address(card_write_address),
        .r_data(regfile_r_data),
        .r_address(4'h1)
    );
    
    
    //Checking if start button is pressed
       

    event_checker check_if_left_clicked_start_butt (
        .clk(clk65MHz),
        .start(start_butt_en),
        .x_begin(START_BUTTON_X),
        .x_end(START_BUTTON_X+START_BUTTON_WIDTH),
        .y_begin(START_BUTTON_Y),
        .y_end(START_BUTTON_Y+START_BUTTON_HEIGHT),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .event_occured(start_butt_pressed),
        .rst(rst)
    );
    
    //DRAWING START BUTTON
    
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
        .vga_in(vga_bus[1]),
        .vga_out(vga_bus[2])
    );
    
    //Delay update_cards_en
    /*wire update_cards_en_delayed;
    
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delayed_update_cards_en(
        .clk(clk65MHz),
        .rst(rst),
        .din(update_cards_en),
        .dout(update_cards_en_delayed)
    );*/
    
    //Draw Cards
    
    draw_one_card #(
        .X_POS(250),
        .Y_POS(250),
        .WIDTH(300),
        .HEIGHT(400),
        .COLOR(12'h0_F_0)
    )
    u_card(
        .pclk(clk65MHz),
        .rst(rst),
        .regfile_in(regfile_r_data),
        .regfile_sync(update_cards_en),
        .regfile_sync_done(),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3])
    );
    /*
    draw_cards display_cards(
        .pclk(clk65MHz),
        .rst(rst),
        .regfile_in(regfile_r_data),
        .regfile_sync(update_cards_en),
        .regfile_sync_done(),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3])
    );
    */
    //MOUSE CURSOR DISPLAYING
    wire [`VGA_BUS_SIZE-1:0] vga_last;
    assign vga_last = vga_bus[NUM_MODULES];
    
    //unused
    wire enable_mouse_display_out;
    
    MouseDisplay MG_MouseDisplay(
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
