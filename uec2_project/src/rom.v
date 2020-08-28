`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 28.08.2020 17:28:17
// Module Name: rom
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


module rom(
    input wire clk,
    input wire rst,
    input wire read_all_positions,
    input wire [4:0] num_of_cards,
    output reg [19:0] yx_card_position          //[19:10] y_position ; [9:0] x_position
    );
    
    reg state, state_nxt;
    reg [4:0] card_address_ctr, card_address_ctr_nxt;
    reg [19:0] yx_card_position_nxt;
    
    localparam
    EASY_MODE = 8,
    NORMAL_MODE = 12,
    HARD_MODE = 18;
    
    localparam
    IDLE = 0,
    READ_ALL = 1;
    
    always @(posedge clk) begin
        if(rst) begin
            yx_card_position <= 0;
            card_address_ctr <= 0;
            state <= IDLE;
        end
        else begin
            yx_card_position <= yx_card_position_nxt;
            card_address_ctr <= card_address_ctr_nxt;
            state <= state_nxt;
        end
    end
    
    always @* begin
        card_address_ctr_nxt = 0;
        yx_card_position_nxt = {10'd1023, 10'd1023};
        state_nxt = state;
        case(state)
            IDLE: begin
                state_nxt = read_all_positions ? READ_ALL : state;
            end
            READ_ALL: begin
                state_nxt = (card_address_ctr == num_of_cards-1) ? IDLE : state;
                card_address_ctr_nxt = card_address_ctr + 1;
                case(num_of_cards)
                    EASY_MODE: begin
                        case(card_address_ctr)
                            0:  yx_card_position_nxt = {10'd50, 10'd50};
                            1:  yx_card_position_nxt = {10'd50, 10'd308};
                            2:  yx_card_position_nxt = {10'd50, 10'd566};
                            3:  yx_card_position_nxt = {10'd50, 10'd824};
                            4:  yx_card_position_nxt = {10'd418, 10'd50};
                            5:  yx_card_position_nxt = {10'd418, 10'd308};
                            6:  yx_card_position_nxt = {10'd418, 10'd566};
                            7:  yx_card_position_nxt = {10'd418, 10'd824};
                            default: yx_card_position_nxt = {10'd1023, 10'd1023};
                        endcase
                    end
                    NORMAL_MODE: begin
                        case(card_address_ctr)
                            0:  yx_card_position_nxt = {10'd50, 10'd50};
                            1:  yx_card_position_nxt = {10'd50, 10'd308};
                            2:  yx_card_position_nxt = {10'd50, 10'd566};
                            3:  yx_card_position_nxt = {10'd50, 10'd824};
                            4:  yx_card_position_nxt = {10'd284, 10'd50};
                            5:  yx_card_position_nxt = {10'd284, 10'd308};
                            6:  yx_card_position_nxt = {10'd284, 10'd566};
                            7:  yx_card_position_nxt = {10'd284, 10'd824};
                            8:  yx_card_position_nxt = {10'd518, 10'd50};
                            9:  yx_card_position_nxt = {10'd518, 10'd308};
                            10: yx_card_position_nxt = {10'd518, 10'd566};
                            11: yx_card_position_nxt = {10'd518, 10'd824};
                            default: yx_card_position_nxt = {10'd1023, 10'd1023};
                        endcase
                    end
                    HARD_MODE: begin
                        case(card_address_ctr)
                            0:  yx_card_position_nxt = {10'd25, 10'd50};
                            1:  yx_card_position_nxt = {10'd25, 10'd308};
                            2:  yx_card_position_nxt = {10'd25, 10'd566};
                            3:  yx_card_position_nxt = {10'd25, 10'd824};
                            4:  yx_card_position_nxt = {10'd200, 10'd50};
                            5:  yx_card_position_nxt = {10'd200, 10'd308};
                            6:  yx_card_position_nxt = {10'd200, 10'd566};
                            7:  yx_card_position_nxt = {10'd200, 10'd824};
                            8:  yx_card_position_nxt = {10'd375, 10'd50};
                            9:  yx_card_position_nxt = {10'd375, 10'd308};
                            10: yx_card_position_nxt = {10'd375, 10'd566};
                            11: yx_card_position_nxt = {10'd375, 10'd824};
                            12: yx_card_position_nxt = {10'd550, 10'd50}; 
                            13: yx_card_position_nxt = {10'd550, 10'd308};
                            14: yx_card_position_nxt = {10'd550, 10'd566};
                            15: yx_card_position_nxt = {10'd550, 10'd824};
                            default: yx_card_position_nxt = {10'd1023, 10'd1023};
                        endcase
                    end
                endcase
            end
        endcase
    end

endmodule
