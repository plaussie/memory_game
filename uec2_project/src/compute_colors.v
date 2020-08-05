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
// Revision 0.40 - Added regfile with its control unit
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// computed_data[0] = 1 card is active; = 0 card is inactive
// computed_data[1] = 1 card is discovered; = 0 card is covered
// computed_data[13:2] represents card's computed color [ MSB:r,g,b:LSB ]

module compute_colors(
    input wire clk,
    input wire rst,
    input wire enable,
    output wire done,
    output reg [13:0] computed_data,
    output reg [3:0] computed_address
    );
    
    //Parameters for faster color recognizing
    localparam
    RED     = 12'hF_0_0,
    GREEN   = 12'h0_F_0,
    BLUE    = 12'h0_0_F,
    CYAN    = 12'h0_F_F,
    MAGENTA = 12'hF_0_F,
    YELLOW  = 12'hF_F_0,
    WHITE   = 12'hF_F_F,
    BLACK   = 12'h0_0_0,
    MINT    = 12'h0_A_A;
    
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
                // It might be misleading, but when address is 4'h0, color for address 4'h1 is computed. 
                // It is because the register 4'h0 is left for other variables.
                4'h0: computed_color_nxt = RED    ; // First card's color (register '4'h1')
                4'h1: computed_color_nxt = GREEN  ; // and so on
                4'h2: computed_color_nxt = BLUE   ;
                4'h3: computed_color_nxt = CYAN   ;
                4'h4: computed_color_nxt = MAGENTA;
                4'h5: computed_color_nxt = YELLOW ;
                4'h6: computed_color_nxt = RED    ;
                4'h7: computed_color_nxt = GREEN  ;
                4'h8: computed_color_nxt = BLUE   ;
                4'h9: computed_color_nxt = CYAN   ;
                4'ha: computed_color_nxt = MAGENTA;
                4'hb: computed_color_nxt = YELLOW ; // Last card's color (register '4'hc')
                default: computed_color_nxt = MINT; // It does not do anything, but was used to help with debugging
            endcase
            computed_address_nxt = computed_address + 1;
        end
        else begin
            // It does not do anything, but was left for safety reasons
            computed_color_nxt = 12'h0_0_0;
            computed_address_nxt = 0;
        end
    end
    
    assign done = (computed_address == 4'hb) ? 1 : 0;

endmodule
