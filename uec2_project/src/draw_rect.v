`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 11.07.2020 13:59:37
// Module Name: draw_rect
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivaenable 2017.3
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

module draw_rect
    #( parameter
        X_POS   = 412,
        Y_POS   = 328,
        WIDTH   = 200,
        HEIGHT  = 112,
        COLOR   = 12'h0_A_A
    )
    (
        input wire pclk,
        input wire rst,
        input wire enable,
        input wire [11:0] rgb_pixel,
        input wire [`VGA_BUS_SIZE-1:0] vga_in,
        output reg [15:0] pixel_address,
        output wire [`VGA_BUS_SIZE-1:0] vga_out
    );

    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_OUTPUT(vga_out)
    
    reg [11:0] rgb_nxt;
    wire hs_in_delayed, vs_in_delayed, hblnk_in_delayed, vblnk_in_delayed;
    wire [11:0] rgb_in_delayed;
    reg [7:0] addry, addrx;
    wire [10:0] hcount_in_delayed, vcount_in_delayed;
    
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
            pixel_address <= 16'bx;
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
            pixel_address <= {addry[7:0],addrx[7:0]};
        end
    end
    
    always @*
    begin
        if (enable && ((hcount_in_delayed >= X_POS) && (hcount_in_delayed < X_POS+WIDTH) && (vcount_in_delayed >= Y_POS) && (vcount_in_delayed < Y_POS+HEIGHT))) begin
            rgb_nxt <= rgb_pixel;
        end
        else begin
            rgb_nxt <= rgb_in_delayed;
        end
    end

    always @*
    begin
        if (enable && ((hcount_in >= X_POS) && (hcount_in < X_POS+WIDTH) && (vcount_in >= Y_POS) && (vcount_in < Y_POS+HEIGHT))) begin
            addrx = hcount_in-X_POS;
            addry = vcount_in-Y_POS;
        end
        else begin
            addrx = 8'bx;
            addry = 8'bx;
        end
    end
    
    delay
    #(
        .WIDTH(38),
        .CLK_DEL(2)
    )
    delay_in_draw_rect (
        .clk(pclk),
        .rst(rst),
        .din({rgb_in, hcount_in, vcount_in, hs_in, vs_in, hblnk_in, vblnk_in}),
        .dout({rgb_in_delayed, hcount_in_delayed, vcount_in_delayed, hs_in_delayed, vs_in_delayed, hblnk_in_delayed, vblnk_in_delayed})
    );
    
endmodule
