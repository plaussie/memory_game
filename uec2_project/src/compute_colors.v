`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 27.07.2020 20:16:49
// Module Name: compute_colors
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module compute_colors(
    input wire clk,
    input wire rst,
    input wire enable,
    output reg finished,
    output reg [11:0] computed_color,
    output reg [3:0] mem_address
    );
    
    reg finished_nxt;
    reg [11:0] computed_color_nxt;
    reg [3:0] mem_address_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            finished <= 0;
            computed_color <= 12'h0_0_0;
            mem_address <= 4'b0000;
        end
        else begin
            finished <= finished_nxt;
            computed_color <= computed_color_nxt;
            mem_address <= mem_address_nxt;
        end
    end
    
    always @* begin
        if(enable) begin
            case(mem_address[3:1])
                3'b000: computed_color_nxt = 12'hF_0_0;
                3'b001: computed_color_nxt = 12'hF_F_0;
                3'b010: computed_color_nxt = 12'hF_F_F;
                3'b011: computed_color_nxt = 12'h0_0_F;
                3'b100: computed_color_nxt = 12'h0_F_F;
                3'b101: computed_color_nxt = 12'hF_0_F;
                default: computed_color_nxt = 12'h0_0_0;
            endcase
            mem_address_nxt = mem_address + 1;
        end
        else begin
            computed_color_nxt = 12'h0_0_0;
            mem_address_nxt = 0;
        end
    end
endmodule
