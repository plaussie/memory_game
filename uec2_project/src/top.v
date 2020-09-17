`timescale 1 ns / 1 ps
/////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 07.07.2020 12:00:41
// Module Name: top
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.10 - File Copied from UEC2 Lab
// Revision 0.30 - Added VGA bus
// Revision 0.31 - Fixed Timing Critical Error
// Revision 0.32 - Deleted mouse delay
// Revision 0.33 - Added genvar in drawing cards
// Revision 0.40 - Added regfile with its control unit
// Revision 0.50 - 2 cards can be discovered, then game stops
// Revision 0.80 - Playable version
// Revision 0.81 - Added endscreen
// Revision 0.82 - Added stopwatch
// Revision 0.83 - Added options screen
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_cards_macros.vh"
`include "_game_params.vh"
`include "_vga_macros.vh"

module top (
    inout  wire         ps2_clk,
    inout  wire         ps2_data,
    input  wire         clk,
    input  wire         btnC,
    
    output wire         vs,
    output wire         hs,
    output wire [3:0]   r,
    output wire [3:0]   g,
    output wire [3:0]   b
);
    
    wire clk65MHz;
    wire start_butt_pressed, difficulty_butts_pressed, back_butt_pressed, menu_butt_pressed, card_pressed;
    wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards;
    wire [`CARD_ADDRESS_SIZE-1:0] card_to_test_address, card_clicked_address;
    
    wire start_butt_en, options_screen_en, start_game_en, update_cards_en, wait_for_click_en, write_card_en,
         end_screen_en, update_cards_en_delayed_2tact, minute_passed;
    wire [`CARD_DATA_SIZE-1:0] regfile_r_data;
    wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position;
    wire [12:0] game_time;
    wire [7:0] discovered_pairs_ctr;
    
    wire [11:0] xpos;
    wire [11:0] ypos;
    wire left;
    //unused
    wire [3:0] zpos;
    wire middle;
    wire right;
    wire new_event;

    //***Clock Generator***//
    clock_generator MG_clock(
        .clk65MHz                       (clk65MHz                       ),
        .clk                            (clk                            )
    );
    
    //***Reset***//    
    wire rst;
    assign rst = btnC;
    
    //***Core***//
    core MG_core(
        .clk                            (clk65MHz                       ),
        .rst                            (rst                            ),
        .card_to_test_address           (card_to_test_address           ),
        .card_clicked_address           (card_clicked_address           ),
        .num_of_cards                   (num_of_cards                   ),
        .start_butt_pressed             (start_butt_pressed             ),
        .difficulty_butts_pressed       (difficulty_butts_pressed       ),
        .back_butt_pressed              (back_butt_pressed              ),
        .menu_butt_pressed              (menu_butt_pressed              ),
        .card_pressed                   (card_pressed                   ),
        .regfile_r_data                 (regfile_r_data                 ),
        .start_butt_en                  (start_butt_en                  ),
        .options_screen_en              (options_screen_en              ),
        .wait_for_click_en              (wait_for_click_en              ),
        .end_screen_en                  (end_screen_en                  ),
        .yx_card_position               (yx_card_position               ),
        .update_cards_en_delayed_2tact  (update_cards_en_delayed_2tact  ),
        .minute_passed                  (minute_passed                  ),
        .game_time                      (game_time                      ),
        .discovered_pairs_ctr           (discovered_pairs_ctr           )
    );
        
    //***VGA Controller***//    
    vgaCtl MG_vgaCtl(
        .clk                            (clk65MHz                       ),
        .rst                            (rst                            ),
        .left                           (left                           ),
        .xpos                           (xpos                           ),
        .ypos                           (ypos                           ),
        .regfile_r_data                 (regfile_r_data                 ),
        .start_butt_en                  (start_butt_en                  ),
        .options_screen_en              (options_screen_en              ),
        .wait_for_click_en              (wait_for_click_en              ),
        .end_screen_en                  (end_screen_en                  ),
        .update_cards_en_delayed_2tact  (update_cards_en_delayed_2tact  ),
        .minute_passed                  (minute_passed                  ),
        .yx_card_position               (yx_card_position               ),
        .game_time                      (game_time                      ),
        .discovered_pairs_ctr           (discovered_pairs_ctr           ),
        .start_butt_pressed             (start_butt_pressed             ),
        .difficulty_butts_pressed       (difficulty_butts_pressed       ),
        .back_butt_pressed              (back_butt_pressed              ),
        .menu_butt_pressed              (menu_butt_pressed              ),
        .card_pressed                   (card_pressed                   ),
        .num_of_cards                   (num_of_cards                   ),
        .card_to_test_address           (card_to_test_address           ),
        .card_clicked_address           (card_clicked_address           ),
        .vga_out                        ({vs, hs, r, g, b}              )
    );
    
    //***Mouse Controller with PS2 Interface***//
    MouseCtl MG_MouseCtl(
        .clk                            (clk65MHz                       ),
        .ps2_clk                        (ps2_clk                        ),
        .ps2_data                       (ps2_data                       ),
        .xpos                           (xpos                           ),
        .ypos                           (ypos                           ),
        .zpos                           (zpos                           ),
        .left                           (left                           ),
        .middle                         (middle                         ),
        .right                          (right                          ),
        .new_event                      (new_event                      ),
        .rst                            (rst                            ),
        .value                          (12'b0                          ),
        .setx                           (1'b0                           ),
        .sety                           (1'b0                           ),
        .setmax_x                       (1'b0                           ),
        .setmax_y                       (1'b0                           )
    );

endmodule
