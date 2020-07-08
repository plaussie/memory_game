//////////////////////////////////////////////////////////////////////////////////
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
    input wire          pclk,
    input wire          rst,
    
    output wire [10:0]  vcount,
    output wire [10:0]  hcount,
    output wire         vsync,
    output wire         hsync,
    output wire         vblnk,
    output wire         hblnk
    );

    // Describe the actual circuit for the assignment.
    // Video timing controller set for 800x600@60fps
    // using a 40 MHz pixel clock per VESA spec.
    
    reg [10:0] vcount_reg, vcount_reg_nxt, hcount_reg, hcount_reg_nxt;
  
    initial begin
        vcount_reg = 0;
        hcount_reg = 0;
    end
    
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
        if(hcount_reg < 1055) begin
                hcount_reg_nxt = hcount_reg + 1;
                vcount_reg_nxt = vcount_reg;
        end
        else begin
            hcount_reg_nxt = 0;
            if(vcount_reg < 627) begin
                vcount_reg_nxt = vcount_reg + 1;
            end
            else begin
                vcount_reg_nxt = 0;
            end
        end
    end
    
    assign vcount = vcount_reg;
    assign hcount = hcount_reg;
    assign vsync = ((vcount_reg >= 601) && (vcount_reg <= 604));
    assign hsync = ((hcount_reg >= 840) && (hcount_reg <= 967));
    assign vblnk = (vcount_reg >= 600);
    assign hblnk = (hcount_reg >= 800);
    
endmodule
