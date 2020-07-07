`timescale 1ns / 1ps

module draw_background(
    input wire          pclk,
    input wire          rst,
    
    input wire [10:0]   vcount_in,
    input wire [10:0]   hcount_in,
    input wire          vsync_in,
    input wire          hsync_in,
    input wire          vblnk_in,
    input wire          hblnk_in,

    output reg [10:0]   vcount_out,
    output reg [10:0]   hcount_out,
    output reg          vsync_out,
    output reg          hsync_out,
    output reg          vblnk_out,
    output reg          hblnk_out,

    output reg [11:0]   rgb_out    
    );
    
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
        end
        else begin
            // Just pass these through.
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
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
            else if (vcount_in == 599) rgb_nxt <= 12'hf_0_0;
            // Active display, left edge, make a green line.
            else if (hcount_in == 0) rgb_nxt <= 12'h0_f_0;
            // Active display, right edge, make a blue line.
            else if (hcount_in == 799) rgb_nxt <= 12'h0_0_f;
            // Active display, interior, fill with gray.
            // You will replace this with your own test.
            else begin            
                if ((hcount_in >= 201) && (hcount_in <= 210) && (vcount_in >= 201) && (vcount_in <= 400))
                    rgb_nxt <= 12'hf_f_0;               
                else if ((vcount_in + hcount_in >= 501) && (vcount_in + hcount_in <= 510) && (vcount_in >= 201) && (vcount_in <=300))
                    rgb_nxt <= 12'hf_f_0;
                else if ((vcount_in - hcount_in >= 91) && (vcount_in - hcount_in <= 100) && (vcount_in >= 301) && (vcount_in <=400))
                    rgb_nxt <= 12'hf_f_0;
                else if ((hcount_in >= 501) && (hcount_in <= 510) && (vcount_in >= 201) && (vcount_in <= 400))
                    rgb_nxt <= 12'hf_f_0;
                else if ((hcount_in >= 501) && (hcount_in <= 600) && (vcount_in >= 201) && (vcount_in <= 210))
                    rgb_nxt <= 12'hf_f_0;
                else if ((hcount_in >= 501) && (hcount_in <= 600) && (vcount_in >= 391) && (vcount_in <= 400))
                    rgb_nxt <= 12'hf_f_0;
                else
                    rgb_nxt <= 12'h8_8_8;
            end
        end
    end 
endmodule
