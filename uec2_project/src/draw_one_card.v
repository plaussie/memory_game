`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 24.07.2020 12:55:00
// Module Name: draw_one_card
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
// Revision 0.40 - Added regfile with its control unit
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_vga_macros.vh"

// [1:0] to bity mówi¹ce o stanie karty, x0 - karta nieaktywna, 11 - karta przodem, 01 - karta ty³em;
// [13:2] to bity mówi¹ce o kolorze karty, kolejnoœæ MSB:r,g,b:LSB

module draw_one_card(
    input wire pclk,
    input wire rst,
    input wire regfile_sync,
    input wire [19:0] yx_position_in,
    input wire [8:0] height,
    input wire [7:0] width,
    input wire [13:0] regfile_in,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output reg regfile_sync_done,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    localparam COVERED_CARD_COLOR = 12'h0_A_A;
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)
    
    reg [13:0] card_reg, card_reg_nxt;
    reg [19:0] yx_position_reg, yx_position_reg_nxt;
    reg [11:0] rgb_nxt;
    wire regfile_sync_done_nxt;
       
    always @(posedge pclk)
        begin
            if(rst) begin
                hs_out <= 0;
                vs_out <= 0;
                hblnk_out <= 0;
                vblnk_out <= 0;
                hcount_out <= 0;
                vcount_out <= 0;
                rgb_out <= 0;
                regfile_sync_done <= 0;
                card_reg <= 0;
                yx_position_reg <= 0;
            end
            else begin
                // Just pass these through.
                hs_out <= hs_in;
                vs_out <= vs_in;
                hblnk_out <= hblnk_in;
                vblnk_out <= vblnk_in;
                hcount_out <= hcount_in;
                vcount_out <= vcount_in;
                // regfile_sync signal
                regfile_sync_done <= regfile_sync_done_nxt;
                // Changing color in rectangle place
                rgb_out <= rgb_nxt;
                // card_reg signal
                card_reg <= card_reg_nxt;
                yx_position_reg <= yx_position_reg_nxt;
            end
        end
    
    always @*
        begin
            if (card_reg[0] && ((hcount_in >= yx_position_reg[9:0]) && (hcount_in < yx_position_reg[9:0]+width) && (vcount_in >= yx_position_reg[19:10]) && (vcount_in < yx_position_reg[19:10]+height))) begin
                if (card_reg[1])begin
                    rgb_nxt = card_reg[13:2];
                end
                else begin
                    rgb_nxt = COVERED_CARD_COLOR;
                end
            end
            else begin
                rgb_nxt = rgb_in;
            end
        end
        
    always @*
        begin
            if(regfile_sync) begin
                yx_position_reg_nxt = yx_position_in;
                card_reg_nxt = regfile_in;
            end
            else begin
                yx_position_reg_nxt = yx_position_reg;
                card_reg_nxt = card_reg;
            end
        end
        
    assign regfile_sync_done_nxt = regfile_sync;
    
endmodule
