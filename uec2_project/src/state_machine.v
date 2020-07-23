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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module state_machine(
    input wire clk,
    input wire start_button_pressed,
    
    output reg draw_start_button,
    output reg draw_cards, 
    input wire rst    
    );
    
    reg [1:0] state, state_nxt;
    reg draw_start_button_nxt, draw_cards_nxt;
    
    localparam
    MAIN_MENU = 2'b00,
    DRAW_CARDS = 2'b01;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= MAIN_MENU;
            draw_start_button <= 0;
            draw_cards <= 0;
        end
        else begin
            state <= state_nxt;
            draw_start_button <= draw_start_button_nxt;
            draw_cards <= draw_cards_nxt;
        end
    end
    
    always @* begin
        case(state)
            MAIN_MENU: begin
                state_nxt = start_button_pressed ? DRAW_CARDS : MAIN_MENU;
                draw_start_button_nxt = 1;
                draw_cards_nxt = 0;
            end
            
            DRAW_CARDS: begin
                state_nxt = state;
                draw_start_button_nxt = 0;
                draw_cards_nxt = 1;
            end
            
            default: begin
                state_nxt = state;
                draw_start_button_nxt = 0;
                draw_cards_nxt = 0;
            end
        endcase
    end
endmodule
