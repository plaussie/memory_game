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
    input wire go_to_compare,
    
    output reg start_butt_en,
    output reg compute_colors_en,
    output reg update_cards_en,
    output reg wait_for_click_en,
    output reg write_card_en
       
    );
    
    reg [3:0] state, state_nxt;
    reg start_butt_en_nxt, compute_colors_en_nxt, update_cards_en_nxt, wait_for_click_en_nxt, write_card_en_nxt;
    reg [26:0] temp_wait_ctr, temp_wait_ctr_nxt;
    
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
    COMPARE_CARDS = 4'h9,
    END_SCREEN = 4'ha,
    TEMP_WAIT1 = 4'hb,
    TEMP_WAIT2 = 4'hc,
    TEMP_WAIT3 = 4'hd,
    TEMP_WAIT4 = 4'he;
    
    
    always @(posedge clk) begin
        if(rst) begin
            state <= MAIN_MENU;
            start_butt_en <= 0;
            compute_colors_en <= 0;
            update_cards_en <= 0;
            wait_for_click_en <= 0;
            write_card_en <= 0;
            temp_wait_ctr <= 0;
        end
        else begin
            state <= state_nxt;
            start_butt_en <= start_butt_en_nxt;
            compute_colors_en <= compute_colors_en_nxt;
            update_cards_en <= update_cards_en_nxt;
            wait_for_click_en <= wait_for_click_en_nxt;
            write_card_en <= write_card_en_nxt;
            temp_wait_ctr <= temp_wait_ctr_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        start_butt_en_nxt = 0;
        compute_colors_en_nxt = 0;
        update_cards_en_nxt = 0;
        wait_for_click_en_nxt = 0;
        write_card_en_nxt = 0;
        temp_wait_ctr_nxt = 0;
        
        case(state)
            MAIN_MENU: begin
                state_nxt = start_butt_pressed ? COMPUTE_COLORS : state;
                start_butt_en_nxt = 1;
            end
            
            COMPUTE_COLORS: begin
                state_nxt = compute_done ? UPDATE_CARDS_1 : state;
                compute_colors_en_nxt = 1;
            end
            
            UPDATE_CARDS_1: begin
                state_nxt = TEMP_WAIT1;//WAIT_FOR_CLICK_1;
                update_cards_en_nxt = 1;
            end
            
            TEMP_WAIT1: begin
                state_nxt = (temp_wait_ctr == 32500000) ? WAIT_FOR_CLICK_1 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_1: begin
                state_nxt = go_to_compare ? COMPARE_CARDS :
                            card_pressed ? DISCOVER_FIRST_CARD : state;
                wait_for_click_en_nxt = 1;
            end
            
            DISCOVER_FIRST_CARD: begin
                state_nxt = UPDATE_CARDS_2;
                write_card_en_nxt = 1; 
            end
            
            UPDATE_CARDS_2: begin
                state_nxt = TEMP_WAIT2;//WAIT_FOR_CLICK_2;
                update_cards_en_nxt = 1;
            end
            
            TEMP_WAIT2: begin
                state_nxt = (temp_wait_ctr == 13000000) ? WAIT_FOR_CLICK_2 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_2: begin
                state_nxt = card_pressed ? DISCOVER_SECOND_CARD : WAIT_FOR_CLICK_2;
                wait_for_click_en_nxt = 1;
            end
            
            DISCOVER_SECOND_CARD: begin
                state_nxt = UPDATE_CARDS_3;
                write_card_en_nxt = 1; 
            end
            
            UPDATE_CARDS_3: begin
                state_nxt = COMPARE_CARDS;
                update_cards_en_nxt = 1;
            end
            
            COMPARE_CARDS: begin
                state_nxt = state;
            end
            default: begin
            end
        endcase
    end
endmodule
