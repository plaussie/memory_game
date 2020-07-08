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
    output reg [3:0] b,
    output wire pclk_mirror
    );

    //CLOCK GENERATOR
    
    wire clk100MHz;
    wire clk40MHz;
    wire locked;

    clock_generator my_clock (
    // Clock out ports
    .clk100MHz(clk100MHz),
    .clk40MHz(clk40MHz),
    // Status and control signals
    .reset(rst),
    .locked(locked),
    // Clock in ports
    .clk(clk)
    );

    // pclk mirror is only for testbench
    
    ODDR pclk_oddr (
        .Q(pclk_mirror),
        .C(clk40MHz),
        .CE(1'b1),
        .D1(1'b1),
        .D2(1'b0),
        .R(1'b0),
        .S(1'b0)
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
    
    //buf_reg_rect
    wire [11:0] xpos;
    wire [11:0] ypos;
    
    delay
    #(
        .WIDTH(24),
        .CLK_DEL(1)
    )    
    mouse_pos_delay (
        .clk(clk40MHz),
        .rst(rst),
        .din({xpos_mousectl_out, ypos_mousectl_out}),
        .dout({xpos, ypos})
    );
    
    //vga_timing module
    
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
        .pclk(clk40MHz),
        .rst(rst)
    );

    //drawing background
    
    wire [11:0] rgb_rect_char_in;
    wire vsync_rect_char_in, hsync_rect_char_in;
    wire vblnk_rect_char_in, hblnk_rect_char_in;
    wire [10:0] vcount_rect_char_in, hcount_rect_char_in;

    draw_background my_background(
        .pclk(clk40MHz),
        .vcount_in(vcount_background_in),
        .vsync_in(vsync_background_in),
        .vblnk_in(vblnk_background_in),
        .hcount_in(hcount_background_in),
        .hsync_in(hsync_background_in),
        .hblnk_in(hblnk_background_in),
        .vcount_out(vcount_rect_char_in),
        .vsync_out(vsync_rect_char_in),
        .vblnk_out(vblnk_rect_char_in),
        .hcount_out(hcount_rect_char_in),
        .hsync_out(hsync_rect_char_in),
        .hblnk_out(hblnk_rect_char_in),
        .rgb_out(rgb_rect_char_in),
        .rst(rst)
    );
    
    // drawing characters
    
    wire [7:0] char_pixels;
    wire [3:0] char_line;
    wire [6:0] char_code;
    
    font_rom my_font_rom(
        .clk(clk40MHz),
        .addr({char_code, char_line}),
        .char_line_pixels(char_pixels)
    );
    
    wire [7:0] char_yx;    
    
    char_rom_16x16 my_chars(
        .clk(clk40MHz),
        .char_yx(char_yx),
        .char_code(char_code)
    );
    
    // rect_char
    
    wire [11:0] rgb_rect_in;
    wire vsync_rect_in, hsync_rect_in;
    wire vblnk_rect_in, hblnk_rect_in;
    wire [10:0] vcount_rect_in, hcount_rect_in;

    
    draw_rect_char my_rect_char(
            .vcount_in(vcount_rect_char_in),
            .hcount_in(hcount_rect_char_in),
            .vsync_in(vsync_rect_char_in),
            .vblnk_in(vblnk_rect_char_in),
            .hsync_in(hsync_rect_char_in),
            .hblnk_in(hblnk_rect_char_in),
            .rgb_in(rgb_rect_char_in),
            .vcount_out(vcount_rect_in),
            .vsync_out(vsync_rect_in),
            .vblnk_out(vblnk_rect_in),
            .hcount_out(hcount_rect_in),
            .hsync_out(hsync_rect_in),
            .hblnk_out(hblnk_rect_in),
            .rgb_out(rgb_rect_in),
            .pclk(clk40MHz),
            .rst(rst),
            .char_pixels(char_pixels),
            .char_yx(char_yx),
            .char_line(char_line)
        );

    // drawing image from ROM
    
    wire [11:0] address;
    wire [11:0] rgb_rom;
    
    image_rom my_image_rom(
        .clk(clk40MHz),
        .address(address),
        .rgb(rgb_rom)
    );
    
    // rectangle position controller
    wire [11:0] xpos_rect_in, ypos_rect_in;
    
    draw_rect_ctl my_draw_rect_ctl (
        .clk(clk40MHz),
        .rst(rst),
        .mouse_left(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .xpos(xpos_rect_in),
        .ypos(ypos_rect_in)
    );

    // drawing rectangle

    wire vsync_mousedispl_in, hsync_mousedispl_in;
    wire [11:0] rgb_mousedispl_in;
    wire vblnk_mousedispl_in, hblnk_mousedispl_in;
    wire [10:0] vcount_mousedispl_in, hcount_mousedispl_in;
  
    draw_rect my_rect(
        .xpos(xpos_rect_in),
        .ypos(ypos_rect_in),
        .vcount_in(vcount_rect_in),
        .hcount_in(hcount_rect_in),
        .vsync_in(vsync_rect_in),
        .vblnk_in(vblnk_rect_in),
        .hsync_in(hsync_rect_in),
        .hblnk_in(hblnk_rect_in),
        .rgb_in(rgb_rect_in),
        .vcount_out(vcount_mousedispl_in),
        .vsync_out(vsync_mousedispl_in),
        .vblnk_out(vblnk_mousedispl_in),
        .hcount_out(hcount_mousedispl_in),
        .hsync_out(hsync_mousedispl_in),
        .hblnk_out(hblnk_mousedispl_in),
        .rgb_out(rgb_mousedispl_in),
        .pclk(clk40MHz),
        .rst(rst),
        .rgb_pixel(rgb_rom),
        .pixel_addr(address)
    );
    
    //Mouse display cursor
    wire [3:0] r_last, g_last, b_last;
    wire vs_last, hs_last;
    //unused
    wire enable_mouse_display_out;
    
    MouseDisplay my_MouseDisplay(
        .pixel_clk(clk40MHz),
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
  
    always @(posedge clk40MHz)
    begin
        r <= r_last;
        g <= g_last;
        b <= b_last;
        vs <= vs_last;
        hs <= hs_last;
    end

endmodule
