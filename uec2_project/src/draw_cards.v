`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 23.07.2020 21:17:47
// Module Name: draw_cards
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.30 - Added VGA bus
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_vga_macros.vh"

module draw_cards(
    input wire pclk,
    input wire rst,
    input wire regfile_sync,
    input wire [13:0] regfile_in,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire regfile_sync_done,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    localparam
    NUM_CARDS_X = 4,
    NUM_CARDS_Y = 3,
    NUM_CARDS = NUM_CARDS_X*NUM_CARDS_Y;
    
    wire [`VGA_BUS_SIZE-1:0] vga_internal_bus [NUM_CARDS:0];
    assign vga_internal_bus[0] = vga_in;
    assign vga_out = vga_internal_bus[NUM_CARDS];
    
    wire regfile_sync_bus [NUM_CARDS:0];
    assign regfile_sync_bus[0] = regfile_sync;
    assign regfile_sync_done = regfile_sync_bus[NUM_CARDS];
    /*
    genvar i;
        generate
        for(i = 0; i < NUM_CARDS; i = i+1) begin
            draw_one_card #(
                .X_POS(60*i + 50),
                .Y_POS(50),
                .WIDTH(50),
                .HEIGHT(200),
                .COLOR(12'h0_F_0)
            )
            u_card(
                .pclk(pclk),
                .rst(rst),
                .regfile_in(regfile_in),
                .regfile_sync(regfile_sync_bus[i]),
                .regfile_sync_done(regfile_sync_bus[i+1]),
                .vga_in(vga_internal_bus[i]),
                .vga_out(vga_internal_bus[i+1])
            );
        end
        endgenerate
    */
    genvar i;
    generate
    for(i = 0; i < NUM_CARDS_X; i = i+1) begin
        draw_one_card #(
            .X_POS(258*i + 50),
            .Y_POS(50),
            .WIDTH(150),
            .HEIGHT(200),
            .COLOR(12'h0_F_0)
        )
        u_card(
            .pclk(pclk),
            .rst(rst),
            .regfile_in(regfile_in),
            .regfile_sync(regfile_sync_bus[i]),
            .regfile_sync_done(regfile_sync_bus[i+1]),
            .vga_in(vga_internal_bus[i]),
            .vga_out(vga_internal_bus[i+1])
        );
    end
    endgenerate
    
    genvar y;
    generate
    for(y = NUM_CARDS_X; y < 2*NUM_CARDS_X; y = y+1) begin
        draw_one_card #(
            .X_POS(258*(y-NUM_CARDS_X) + 50),
            .Y_POS(234 + 50),
            .WIDTH(150),
            .HEIGHT(200),
            .COLOR(12'h0_F_0)
        )
        u_card(
            .pclk(pclk),
            .rst(rst),
            .regfile_in(regfile_in),
            .regfile_sync(regfile_sync_bus[y]),
            .regfile_sync_done(regfile_sync_bus[y+1]),
            .vga_in(vga_internal_bus[y]),
            .vga_out(vga_internal_bus[y+1])
        );
    end
    endgenerate
    
    genvar z;
    generate
    for(z = 2*NUM_CARDS_X; z < 3*NUM_CARDS_X; z = z+1) begin
        draw_one_card #(
            .X_POS(258*(z-2*NUM_CARDS_X) + 50),
            .Y_POS(468 + 50),
            .WIDTH(150),
            .HEIGHT(200),
            .COLOR(12'h0_F_0)
        )
        u_card(
            .pclk(pclk),
            .rst(rst),
            .regfile_in(regfile_in),
            .regfile_sync(regfile_sync_bus[z]),
            .regfile_sync_done(regfile_sync_bus[z+1]),
            .vga_in(vga_internal_bus[z]),
            .vga_out(vga_internal_bus[z+1])
        );
    end
    endgenerate
endmodule
