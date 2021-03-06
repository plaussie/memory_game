`timescale 1 ns / 1 ps
//////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:51:42
// Module Name: vga_timing
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
// Revision 0.20 - Changing resolution to 1024x768@60fps
// Revision 0.30 - Added VGA bus
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_vga_macros.vh"
`include "_game_params.vh"

module vga_timing (
    input wire pclk,
    input wire rst,    
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    `VGA_OUT_WIRE
    `VGA_MERGE_OUTPUT(vga_out)

    reg [10:0] vcount_reg, vcount_reg_nxt, hcount_reg, hcount_reg_nxt;
    
    always @(posedge pclk) begin
        if(rst) begin
            hcount_reg <= 0;
            vcount_reg <= 0;
        end
        else begin
            hcount_reg <= hcount_reg_nxt;
            vcount_reg <= vcount_reg_nxt;
        end
    end
    
    always @* begin
        if(hcount_reg < 1344) begin
                hcount_reg_nxt = hcount_reg + 1;
                vcount_reg_nxt = vcount_reg;
        end
        else begin
            hcount_reg_nxt = 0;
            if(vcount_reg < 806) begin
                vcount_reg_nxt = vcount_reg + 1;
            end
            else begin
                vcount_reg_nxt = 0;
            end
        end
    end
    
    assign vcount_out = vcount_reg;
    assign hcount_out = hcount_reg;
    assign vs_out = ((vcount_reg >= 771) && (vcount_reg <= 776));
    assign hs_out = ((hcount_reg >= 1048) && (hcount_reg <= 1183));
    assign vblnk_out = (vcount_reg >= 768);
    assign hblnk_out = (hcount_reg >= 1024);
    assign rgb_out = `BACKGROUND_COLOR;
    
endmodule
