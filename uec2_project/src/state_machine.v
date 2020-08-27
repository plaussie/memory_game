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
// Revision 0.10 - DONE -> Everything except for END_SCREEN
// Revision 0.11 - DONE -> Everything in main path
// Additional Comments:
// TODO - Options and highscores
//////////////////////////////////////////////////////////////////////////////////


module state_machine(
    input wire clk,
    input wire rst,
    
    input wire start_butt_pressed,
    input wire try_again_butt_pressed,
    input wire compute_done,
    input wire card_pressed,
    input wire [3:0] card_clicked_address,
    input wire [11:0] card_clicked_color,
    
    output reg start_butt_en,
    output reg compute_colors_en,
    output reg stopwatch_en,
    output reg stopwatch_disable,
    output reg update_cards_en,
    output reg wait_for_click_en,
    output reg write_card_en,
    output reg end_screen_en,
    output reg [1:0] write_card_state,
    output reg [3:0] write_card_address
       
    );
    
    reg [3:0] state, state_nxt;
    reg [1:0] write_card_state_nxt;
    reg [3:0] write_card_address_nxt;
    reg start_butt_en_nxt, compute_colors_en_nxt, update_cards_en_nxt, wait_for_click_en_nxt, write_card_en_nxt, summary_ctr, summary_ctr_nxt,
        stopwatch_en_nxt, stopwatch_disable_nxt, end_screen_en_nxt;
    reg [24:0] temp_wait_ctr, temp_wait_ctr_nxt;
    
    reg [3:0] card_address_reg [1:0];
    reg [3:0] card_address_reg_nxt [1:0];
    
    reg [11:0] card_color_reg [1:0];
    reg [11:0] card_color_reg_nxt [1:0];
    
    reg [2:0] cards_left, cards_left_nxt;
    
    localparam
    VALUE_EQUAL_500MS = 32_500_000,
    VALUE_EQUAL_200MS = 13_000_000;
    
    
    localparam
    MAIN_MENU               = 0,
    COMPUTE_COLORS          = 1,
    UPDATE_CARDS_1          = 2,
    WAIT_FOR_CLICK_1        = 3,
    DISCOVER_FIRST_CARD     = 4,
    UPDATE_CARDS_2          = 5,
    WAIT_FOR_CLICK_2        = 6,
    DISCOVER_SECOND_CARD    = 7,
    UPDATE_CARDS_3          = 8,
    CALCULATE_CARDS_LEFT    = 9,
    COVER_CARDS_AGAIN       = 10,
    DEACTIVATE_CARDS        = 11,
    END_SCREEN              = 12,
    TEMP_WAIT1              = 13,
    TEMP_WAIT2              = 14,
    TEMP_WAIT3              = 15,
    TEMP_WAIT4              = 16;
    
    
    always @(posedge clk) begin
        if(rst) begin
            state <= MAIN_MENU;
            start_butt_en <= 0;
            compute_colors_en <= 0;
            stopwatch_en <= 0;
            stopwatch_disable <= 0;
            update_cards_en <= 0;
            wait_for_click_en <= 0;
            write_card_en <= 0;
            end_screen_en <= 0;
            write_card_state <= 2'b00;
            write_card_address <= 4'h0;
            temp_wait_ctr <= 0;
            summary_ctr <= 0;
            card_address_reg[0] <= 4'h0;
            card_address_reg[1] <= 4'h0;
            card_color_reg[0] <= 12'h0_0_0;
            card_color_reg[1] <= 12'h0_0_0;
            cards_left <= 6;
            end_screen_en <= 1'b0;
        end
        else begin
            state <= state_nxt;
            start_butt_en <= start_butt_en_nxt;
            compute_colors_en <= compute_colors_en_nxt;
            stopwatch_en <= stopwatch_en_nxt;
            stopwatch_disable <= stopwatch_disable_nxt;
            update_cards_en <= update_cards_en_nxt;
            wait_for_click_en <= wait_for_click_en_nxt;
            write_card_en <= write_card_en_nxt;
            end_screen_en <= end_screen_en_nxt;
            write_card_state <= write_card_state_nxt;
            write_card_address <= write_card_address_nxt;
            temp_wait_ctr <= temp_wait_ctr_nxt;
            summary_ctr <= summary_ctr_nxt;
            card_address_reg[0] <= card_address_reg_nxt[0];
            card_address_reg[1] <= card_address_reg_nxt[1];
            card_color_reg[0] <= card_color_reg_nxt[0];
            card_color_reg[1] <= card_color_reg_nxt[1];
            cards_left <= cards_left_nxt;
            end_screen_en <= end_screen_en_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        start_butt_en_nxt = 0;
        end_screen_en_nxt = 1'b0;
        compute_colors_en_nxt = 0;
        stopwatch_en_nxt = 0;
        stopwatch_disable_nxt = 0;
        update_cards_en_nxt = 0;
        wait_for_click_en_nxt = 0;
        write_card_en_nxt = 0;
        end_screen_en_nxt = 0;
        write_card_state_nxt = 2'b00;
        write_card_address_nxt = 4'h0;
        temp_wait_ctr_nxt = 0;
        summary_ctr_nxt = 0;
        card_address_reg_nxt[0] = card_address_reg[0];
        card_address_reg_nxt[1] = card_address_reg[1];
        card_color_reg_nxt[0] = card_color_reg[0];
        card_color_reg_nxt[1] = card_color_reg[1];
        cards_left_nxt = cards_left;
        
        case(state)
            MAIN_MENU: begin
                state_nxt = start_butt_pressed ? COMPUTE_COLORS : state;
                start_butt_en_nxt = 1;
            end
            
            COMPUTE_COLORS: begin
                cards_left_nxt = 6;
                state_nxt = compute_done ? UPDATE_CARDS_1 : state;
                compute_colors_en_nxt = 1;
                stopwatch_en_nxt = 1;
            end
            
            UPDATE_CARDS_1: begin
                state_nxt = (cards_left == 0) ? END_SCREEN : TEMP_WAIT1;              // TEMP_WAIT only IRL
