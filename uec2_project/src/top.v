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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps


module top (
    inout wire ps2_clk,
    inout wire ps2_data,
    input wire clk,
    input wire rst,
    output reg vs,
    output reg hs,
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b
    );

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
        .clk(clk100MHz),
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
    
    wire [10:0] vcount_background_in, hcount_background_in;
    wire vsync_background_in, hsync_background_in;
    wire vblnk_background_in, hblnk_background_in;

    vga_timing my_timing (
        .vcount(vcount_background_in),
        .vsync(vsync_background_in),
        .vblnk(vblnk_background_in),
        .hcount(hcount_background_in),
        .hsync(hsync_background_in),
        .hblnk(hblnk_background_in),
        .pclk(clk65MHz),
        .rst(rst)
    );

    //BACKGROUND DRAWING
    
    wire [11:0] rgb_start_button_in;
    wire vsync_start_button_in, hsync_start_button_in;
    wire vblnk_start_button_in, hblnk_start_button_in;
    wire [10:0] vcount_start_button_in, hcount_start_button_in;

    draw_background my_background(
        .pclk(clk65MHz),
        .vcount_in(vcount_background_in),
        .vsync_in(vsync_background_in),
        .vblnk_in(vblnk_background_in),
        .hcount_in(hcount_background_in),
        .hsync_in(hsync_background_in),
        .hblnk_in(hblnk_background_in),
        .vcount_out(vcount_start_button_in),
        .vsync_out(vsync_start_button_in),
        .vblnk_out(vblnk_start_button_in),
        .hcount_out(hcount_start_button_in),
        .hsync_out(hsync_start_button_in),
        .hblnk_out(hblnk_start_button_in),
        .rgb_out(rgb_start_button_in),
        .rst(rst)
    );
    
    //DRAWING START BUTTON
    
    wire [11:0] rgb_mousedispl_in;
    wire vsync_mousedispl_in, hsync_mousedispl_in;
    wire vblnk_mousedispl_in, hblnk_mousedispl_in;
    wire [10:0] vcount_mousedispl_in, hcount_mousedispl_in;
    
    draw_rect my_start_button(
        .pclk(clk65MHz),
        .vcount_in(vcount_start_button_in),
        .vsync_in(vsync_start_button_in),
        .vblnk_in(vblnk_start_button_in),
        .hcount_in(hcount_start_button_in),
        .hsync_in(hsync_start_button_in),
        .hblnk_in(hblnk_start_button_in),
        .rgb_in(rgb_start_button_in),
        .vcount_out(vcount_mousedispl_in),
        .vsync_out(vsync_mousedispl_in),
        .vblnk_out(vblnk_mousedispl_in),
        .hcount_out(hcount_mousedispl_in),
        .hsync_out(hsync_mousedispl_in),
        .hblnk_out(hblnk_mousedispl_in),
        .rgb_out(rgb_mousedispl_in),
        .rst(rst)
    );
    
    //MOUSE CURSOR DISPLAYING
    
    wire [3:0] r_last, g_last, b_last;
    wire vs_last, hs_last;
    //unused
    wire enable_mouse_display_out;
    
    MouseDisplay my_MouseDisplay(
        .pixel_clk(clk65MHz),
        .xpos(xpos),
        .ypos(ypos),
        .hcount(hcount_mousedispl_in),
        .vcount(vcount_mousedispl_in),
        .blank(vblnk_mousedispl_in||hblnk_mousedispl_in),
        .red_in(rgb_mousedispl_in[11:8]),
        .green_in(rgb_mousedispl_in[7:4]),
        .blue_in(rgb_mousedispl_in[3:0]),
        .red_out(r_last),
        .green_out(g_last),
        .blue_out(b_last),
        .vs_in(vsync_mousedispl_in),
        .hs_in(hsync_mousedispl_in),
        .vs_out(vs_last),
        .hs_out(hs_last),
        .enable_mouse_display_out(enable_mouse_display_out)
    );

    always @(posedge clk65MHz) begin
        {r,g,b}  <= {r_last, g_last, b_last};
        {vs, hs} <= {vs_last, hs_last};
    end
endmodule
