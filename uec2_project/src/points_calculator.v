`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 10.09.2020 19:40:08
// Module Name: endgame_screen
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

module points_calculator(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire [7:0] discovered_pairs_ctr,
    input wire [5:0] seconds,
    output reg points_calculated,
    output reg [13:0] points
    );
    
    localparam 
    IDLE = 0,
    CALCULATE_SCORE = 1,
    WAIT_FOR_NXT_GAME = 2;
    
    reg points_calculated_nxt;
    reg [1:0] state, state_nxt;
    reg [12:0] time_score, diff_lvl_score, discovered_pairs_score; 
    reg [13:0] points_nxt;
    
    always @(posedge clk) begin
        if (rst) begin
            points <= 0;
            state <= IDLE;
            points_calculated <= 0;
        end
        else begin
            points <= points_nxt;
            state <= state_nxt;
            points_calculated <= points_calculated_nxt;
        end
    end
    
    always @* begin
        points_calculated_nxt = 1'b0;
        points_nxt = points;
        time_score = 0;
        diff_lvl_score = 0;
        discovered_pairs_score = 0;
        case(state)
            IDLE: begin
                points_nxt = 0;
                state_nxt = enable ? CALCULATE_SCORE : state;
            end
            
            CALCULATE_SCORE: begin
                state_nxt = WAIT_FOR_NXT_GAME;
                points_calculated_nxt = 1'b1;
                // difficulty level and then score based of game time
                if (`CARD_NUM_EASY == num_of_cards) begin
                    diff_lvl_score = 0;
                    if (seconds < 33) 
                        time_score = 3333 - (seconds * 101); 
                    else begin
                        time_score = 0;
                    end
                end
                else if (`CARD_NUM_NORMAL == num_of_cards) begin
                    diff_lvl_score = 1515;
                    if (seconds < 38) begin
                        if (seconds <= 5) time_score = 3333;
                        else time_score = 3333 - (seconds - 5) * 101; 
                    end
                    else begin
                        time_score = 0;
                    end
                end
                else if (`CARD_NUM_HARD == num_of_cards) begin
                    diff_lvl_score = 3333;
                    if (seconds < 43) begin
                        if (seconds <= 10) time_score = 3333;
                        else time_score = 3333 - (seconds - 10) * 101; 
                    end
                    else begin
                        time_score = 0;
                    end
                end
                else begin
                    // do nothing 
                end
                // discovered pairs of cards
                if (discovered_pairs_ctr < (num_of_cards/2 + 33)) begin
                    discovered_pairs_score = 3333 - (discovered_pairs_ctr - num_of_cards/2) * 101;
                end
                else begin
                    discovered_pairs_score = 0;
                end
                points_nxt = diff_lvl_score + time_score + discovered_pairs_score;
            end
          
            WAIT_FOR_NXT_GAME: begin
                state_nxt = enable ? state : IDLE;
            end
            
            default: state_nxt = state;
        endcase
    end
endmodule