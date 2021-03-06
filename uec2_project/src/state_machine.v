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
// Revision 0.10 - DONE -> Every Wait For Click & Temp Wait
// Revision 0.11 - DONE -> Discover First Card & Update Cards 2 & Discover Second Card & Update Cards 3
// Revision 0.12 - DONE -> Calculate Cards Left & Cover Cards Again & Deactivate Cards
// Revision 0.13 - DONE -> End Screen & Options Screen
// Additional Comments:
// TODO - highscores and computing score
//////////////////////////////////////////////////////////////////////////////////

`include "_cards_macros.vh"


module state_machine(
    input wire clk,
    input wire rst,
    
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire start_butt_pressed,
    input wire difficulty_butts_pressed,
    input wire back_butt_pressed,
    input wire compute_done,
    input wire card_pressed,
    input wire time_passed,
    input wire [`CARD_ADDRESS_SIZE-1:0] card_clicked_address,
    input wire [`CARD_COLOR_SIZE-1:0] card_clicked_color,
    
    output reg start_butt_en,
    output reg options_screen_en,
    output reg start_game_en,
    output reg update_cards_en,
    output reg wait_for_click_en,
    output reg write_card_en,
    output reg end_screen_en,
    output reg [7:0] discovered_pairs_ctr,
    output reg [`CARD_STATE_SIZE-1:0] write_card_state,
    output reg [`CARD_ADDRESS_SIZE-1:0] write_card_address
       
    );
    
    reg [4:0] state, state_nxt;
    reg [`CARD_ADDRESS_SIZE:0] deactivate_cards_ctr, deactivate_cards_ctr_nxt;
    reg [`CARD_STATE_SIZE-1:0] write_card_state_nxt;
    reg [`CARD_ADDRESS_SIZE-1:0] write_card_address_nxt;
    reg start_butt_en_nxt, options_screen_en_nxt, start_game_en_nxt, update_cards_en_nxt, wait_for_click_en_nxt,
        write_card_en_nxt, summary_ctr, summary_ctr_nxt, end_screen_en_nxt;
    reg [24:0] temp_wait_ctr, temp_wait_ctr_nxt;
    reg [7:0] discovered_pairs_ctr_nxt;
    
    reg [`CARD_ADDRESS_SIZE-1:0] card_address_reg [1:0];
    reg [`CARD_ADDRESS_SIZE-1:0] card_address_reg_nxt [1:0];
    
    reg [`CARD_COLOR_SIZE-1:0] card_color_reg [1:0];
    reg [`CARD_COLOR_SIZE-1:0] card_color_reg_nxt [1:0];
    
    reg [`CARD_MAX_NUM_SIZE-1:0] cards_left, cards_left_nxt;
    
    localparam
    VALUE_EQUAL_400MS = 26_000_000,
    VALUE_EQUAL_200MS = 13_000_000;
    
    //State machine states
    localparam
    MAIN_MENU               = 0,
    CHOOSE_LEVEL            = 17,
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
    DEACTIVATE_ALL_CARDS    = 18,
    UPDATE_CARDS_4          = 19,    
    END_SCREEN              = 12,
    TIMER_1                 = 13,
    TIMER_2                 = 14,
    TIMER_3                 = 15,
    TIMER_4                 = 16;
    
    
    always @(posedge clk) begin
        if(rst) begin
            state <= MAIN_MENU;
            start_butt_en <= 0;
            options_screen_en <= 0;
            start_game_en <= 0;
            update_cards_en <= 0;
            wait_for_click_en <= 0;
            write_card_en <= 0;
            end_screen_en <= 0;
            write_card_state <= 0;
            write_card_address <= 0;
            temp_wait_ctr <= 0;
            summary_ctr <= 0;
            card_address_reg[0] <= 0;
            card_address_reg[1] <= 0;
            card_color_reg[0] <= 12'h0_0_0;
            card_color_reg[1] <= 12'h0_0_0;
            cards_left <= num_of_cards;
            deactivate_cards_ctr <= 1;
            discovered_pairs_ctr <= 0;
        end
        else begin
            state <= state_nxt;
            start_butt_en <= start_butt_en_nxt;
            options_screen_en <= options_screen_en_nxt;
            start_game_en <= start_game_en_nxt;
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
            deactivate_cards_ctr <= deactivate_cards_ctr_nxt;
            discovered_pairs_ctr <= discovered_pairs_ctr_nxt;
        end
    end
    
    always @* begin
        state_nxt = MAIN_MENU;
        start_butt_en_nxt = 0;
        options_screen_en_nxt = 0;
        end_screen_en_nxt = 0;
        start_game_en_nxt = 0;
        update_cards_en_nxt = 0;
        wait_for_click_en_nxt = 0;
        write_card_en_nxt = 0;
        end_screen_en_nxt = 0;
        write_card_state_nxt = 2'b00;
        write_card_address_nxt = 5'd0;
        temp_wait_ctr_nxt = 0;
        summary_ctr_nxt = 0;
        deactivate_cards_ctr_nxt = 1;
        discovered_pairs_ctr_nxt = discovered_pairs_ctr;
        card_address_reg_nxt[0] = card_address_reg[0];
        card_address_reg_nxt[1] = card_address_reg[1];
        card_color_reg_nxt[0] = card_color_reg[0];
        card_color_reg_nxt[1] = card_color_reg[1];
        cards_left_nxt = cards_left;
        
        case(state)
            MAIN_MENU: begin
                state_nxt = start_butt_pressed ? TIMER_4 : state;                    // TIMER_ only IRL
//                state_nxt = start_butt_pressed ? CHOOSE_LEVEL : state;                // For simulation ONLY
                start_butt_en_nxt = 1;
            end
            
            TIMER_4: begin
                state_nxt = (temp_wait_ctr == VALUE_EQUAL_200MS) ? CHOOSE_LEVEL : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            CHOOSE_LEVEL: begin
                state_nxt = difficulty_butts_pressed ? COMPUTE_COLORS : 
                            back_butt_pressed ? MAIN_MENU : state;
                options_screen_en_nxt = 1;
            end
            
            COMPUTE_COLORS: begin
                cards_left_nxt = num_of_cards;
                state_nxt = compute_done ? UPDATE_CARDS_1 : state;
                start_game_en_nxt = 1;
                discovered_pairs_ctr_nxt = 0;
            end
            
            UPDATE_CARDS_1: begin
                state_nxt = (cards_left == 0) ? END_SCREEN : TIMER_1;              // TIMER_ only IRL
//                state_nxt = WAIT_FOR_CLICK_1;                                         // For simulation ONLY

                update_cards_en_nxt = 1;
            end
            
            TIMER_1: begin
                state_nxt = (temp_wait_ctr == VALUE_EQUAL_200MS) ? WAIT_FOR_CLICK_1 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_1: begin
                state_nxt = time_passed ? DEACTIVATE_ALL_CARDS : (card_pressed ? DISCOVER_FIRST_CARD : state);
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
                state_nxt = TIMER_2;                                             // TIMER_ only IRL
//                state_nxt = WAIT_FOR_CLICK_2;                                       // For simulation ONLY
                update_cards_en_nxt = 1;
            end
            
            TIMER_2: begin
                state_nxt = (temp_wait_ctr == VALUE_EQUAL_200MS) ? WAIT_FOR_CLICK_2 : state;
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
            end
            
            WAIT_FOR_CLICK_2: begin
                state_nxt = time_passed ? DEACTIVATE_ALL_CARDS : (card_pressed ? DISCOVER_SECOND_CARD : WAIT_FOR_CLICK_2);
                wait_for_click_en_nxt = 1;
            end
            
            DISCOVER_SECOND_CARD: begin
                state_nxt = UPDATE_CARDS_3;
                discovered_pairs_ctr_nxt = (255 == discovered_pairs_ctr) ? 255 : discovered_pairs_ctr + 1;
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
                state_nxt = TIMER_3;
                if(card_color_reg[0] == card_color_reg[1]) begin
                    cards_left_nxt = cards_left - 2;
                end
                else begin
                    cards_left_nxt = cards_left;
                end
            end
            
            TIMER_3: begin
                temp_wait_ctr_nxt = temp_wait_ctr + 1;
                if(card_color_reg[0] == card_color_reg[1]) begin
//                    state_nxt = (temp_wait_ctr == 20) ? DEACTIVATE_CARDS : state;                 // For simulation ONLY
                    state_nxt = (temp_wait_ctr == VALUE_EQUAL_400MS) ? DEACTIVATE_CARDS : state;
                end
                else begin
//                    state_nxt = (temp_wait_ctr == 20) ? COVER_CARDS_AGAIN : state;                // For simulation ONLY
                    state_nxt = (temp_wait_ctr == VALUE_EQUAL_400MS) ? COVER_CARDS_AGAIN : state;
                end
            end
            
            COVER_CARDS_AGAIN: begin
                state_nxt = summary_ctr ? UPDATE_CARDS_1 : state;
                write_card_en_nxt = 1;
                write_card_state_nxt = 2'b01;
                write_card_address_nxt = summary_ctr ? card_address_reg[1] : card_address_reg[0];
                summary_ctr_nxt = 1;
            end
            
            DEACTIVATE_CARDS: begin
                state_nxt = summary_ctr ? UPDATE_CARDS_1 : state;
                write_card_en_nxt = 1;                            
                write_card_state_nxt = 2'b10;
                write_card_address_nxt = summary_ctr ? card_address_reg[1] : card_address_reg[0];                     
                summary_ctr_nxt = 1;
            end
            
            DEACTIVATE_ALL_CARDS: begin
                state_nxt = (num_of_cards == deactivate_cards_ctr) ? UPDATE_CARDS_4 : state;
                write_card_en_nxt = 1;                            
                write_card_state_nxt = 2'b10;
                write_card_address_nxt = deactivate_cards_ctr;
                deactivate_cards_ctr_nxt = deactivate_cards_ctr + 1;
            end
            
            UPDATE_CARDS_4: begin
                state_nxt = END_SCREEN;
                update_cards_en_nxt = 1;
            end
            
            END_SCREEN: begin
                state_nxt = back_butt_pressed ? MAIN_MENU : state;
                end_screen_en_nxt = 1;
            end
            default: begin
            end
        endcase
    end
endmodule
