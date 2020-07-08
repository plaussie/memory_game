`timescale 1ns / 1ps

module draw_rect(
    input wire [11:0]   xpos,
    input wire [11:0]   ypos,
    
    input wire [10:0]   vcount_in,
    input wire [10:0]   hcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    
    input wire [11:0]   rgb_in,
    input wire [11:0]   rgb_pixel,
    
    output reg [10:0]   vcount_out,
    output reg [10:0]   hcount_out,
    output reg          vsync_out,
    output reg          hsync_out,
    output reg          hblnk_out,
    output reg          vblnk_out,
    
    output reg [11:0]   rgb_out,
    output reg [11:0]   pixel_addr,
    
    input wire          pclk,
    input wire          rst
    );

    localparam RECT_WIDTH = 48;
    localparam RECT_HEIGHT = 64;
//    localparam RECT_COLOR = 12'h0_A_A;

    reg [5:0] addry, addrx;
    wire [10:0] hcount_in_delayed, vcount_in_delayed;
    wire hsync_in_delayed, vsync_in_delayed, hblnk_in_delayed, vblnk_in_delayed;
    wire [11:0] rgb_in_delayed;
    reg [11:0] rgb_nxt;

    always @(posedge pclk or posedge rst)
    begin
        if(rst) begin
            hsync_out <= 0;
            vsync_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
            pixel_addr <= 12'bx;
        end
        else begin
            // Just pass these through.
            hsync_out <= hsync_in_delayed;
            vsync_out <= vsync_in_delayed;
            hblnk_out <= hblnk_in_delayed;
            vblnk_out <= vblnk_in_delayed;
            hcount_out <= hcount_in_delayed;
            vcount_out <= vcount_in_delayed;
            pixel_addr <= {addry[5:0], addrx[5:0]};
            rgb_out <= rgb_nxt;
        end
    end
    
    always @*
    begin
        if ((hcount_in_delayed >= xpos) && (hcount_in_delayed < xpos+RECT_WIDTH) && (vcount_in_delayed >= ypos) && (vcount_in_delayed < ypos+RECT_HEIGHT)) begin
            rgb_nxt <= rgb_pixel;
        end
        else begin
            rgb_nxt <= rgb_in_delayed;
        end
    end

    always @*
    begin
        if ((hcount_in >= xpos) && (hcount_in < xpos+RECT_WIDTH) && (vcount_in >= ypos) && (vcount_in < ypos+RECT_HEIGHT)) begin
            addrx = hcount_in-xpos;
            addry = vcount_in-ypos;
        end
        else begin
            addrx = 6'bx;
            addry = 6'bx;
        end
    end
    
    //delaying inputs by 2 cycles
    
    delay
    #(
        .WIDTH(38),
        .CLK_DEL(2)
    )
    delay_in_draw_rect (
        .clk(pclk),
        .rst(rst),
        .din({rgb_in, hcount_in, vcount_in, hsync_in, vsync_in, hblnk_in, vblnk_in}),
        .dout({rgb_in_delayed, hcount_in_delayed, vcount_in_delayed, hsync_in_delayed, vsync_in_delayed, hblnk_in_delayed, vblnk_in_delayed})
    );
    
endmodule