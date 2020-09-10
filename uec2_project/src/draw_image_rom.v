`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 28.08.2020 23:25:31
// Design Name: 
// Module Name: draw_image_rom
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

module draw_image_rom
    #( parameter
        X_POS   = 412,
        Y_POS   = 328,
        WIDTH   = 200,
        HEIGHT  = 112,
        ROM_WIDTH_SIZE = 8,
        ROM_HEIGHT_SIZE = 8,
        ROM_PATH   = "",
        TXT_COLOR = 12'h0_0_0,
        BACKGROUND_COLOR = 12'h0_0_0
    )
    (
        input wire pclk,
        input wire rst,
        input wire enable,
        input wire [`VGA_BUS_SIZE-1:0] vga_in,
        output wire [`VGA_BUS_SIZE-1:0] vga_out
    );

    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)
    
    reg [0:2**ROM_WIDTH_SIZE-1] rom [0:2**ROM_HEIGHT_SIZE-1];
        
    initial $readmemb(ROM_PATH, rom); 
    
    reg [11:0] rgb_nxt;
    
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
        end
        else begin
            // Just pass these through.
            hs_out <= hs_in;
            vs_out <= vs_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
            // Changing color in rectangle place
            rgb_out <= rgb_nxt;
        end
    end
    
    always @*
    begin
        if (enable && ((hcount_in >= X_POS) && (hcount_in < X_POS+WIDTH) && (vcount_in >= Y_POS) && (vcount_in < Y_POS+HEIGHT))) begin
            rgb_nxt = (rom[vcount_in-Y_POS][hcount_in-X_POS] == 1) ? TXT_COLOR : BACKGROUND_COLOR;
        end
        else begin
            rgb_nxt = rgb_in;
        end
    end

endmodule
