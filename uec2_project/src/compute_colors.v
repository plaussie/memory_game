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

`include "_cards_macros.vh"

module compute_colors(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    output wire done,
    output reg [`CARD_DATA_SIZE-1:0] computed_data,
    output reg [`CARD_ADDRESS_SIZE-1:0] computed_address
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
    MINT    = 12'h0_A_A,
    ORANGE  = 12'hF_8_2,
    PURPLE  = 12'h8_0_2;
    
    reg [`CARD_COLOR_SIZE-1:0] computed_color_nxt;
    reg [`CARD_ADDRESS_SIZE-1:0] computed_address_nxt;
    reg [2:0] game_version, game_version_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            computed_data <= {12'h0_0_0, 2'b00};
            computed_address <= 0;
            game_version <= 0;
        end
        else begin
            computed_data <= {computed_color_nxt, 2'b01};
            computed_address <= computed_address_nxt;
            game_version <= game_version_nxt;
        end
    end
    
    always @* begin
        if(enable)
            game_version_nxt = game_version;
        else if (3'b111 == game_version)
            game_version_nxt = 0;
        else  
            game_version_nxt = game_version + 1;
    end
    
    
    always @* begin
        computed_color_nxt = 12'h0_0_0;
        computed_address_nxt = 0;
        if(enable) begin
            computed_address_nxt = computed_address + 1;
            if(`CARD_NUM_NORMAL == num_of_cards) begin
                case(game_version)
                    3'b000: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = YELLOW;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = GREEN;
                            5'd4: computed_color_nxt = CYAN;
                            5'd5: computed_color_nxt = MAGENTA;
                            5'd6: computed_color_nxt = CYAN;
                            5'd7: computed_color_nxt = YELLOW;
                            5'd8: computed_color_nxt = GREEN;
                            5'd9: computed_color_nxt = MAGENTA;
                            5'd10: computed_color_nxt = RED;    
                            5'd11: computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b001: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = RED;
                            5'd1: computed_color_nxt = GREEN;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = CYAN;
                            5'd4: computed_color_nxt = BLUE;
                            5'd5: computed_color_nxt = RED;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = MAGENTA;
                            5'd8: computed_color_nxt = CYAN;
                            5'd9: computed_color_nxt = MAGENTA;
                            5'd10:computed_color_nxt = YELLOW;    
                            5'd11:computed_color_nxt = GREEN;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end 
                    3'b010: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = YELLOW;
                            5'd1: computed_color_nxt = CYAN;
                            5'd2: computed_color_nxt = GREEN;
                            5'd3: computed_color_nxt = BLUE;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = BLUE;
                            5'd6: computed_color_nxt = MAGENTA;
                            5'd7: computed_color_nxt = MAGENTA;
                            5'd8: computed_color_nxt = CYAN;
                            5'd9: computed_color_nxt = RED;
                            5'd10:computed_color_nxt = GREEN;    
                            5'd11:computed_color_nxt = RED;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b011: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = BLUE;
                            5'd1: computed_color_nxt = MAGENTA;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = GREEN;
                            5'd4: computed_color_nxt = RED;
                            5'd5: computed_color_nxt = CYAN;
                            5'd6: computed_color_nxt = GREEN;
                            5'd7: computed_color_nxt = CYAN;
                            5'd8: computed_color_nxt = MAGENTA;
                            5'd9: computed_color_nxt = RED;
                            5'd10:computed_color_nxt = YELLOW;    
                            5'd11:computed_color_nxt = YELLOW;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end
                    3'b100: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = MAGENTA;
                            5'd1: computed_color_nxt = CYAN;
                            5'd2: computed_color_nxt = YELLOW;
                            5'd3: computed_color_nxt = MAGENTA;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = BLUE;
                            5'd6: computed_color_nxt = GREEN;
                            5'd7: computed_color_nxt = YELLOW;
                            5'd8: computed_color_nxt = RED;
                            5'd9: computed_color_nxt = CYAN;
                            5'd10:computed_color_nxt = RED;    
                            5'd11:computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end 
                    3'b101: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = GREEN;
                            5'd1: computed_color_nxt = CYAN;
                            5'd2: computed_color_nxt = GREEN;
                            5'd3: computed_color_nxt = MAGENTA;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = CYAN;
                            5'd6: computed_color_nxt = RED;
                            5'd7: computed_color_nxt = RED;
                            5'd8: computed_color_nxt = BLUE;
                            5'd9: computed_color_nxt = YELLOW;
                            5'd10:computed_color_nxt = MAGENTA;    
                            5'd11:computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end  
                    3'b110: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = MAGENTA;
                            5'd1: computed_color_nxt = GREEN;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = BLUE;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = RED;
                            5'd6: computed_color_nxt = RED;
                            5'd7: computed_color_nxt = YELLOW;
                            5'd8: computed_color_nxt = CYAN;
                            5'd9: computed_color_nxt = MAGENTA;
                            5'd10:computed_color_nxt = CYAN;    
                            5'd11:computed_color_nxt = YELLOW;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end    
                    3'b111: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = GREEN;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = MAGENTA;
                            5'd3: computed_color_nxt = YELLOW;
                            5'd4: computed_color_nxt = RED;
                            5'd5: computed_color_nxt = CYAN;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = GREEN;
                            5'd8: computed_color_nxt = BLUE;
                            5'd9: computed_color_nxt = MAGENTA;
                            5'd10:computed_color_nxt = CYAN;    
                            5'd11:computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end                                                                                                        
                endcase
            end
            else if(`CARD_NUM_EASY == num_of_cards) begin
                case(game_version)
                    3'b000: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = GREEN;
                            5'd1: computed_color_nxt = BLUE;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = RED;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = RED;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b001: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = RED;
                            5'd1: computed_color_nxt = GREEN;
                            5'd2: computed_color_nxt = YELLOW;
                            5'd3: computed_color_nxt = BLUE;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = BLUE;
                            5'd6: computed_color_nxt = GREEN;
                            5'd7: computed_color_nxt = RED;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end 
                    3'b010: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = BLUE;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = RED;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = GREEN;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b011: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = RED;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = YELLOW;
                            5'd4: computed_color_nxt = BLUE;
                            5'd5: computed_color_nxt = GREEN;
                            5'd6: computed_color_nxt = GREEN;
                            5'd7: computed_color_nxt = YELLOW;
                        endcase
                    end
                    3'b100: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = GREEN;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = RED;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = BLUE;
                            5'd7: computed_color_nxt = GREEN;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end 
                    3'b101: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = GREEN;
                            5'd1: computed_color_nxt = YELLOW;
                            5'd2: computed_color_nxt = GREEN;
                            5'd3: computed_color_nxt = RED;
                            5'd4: computed_color_nxt = BLUE;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = RED;
                            5'd7: computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end  
                    3'b110: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = BLUE;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = GREEN;
                            5'd3: computed_color_nxt = YELLOW;
                            5'd4: computed_color_nxt = RED;
                            5'd5: computed_color_nxt = GREEN;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end    
                    3'b111: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = BLUE;
                            5'd1: computed_color_nxt = GREEN;
                            5'd2: computed_color_nxt = RED;
                            5'd3: computed_color_nxt = RED;
                            5'd4: computed_color_nxt = BLUE;
                            5'd5: computed_color_nxt = GREEN;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = YELLOW;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end                                                                                                        
                endcase
            end
            else if (`CARD_NUM_HARD == num_of_cards) begin
                case(game_version)
                    3'b000: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = ORANGE;
                            5'd1: computed_color_nxt = MAGENTA;
                            5'd2: computed_color_nxt = CYAN;
                            5'd3: computed_color_nxt = GREEN;
                            5'd4: computed_color_nxt = PURPLE;
                            5'd5: computed_color_nxt = RED;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = CYAN;
                            5'd8: computed_color_nxt = GREEN;
                            5'd9: computed_color_nxt = BLUE;
                            5'd10: computed_color_nxt = RED;    
                            5'd11: computed_color_nxt = ORANGE;
                            5'd12: computed_color_nxt = MAGENTA;
                            5'd13: computed_color_nxt = BLUE;
                            5'd14: computed_color_nxt = PURPLE;
                            5'd15: computed_color_nxt = YELLOW;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b001: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = MAGENTA;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = ORANGE;
                            5'd3: computed_color_nxt = CYAN;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = MAGENTA;
                            5'd7: computed_color_nxt = ORANGE;
                            5'd8: computed_color_nxt = GREEN;
                            5'd9: computed_color_nxt = CYAN;
                            5'd10: computed_color_nxt = YELLOW;    
                            5'd11: computed_color_nxt = PURPLE;
                            5'd12: computed_color_nxt = PURPLE;
                            5'd13: computed_color_nxt = BLUE;
                            5'd14: computed_color_nxt = RED;
                            5'd15: computed_color_nxt = BLUE;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end 
                    3'b010: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = PURPLE;
                            5'd1: computed_color_nxt = YELLOW;
                            5'd2: computed_color_nxt = RED;
                            5'd3: computed_color_nxt = MAGENTA;
                            5'd4: computed_color_nxt = MAGENTA;
                            5'd5: computed_color_nxt = YELLOW;
                            5'd6: computed_color_nxt = PURPLE;
                            5'd7: computed_color_nxt = GREEN;
                            5'd8: computed_color_nxt = CYAN;
                            5'd9: computed_color_nxt = BLUE;
                            5'd10: computed_color_nxt = BLUE;    
                            5'd11: computed_color_nxt = ORANGE;
                            5'd12: computed_color_nxt = RED;
                            5'd13: computed_color_nxt = GREEN;
                            5'd14: computed_color_nxt = CYAN;
                            5'd15: computed_color_nxt = ORANGE;
                            default: computed_color_nxt = WHITE;
                        endcase
                    end
                    3'b011: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = MAGENTA;
                            5'd1: computed_color_nxt = CYAN;
                            5'd2: computed_color_nxt = ORANGE;
                            5'd3: computed_color_nxt = ORANGE;
                            5'd4: computed_color_nxt = PURPLE;
                            5'd5: computed_color_nxt = BLUE;
                            5'd6: computed_color_nxt = BLUE;
                            5'd7: computed_color_nxt = CYAN;
                            5'd8: computed_color_nxt = PURPLE;
                            5'd9: computed_color_nxt = GREEN;
                            5'd10: computed_color_nxt = RED;    
                            5'd11: computed_color_nxt = YELLOW;
                            5'd12: computed_color_nxt = YELLOW;
                            5'd13: computed_color_nxt = GREEN;
                            5'd14: computed_color_nxt = RED;
                            5'd15: computed_color_nxt = MAGENTA;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end
                    3'b100: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = PURPLE;
                            5'd1: computed_color_nxt = ORANGE;
                            5'd2: computed_color_nxt = BLUE;
                            5'd3: computed_color_nxt = MAGENTA;
                            5'd4: computed_color_nxt = GREEN;
                            5'd5: computed_color_nxt = PURPLE;
                            5'd6: computed_color_nxt = RED;
                            5'd7: computed_color_nxt = CYAN;
                            5'd8: computed_color_nxt = YELLOW;
                            5'd9: computed_color_nxt = ORANGE;
                            5'd10: computed_color_nxt = RED;    
                            5'd11: computed_color_nxt = GREEN;
                            5'd12: computed_color_nxt = BLUE;
                            5'd13: computed_color_nxt = CYAN;
                            5'd14: computed_color_nxt = YELLOW;
                            5'd15: computed_color_nxt = MAGENTA;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end 
                    3'b101: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = RED;
                            5'd1: computed_color_nxt = MAGENTA;
                            5'd2: computed_color_nxt = ORANGE;
                            5'd3: computed_color_nxt = GREEN;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = CYAN;
                            5'd6: computed_color_nxt = CYAN;
                            5'd7: computed_color_nxt = PURPLE;
                            5'd8: computed_color_nxt = PURPLE;
                            5'd9: computed_color_nxt = BLUE;
                            5'd10: computed_color_nxt = MAGENTA;    
                            5'd11: computed_color_nxt = BLUE;
                            5'd12: computed_color_nxt = GREEN;
                            5'd13: computed_color_nxt = YELLOW;
                            5'd14: computed_color_nxt = RED;
                            5'd15: computed_color_nxt = ORANGE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end  
                    3'b110: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = ORANGE;
                            5'd1: computed_color_nxt = RED;
                            5'd2: computed_color_nxt = ORANGE;
                            5'd3: computed_color_nxt = PURPLE;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = BLUE;
                            5'd6: computed_color_nxt = MAGENTA;
                            5'd7: computed_color_nxt = GREEN;
                            5'd8: computed_color_nxt = CYAN;
                            5'd9: computed_color_nxt = GREEN;
                            5'd10: computed_color_nxt = RED;    
                            5'd11: computed_color_nxt = CYAN;
                            5'd12: computed_color_nxt = BLUE;
                            5'd13: computed_color_nxt = MAGENTA;
                            5'd14: computed_color_nxt = YELLOW;
                            5'd15: computed_color_nxt = PURPLE;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end    
                    3'b111: begin
                        case(computed_address)
                            // It might be misleading, but when computed_address is 5'd0, color for address 5'd1 is computed. 
                            // It is because the register 4'h0 is left for other variables.
                            5'd0: computed_color_nxt = BLUE;
                            5'd1: computed_color_nxt = PURPLE;
                            5'd2: computed_color_nxt = CYAN;
                            5'd3: computed_color_nxt = CYAN;
                            5'd4: computed_color_nxt = YELLOW;
                            5'd5: computed_color_nxt = RED;
                            5'd6: computed_color_nxt = YELLOW;
                            5'd7: computed_color_nxt = GREEN;
                            5'd8: computed_color_nxt = MAGENTA;
                            5'd9: computed_color_nxt = BLUE;
                            5'd10: computed_color_nxt = GREEN;    
                            5'd11: computed_color_nxt = MAGENTA;
                            5'd12: computed_color_nxt = ORANGE;
                            5'd13: computed_color_nxt = PURPLE;
                            5'd14: computed_color_nxt = ORANGE;
                            5'd15: computed_color_nxt = RED;
                            default: computed_color_nxt = WHITE; 
                        endcase
                    end                                                                                                        
                endcase
            end            
        end
    end
    
    assign done = (computed_address == num_of_cards-1) ? 1 : 0;

endmodule
