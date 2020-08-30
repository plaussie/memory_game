`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 29.08.2020 20:18:53
// Module Name: buttonCtl
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

module buttonCtl
    #( parameter
        X_POS   = 50,
        Y_POS   = 50,
        WIDTH   = 400,
        HEIGHT  = 200,
        ROM_ADDRESS_SIZE = 16,
        ROM_PIXELS_NUM = 20,
        ROM_PATH = ""        
    )
    (
    input wire          clk,
    input wire          rst,    
    input wire          enable,
    input wire          mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    
    output wire         button_pressed,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    //***Button Press Checker***//       

    button_press_checker
    #(
        .X_POS(X_POS),
        .Y_POS(Y_POS),
        .WIDTH(WIDTH),
        .HEIGHT(HEIGHT)    
    )
    butt_press_checker (
        .clk(clk),
        .enable(enable),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .button_pressed(button_pressed),
        .rst(rst)
    );
    
    //***Button Display***//
    wire [15:0] pixel_address;
    wire [11:0] rgb_start_button;
    
    draw_image_rom 
    #(
        .X_POS(X_POS),
        .Y_POS(Y_POS),
        .WIDTH(WIDTH),
        .HEIGHT(HEIGHT)
    )
    display_button(
        .pclk(clk),
        .rst(rst),
        .enable(enable),
        .rgb_pixel(rgb_start_button),
        .vga_in(vga_in),
        .pixel_address(pixel_address),
        .vga_out(vga_out)
    );
    
    button_image_rom
    #(
        .ROM_ADDRESS_SIZE(ROM_ADDRESS_SIZE),
        .ROM_PIXELS_NUM(ROM_PIXELS_NUM),
        .ROM_PATH(ROM_PATH)
    )    
    image_rom(
        .clk(clk),
        .address(pixel_address),
        .rgb(rgb_start_button)
    );
endmodule
