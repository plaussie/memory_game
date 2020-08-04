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

// [1:0] to bity mówi¹ce o stanie karty, 00 - karta nieaktywna, 01 - karta przodem, 10 - karta ty³em;
// [13:2] to bity mówi¹ce o kolorze karty, kolejnoœæ MSB:r,g,b:LSB

module compute_colors(
    input wire clk,
    input wire rst,
    input wire enable,
    output wire done,
    output reg [13:0] computed_data,
    output reg [3:0] computed_address
    );
    
    reg [11:0] computed_color_nxt;
    reg [3:0] computed_address_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            computed_data <= {12'h0_0_0, 2'b00};
            computed_address <= 4'b0000;
        end
        else begin
            computed_data <= {computed_color_nxt, 2'b11};
            computed_address <= computed_address_nxt;
        end
    end
    
    always @* begin
        if(enable) begin
            case(computed_address[3:0])
                4'h0: computed_color_nxt = 12'hF_0_0; //red
                4'h1: computed_color_nxt = 12'hF_0_0; //red
                4'h2: computed_color_nxt = 12'h0_F_0; //green
                4'h3: computed_color_nxt = 12'h0_0_F; //blue
                4'h4: computed_color_nxt = 12'h0_F_F; //cyan
                4'h5: computed_color_nxt = 12'hF_0_F; //magenta
                4'h6: computed_color_nxt = 12'hF_F_0; //yellow
                4'h7: computed_color_nxt = 12'hF_0_0; //red
                4'h8: computed_color_nxt = 12'h0_F_0; //green
                4'h9: computed_color_nxt = 12'h0_0_F; //blue
                4'ha: computed_color_nxt = 12'h0_F_F; //cyan
                4'hb: computed_color_nxt = 12'hF_0_F; //magenta
                4'hc: computed_color_nxt = 12'hF_F_0; //yellow
                4'hd: computed_color_nxt = 12'h0_F_0; //green
                4'he: computed_color_nxt = 12'h0_0_F; //blue
                4'hf: computed_color_nxt = 12'h0_0_F; //blue
                default: computed_color_nxt = 12'h0_0_0;
            endcase
            computed_address_nxt = computed_address + 1;
        end
        else begin
            computed_color_nxt = 12'h0_0_0;
            computed_address_nxt = 0;
        end
    end
    
    assign done = (computed_address >= 4'hd) ? 1 : 0;

endmodule
