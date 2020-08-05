`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 23.07.2020 20:41:03
// Module Name: state_machine
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - DONE -> Main menu & Compute colors & Update Cards 1
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module state_machine(
    input wire clk,
    input wire rst,
    
    input wire start_butt_pressed,
    input wire compute_done,
    input wire card_pressed,
    
    output reg start_butt_en,
    output reg compute_colors_en,
    output reg update_cards_en
       
    );
    
    reg [3:0] state, state_nxt;
    reg start_butt_en_nxt, compute_colors_en_nxt, update_cards_en_nxt;
    
    localparam
    MAIN_MENU = 4'h0,
    COMPUTE_COLORS = 4'h1,
    UPDATE_CARDS_1 = 4'h2,
    WAIT_FOR_CLICK_1 = 4'h3,
    DISCOVER_FIRST_CARD = 4'h4,
    UPDATE_CARDS_2 = 4'h5,
    WAIT_FOR_CLICK_2 = 4'h6,
    DISCOVER_SECOND_CARD = 4'h7,
    UPDATE_CARDS_3 = 4'h8,
    CHECK_IF_SAME_CARDS = 4'h9,
    END_SCREEN = 4'hA;
    
    
    always @(posedge clk) begin
        if(rst) begin
            state <= MAIN_MENU;
            start_butt_en <= 0;
            compute_colors_en <= 0;
            update_cards_en <= 0;
        end
        else begin
            state <= state_nxt;
            start_butt_en <= start_butt_en_nxt;
            compute_colors_en <= compute_colors_en_nxt;
            update_cards_en <= update_cards_en_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        start_butt_en_nxt = 0;
        compute_colors_en_nxt = 0;
        update_cards_en_nxt = 0;
        
        case(state)
            MAIN_MENU: begin
                state_nxt = start_butt_pressed ? COMPUTE_COLORS : MAIN_MENU;
                start_butt_en_nxt = 1;
            end
            
            COMPUTE_COLORS: begin
                state_nxt = compute_done ? UPDATE_CARDS_1 : COMPUTE_COLORS;
                compute_colors_en_nxt = 1;
            end
            
            UPDATE_CARDS_1: begin
                state_nxt = WAIT_FOR_CLICK_1;
                update_cards_en_nxt = 1;
            end
            
            WAIT_FOR_CLICK_1: begin
                state_nxt = card_pressed ? DISCOVER_FIRST_CARD : WAIT_FOR_CLICK_1;
            end
            
            default: begin
            end
        endcase
    end
endmodule
