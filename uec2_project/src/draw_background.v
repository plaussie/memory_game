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
    
    localparam MEMORY_SIGNATURE_COLOR = 12'hf_8_b;
    
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
            else if ((hcount_in >= 255 && hcount_in < 271) && (vcount_in >= 63 && vcount_in < 255)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 271 && hcount_in < 287) && (vcount_in >= 63 && vcount_in < 95)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 287 && hcount_in < 303) && (vcount_in >= 79 && vcount_in < 111)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 303 && hcount_in < 319) && (vcount_in >= 63 && vcount_in < 95)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 319 && hcount_in < 335) && ((vcount_in >= 63 && vcount_in < 255) || (vcount_in >= 559 && vcount_in < 623) || (vcount_in >= 671 && vcount_in < 687))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 335 && hcount_in < 351) && ((vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 623 && vcount_in < 639) || (vcount_in >= 687 && vcount_in < 703))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 351 && hcount_in < 367) && ((vcount_in >= 175 && vcount_in < 239) || (vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 623 && vcount_in < 639)|| (vcount_in >= 671 && vcount_in < 687))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 367 && hcount_in < 383) && ((vcount_in >= 159 && vcount_in < 175) || (vcount_in >= 191 && vcount_in < 207) || (vcount_in >= 239 && vcount_in < 255)|| (vcount_in >= 559 && vcount_in < 671))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 383 && hcount_in < 399) && ((vcount_in >= 159 && vcount_in < 175) || (vcount_in >= 191 && vcount_in < 207) || (vcount_in >= 239 && vcount_in < 255))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 399 && hcount_in < 415) && ((vcount_in >= 175 && vcount_in < 207) || (vcount_in >= 239 && vcount_in < 255) || (vcount_in >= 559 && vcount_in < 623))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 415 && hcount_in < 431) && ((vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 431 && hcount_in < 447) && ((vcount_in >= 175 && vcount_in < 255) || (vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 447 && hcount_in < 463) && ((vcount_in >= 175 && vcount_in < 191) || (vcount_in >= 559 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 463 && hcount_in < 479) && ((vcount_in >= 175 && vcount_in < 207) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 479 && hcount_in < 495) && (vcount_in >= 175 && vcount_in < 191)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 495 && hcount_in < 511) && ((vcount_in >= 175 && vcount_in < 255) || (vcount_in >= 543 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 511 && hcount_in < 527) && (vcount_in >= 543 && vcount_in < 559)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 527 && hcount_in < 543) && ((vcount_in >= 191 && vcount_in < 239) || (vcount_in >= 543 && vcount_in < 575))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 543 && hcount_in < 559) && ((vcount_in >= 175 && vcount_in < 191) || (vcount_in >= 239 && vcount_in < 255) || (vcount_in >= 543 && vcount_in < 559))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 559 && hcount_in < 575) && ((vcount_in >= 175 && vcount_in < 191) || (vcount_in >= 239 && vcount_in < 255) || (vcount_in >= 543 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 575 && hcount_in < 591) && (vcount_in >= 191 && vcount_in < 239)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 591 && hcount_in < 607) && (vcount_in >= 559 && vcount_in < 623)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 607 && hcount_in < 623) && ((vcount_in >= 175 && vcount_in < 255) || (vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 575 && vcount_in < 591) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 623 && hcount_in < 639) && ((vcount_in >= 175 && vcount_in < 191) || (vcount_in >= 543 && vcount_in < 559) || (vcount_in >= 575 && vcount_in < 591) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 639 && hcount_in < 655) && ((vcount_in >= 175 && vcount_in < 191) || (vcount_in >= 559 && vcount_in < 591) || (vcount_in >= 623 && vcount_in < 639))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 655 && hcount_in < 671) && (vcount_in >= 175 && vcount_in < 207)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 687 && hcount_in < 703) && ((vcount_in >= 175 && vcount_in < 239) || (vcount_in >= 287 && vcount_in < 303))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 703 && hcount_in < 719) && ((vcount_in >= 239 && vcount_in < 255) || (vcount_in >= 303 && vcount_in < 319))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 719 && hcount_in < 735) && ((vcount_in >= 239 && vcount_in < 255) || (vcount_in >= 287 && vcount_in < 303))) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else if ((hcount_in >= 735 && hcount_in < 751) && (vcount_in >= 175 && vcount_in < 287)) rgb_nxt <= MEMORY_SIGNATURE_COLOR;
            else
                rgb_nxt <= rgb_in;
        end
    end 
endmodule