//                state_nxt = WAIT_FOR_CLICK_1;                                         // For simulation ONLY

                update_cards_en_nxt = 1;
                /*card_address_reg_nxt[0] = 4'h0;
                card_address_reg_nxt[1] = 4'h0;
                card_color_reg_nxt[0] = 12'h0_0_0;
                card_color_reg_nxt[1] = 12'h0_0_0;*/
            end
            
            TEMP_WAIT1: begin
                state_nxt = (temp_wait_ctr == VALUE_EQUAL_200MS) ? WAIT_FOR_CLICK_1 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_1: begin
                state_nxt = card_pressed ? DISCOVER_FIRST_CARD : state;
                wait_for_click_en_nxt = 1;
            end
            
            DISCOVER_FIRST_CARD: begin
                state_nxt = UPDATE_CARDS_2;
                write_card_en_nxt = 1;
                write_card_state_nxt = 2'b11;
                write_card_address_nxt = card_clicked_address;
                card_address_reg_nxt[0] = card_clicked_address;
                card_color_reg_nxt[0] = card_clicked_color;
            end
            
            UPDATE_CARDS_2: begin
                state_nxt = TEMP_WAIT2;               // TEMP_WAIT only IRL
//                state_nxt = WAIT_FOR_CLICK_2;       // For simulation ONLY
                update_cards_en_nxt = 1;
            end
            
            TEMP_WAIT2: begin
                state_nxt = (temp_wait_ctr == VALUE_EQUAL_200MS) ? WAIT_FOR_CLICK_2 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_2: begin
                state_nxt = card_pressed ? DISCOVER_SECOND_CARD : WAIT_FOR_CLICK_2;
                wait_for_click_en_nxt = 1;
            end
            
            DISCOVER_SECOND_CARD: begin
                state_nxt = UPDATE_CARDS_3;
                write_card_en_nxt = 1;
                write_card_state_nxt = 2'b11;
                write_card_address_nxt = card_clicked_address;
                card_address_reg_nxt[1] = card_clicked_address;
                card_color_reg_nxt[1] = card_clicked_color;
            end
            
            UPDATE_CARDS_3: begin
                state_nxt = CALCULATE_CARDS_LEFT;
                update_cards_en_nxt = 1;
            end
            
            CALCULATE_CARDS_LEFT: begin
                state_nxt = TEMP_WAIT3;
                if(card_color_reg[0] == card_color_reg[1]) begin
                    cards_left_nxt = cards_left - 1;
                end
                else begin
                    cards_left_nxt = cards_left;
                end
            end
            
            TEMP_WAIT3: begin
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
                if(card_color_reg[0] == card_color_reg[1]) begin
//                    state_nxt = (temp_wait_ctr == 10) ? DEACTIVATE_CARDS : state;  // For simulation ONLY
                    state_nxt = (temp_wait_ctr == VALUE_EQUAL_500MS) ? DEACTIVATE_CARDS : state;
                end
                else begin
//                    state_nxt = (temp_wait_ctr == 10) ? COVER_CARDS_AGAIN : state;  // For simulation ONLY
                    state_nxt = (temp_wait_ctr == VALUE_EQUAL_500MS) ? COVER_CARDS_AGAIN : state;
                end
            end
            
            COVER_CARDS_AGAIN: begin
                state_nxt = (summary_ctr) ? UPDATE_CARDS_1 : state;
                write_card_en_nxt = 1;
                write_card_state_nxt = 2'b01;
                write_card_address_nxt = summary_ctr ? card_address_reg[1] : card_address_reg[0];
                summary_ctr_nxt = 1;
            end
            
            DEACTIVATE_CARDS: begin
                state_nxt = (summary_ctr) ? UPDATE_CARDS_1 : state;
                write_card_en_nxt = 1;                            
                write_card_state_nxt = 2'b10;
                write_card_address_nxt = summary_ctr ? card_address_reg[1] : card_address_reg[0];                     
                summary_ctr_nxt = 1;
            end
            
            END_SCREEN: begin
                state_nxt = state;
                stopwatch_disable_nxt = 1;
                end_screen_en_nxt = 1;
            end
            default: begin
            end
        endcase
    end
endmodule
