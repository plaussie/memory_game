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
// Revision 0.31 - Fixing Timing Critical Error
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

    clock_generator my_clock (
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
    
    wire [11:0] xpos_mousectl_out;
    wire [11:0] ypos_mousectl_out;
    wire left;
    //unused
    wire [3:0] zpos;
    wire middle;
    wire right;
    wire new_event;
    
    MouseCtl my_MouseCtl(
        .clk(clk65MHz),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .xpos(xpos_mousectl_out),
        .ypos(ypos_mousectl_out),
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
    
    //DELAYS ALIGNMENT
    
    wire [11:0] xpos;
    wire [11:0] ypos;
    
    delay
    #(
        .WIDTH(24),
        .CLK_DEL(1)
    )    
    mouse_pos_delay (
        .clk(clk65MHz),
        .rst(rst),
        .din({xpos_mousectl_out, ypos_mousectl_out}),
        .dout({xpos, ypos})
    );
    
    //TIMINGS GENERATING

    vga_timing my_timing (
        .pclk(clk65MHz),
        .rst(rst),
        .vga_out(vga_bus[0])
    );

    //BACKGROUND DRAWING

    draw_background display_background(
        .pclk(clk65MHz),
        .rst(rst),
        .vga_in(vga_bus[0]),
        .vga_out(vga_bus[1])
    );
    
    //State machine for all game
    wire draw_start_button;
    wire start_button_pressed;
    wire draw_cards;
    
    state_machine my_state_machine(
        .clk(clk65MHz),
        .start_button_pressed(start_button_pressed),
        .draw_start_button(draw_start_button),
        .draw_cards(draw_cards),
        .rst(rst)
    );
    
    
    //Checking if start button is pressed
       

    event_checker check_if_left_clicked_start_button (
        .clk(clk65MHz),
        .start(draw_start_button),
        .x_begin(START_BUTTON_X),
        .x_end(START_BUTTON_X+START_BUTTON_WIDTH),
        .y_begin(START_BUTTON_Y),
        .y_end(START_BUTTON_Y+START_BUTTON_HEIGHT),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .event_occured(start_button_pressed),
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
        .do(draw_start_button),
        .vga_in(vga_bus[1]),
        .vga_out(vga_bus[2])
    );
    
    //Draw Cards
    
    draw_cards display_cards(
        .pclk(clk65MHz),
        .rst(rst),
        .do(draw_cards),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3])
    );
    
    //MOUSE CURSOR DISPLAYING
    wire [`VGA_BUS_SIZE-1:0] vga_last;
    assign vga_last = vga_bus[NUM_MODULES];
    
    //unused
    wire enable_mouse_display_out;
    
    MouseDisplay my_MouseDisplay(
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
