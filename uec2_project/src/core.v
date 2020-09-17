`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 17.09.2020 11:25:10
// Module Name: core
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

module core(
    input wire clk,
    input wire rst,
    input wire [`CARD_ADDRESS_SIZE-1:0] card_to_test_address, card_clicked_address,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire start_butt_pressed, difficulty_butts_pressed, back_butt_pressed, menu_butt_pressed, card_pressed,
    
    output wire [`CARD_DATA_SIZE-1:0] regfile_r_data,
    output wire start_butt_en, options_screen_en, wait_for_click_en,
                end_screen_en, update_cards_en_delayed_2tact, minute_passed,
    output wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position,
    output wire [12:0] game_time,
    output wire [7:0] discovered_pairs_ctr
    );
    
    //***Signals***//
    
    wire compute_done, update_cards_en_delayed_tact, write_card_en, start_game_en, update_cards_en;
    wire [`CARD_DATA_SIZE-1:0] regfile_w_data, card_write_data;     
    wire [`CARD_ADDRESS_SIZE-1:0] write_card_address, card_write_address, regfile_w_address, regfile_r_address;
    wire [`CARD_STATE_SIZE-1:0] write_card_state;
    
    wire [1:0] regfile_w_enable;

    //***The Main State Machine***//

    state_machine MG_state_machine(
        .clk(clk),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .start_butt_pressed(start_butt_pressed),
        .difficulty_butts_pressed(difficulty_butts_pressed),
        .back_butt_pressed(back_butt_pressed | menu_butt_pressed),
        .compute_done(compute_done),
        .card_pressed(card_pressed),
        .time_passed(minute_passed),
        .card_clicked_address(card_clicked_address),
        .card_clicked_color(regfile_r_data[`CARD_DATA_SIZE-1:`CARD_STATE_SIZE]),
        .start_butt_en(start_butt_en),
        .options_screen_en(options_screen_en),
        .update_cards_en(update_cards_en),
        .discovered_pairs_ctr(discovered_pairs_ctr),
        .start_game_en(start_game_en),
        .wait_for_click_en(wait_for_click_en),
        .write_card_en(write_card_en),
        .end_screen_en(end_screen_en),
        .write_card_state(write_card_state),
        .write_card_address(write_card_address)
    );
    
    //***Stopwatch***//

    stopwatch MG_stopwatch(
        .clk(clk),
        .rst(rst),
        .start(start_game_en),
        .pause(1'b0),
        .stop(end_screen_en),
        .minute_passed(minute_passed),
        .seconds(game_time[12:7]),
        .hundredths_of_second(game_time[6:0])
        
    );
    
    //***Cards Colors Generator***//

    compute_colors MG_compute_colors(
        .clk(clk),
        .rst(rst),
        .enable(start_game_en),
        .num_of_cards(num_of_cards),
        .done(compute_done),
        .computed_data(card_write_data),
        .computed_address(card_write_address)
    );
    
    //***update_cards_en Delayer***//
    
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delay_update_cards_en_1(
        .clk(clk),
        .rst(rst),
        .din(update_cards_en),
        .dout(update_cards_en_delayed_tact)
    );
       
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delay_update_cards_en_2(
        .clk(clk),
        .rst(rst),
        .din(update_cards_en_delayed_tact),
        .dout(update_cards_en_delayed_2tact)
    );

    //***Cards Positions Generator***//
    
    cards_pos_gen MG_cards_positions(
        .clk(clk),
        .rst(rst),
        .read_all_positions(update_cards_en),
        .num_of_cards(num_of_cards),
        .yx_card_position(yx_card_position)
    );
    
    //***RegFile Controller***//
     
    regfileCtl MG_colors_regfileCtl(
        .clk(clk),
        .rst(rst),
        .num_of_cards(num_of_cards),
        .read_all_cards(update_cards_en_delayed_tact),
        .read_one_card(card_to_test_address),
        .write_data_1({card_write_data, card_write_address, start_game_en}),
        .write_data_2({write_card_state, write_card_address, write_card_en}),
        .regfile_w_enable(regfile_w_enable),
        .regfile_w_address(regfile_w_address),
        .regfile_w_data(regfile_w_data),
        .regfile_r_address(regfile_r_address)
    );    
    
    //***RegFile***//
    
    regfile MG_colors_regfile(
        .clk(clk),
        .w_enable(regfile_w_enable),
        .w_data(regfile_w_data),
        .w_address(regfile_w_address),
        .r_data(regfile_r_data),
        .r_address(regfile_r_address)
    );
endmodule
