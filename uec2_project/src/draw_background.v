`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:52:42
// Module Name: draw_background
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
// Revision 0.20 - Resolution changed to 1024x768@60fps
// Revision 0.30 - Added VGA bus
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_vga_macros.vh"

module draw_background(
    input wire pclk,
    input wire rst,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out  
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)
    
    reg [11:0] rgb_nxt;
    
    always @(posedge pclk)
    begin
        if(rst) begin
            vs_out <= 0;
            hs_out <= 0;
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
            //edit color
            rgb_out <= rgb_nxt;            
        end
    end  
    
    always @*
    begin
        if(vblnk_in || hblnk_in)
            rgb_nxt <= 12'h0_0_0; 
        else begin
            // Active display, top edge, make a yellow line.
            if (vcount_in == 0) rgb_nxt <= 12'hf_f_0;
            // Active display, bottom edge, make a red line.
            else if (vcount_in == 767) rgb_nxt <= 12'hf_0_0;
            // Active display, left edge, make a green line.
            else if (hcount_in == 0) rgb_nxt <= 12'h0_f_0;
            // Active display, right edge, make a blue line.
            else if (hcount_in == 1023) rgb_nxt <= 12'h0_0_f;
            // Active display, interior, fill with gray.
            else
                rgb_nxt <= rgb_in;
        end
    end 
endmodule
