`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 28.08.2020 17:28:17
// Module Name: cards_pos_gen
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

`include "_cards_macros.vh"

module cards_pos_gen(
    input wire clk,
    input wire rst,
    input wire read_all_positions,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    output reg [`CARD_YX_POSITION_SIZE-1:0] yx_card_position          //[19:10] y_position ; [9:0] x_position
    );
    
    reg state, state_nxt;
    reg [`CARD_MAX_NUM_SIZE-1:0] card_address_ctr, card_address_ctr_nxt;
    reg [`CARD_YX_POSITION_SIZE-1:0] yx_card_position_nxt;

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
                    `CARD_NUM_EASY: begin
                        case(card_address_ctr)
                            0:  yx_card_position_nxt = {10'd85, 10'd50};
                            1:  yx_card_position_nxt = {10'd85, 10'd296};
                            2:  yx_card_position_nxt = {10'd85, 10'd542};
                            3:  yx_card_position_nxt = {10'd85, 10'd788};
                            4:  yx_card_position_nxt = {10'd433, 10'd50}; 
                            5:  yx_card_position_nxt = {10'd433, 10'd296};
                            6:  yx_card_position_nxt = {10'd433, 10'd542};
                            7:  yx_card_position_nxt = {10'd433, 10'd788};
                            default: yx_card_position_nxt = {10'd1023, 10'd1023};
                        endcase
                    end
                    `CARD_NUM_NORMAL: begin
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
                    `CARD_NUM_HARD: begin
                        case(card_address_ctr)
                            0:  yx_card_position_nxt = {10'd35, 10'd115};
                            1:  yx_card_position_nxt = {10'd35, 10'd342};
                            2:  yx_card_position_nxt = {10'd35, 10'd569};
                            3:  yx_card_position_nxt = {10'd35, 10'd796};
                            4:  yx_card_position_nxt = {10'd218, 10'd115};
                            5:  yx_card_position_nxt = {10'd218, 10'd342};
                            6:  yx_card_position_nxt = {10'd218, 10'd569};
                            7:  yx_card_position_nxt = {10'd218, 10'd796};
                            8:  yx_card_position_nxt = {10'd401, 10'd115};
                            9:  yx_card_position_nxt = {10'd401, 10'd342};
                            10: yx_card_position_nxt = {10'd401, 10'd569};
                            11: yx_card_position_nxt = {10'd401, 10'd796};
                            12: yx_card_position_nxt = {10'd584, 10'd115}; 
                            13: yx_card_position_nxt = {10'd584, 10'd342};
                            14: yx_card_position_nxt = {10'd584, 10'd569};
                            15: yx_card_position_nxt = {10'd584, 10'd796};
                            default: yx_card_position_nxt = {10'd1023, 10'd1023};
                        endcase
                    end
                endcase
            end
        endcase
    end

endmodule
