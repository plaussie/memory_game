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
    input wire computing_colors_finished,
    
    output reg draw_start_button,
    output reg draw_cards,
    output reg compute_colors,
    input wire rst    
    );
    
    reg [1:0] state, state_nxt;
    reg draw_start_button_nxt, draw_cards_nxt, compute_colors_nxt;
    
    localparam
    SHOWING_MAIN_MENU = 2'b00,
    COMPUTING_COLORS = 2'b01,
    DISPLAYING_CARDS = 2'b10,
    WAITING_FOR_CLICK = 2'b11;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= SHOWING_MAIN_MENU;
            draw_start_button <= 0;
            draw_cards <= 0;
            compute_colors <= 0;
        end
        else begin
            state <= state_nxt;
            draw_start_button <= draw_start_button_nxt;
            draw_cards <= draw_cards_nxt;
            compute_colors <= compute_colors_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        draw_cards_nxt = 0;
        draw_start_button_nxt = 0;
        compute_colors_nxt = 0;
        
        case(state)
            SHOWING_MAIN_MENU: begin
                state_nxt = start_button_pressed ? COMPUTING_COLORS : SHOWING_MAIN_MENU;
                draw_start_button_nxt = 1;
            end
            
            COMPUTING_COLORS: begin
                state_nxt = computing_colors_finished ? DISPLAYING_CARDS : COMPUTING_COLORS;
                compute_colors_nxt = 1;
            end
            
            DISPLAYING_CARDS: begin
                state_nxt = WAITING_FOR_CLICK;
                draw_cards_nxt = 1;
            end
            
            WAITING_FOR_CLICK: begin
                state_nxt = state;
            end
            
            default: begin
            end
        endcase
    end
endmodule
