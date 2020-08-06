`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 06.08.2020 16:06:23
// Module Name: card_press_checker
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


module card_press_checker(
    input wire          clk,
    input wire          rst,    
    input wire          enable,
    input wire          kind_of_event,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [1:0]    read_card_state,
    
    output reg [3:0]   card_clicked_address,
    output reg         event_occured
    );
    
    localparam
    NUM_CARDS_X = 4,
    NUM_CARDS_Y = 3,
    NUM_CARDS = NUM_CARDS_X*NUM_CARDS_Y;
    
    reg [3:0] card_clicked_address_nxt;
    reg event_occured_nxt;
    wire [11:0] event_occured_internal ;
    reg [11:0] event_occured_internal_reg, event_occured_internal_reg_nxt;
    
    genvar i;
        generate
        for(i = 0; i < NUM_CARDS_X; i = i+1) begin
            event_checker
            #(
                .X_POS(258*i + 50),
                .Y_POS(50),
                .WIDTH(150),
                .HEIGHT(200)
            )
            MG_check_if_left_clicked_card (
                .clk(clk),
                .rst(rst),
                .enable(enable),
                .kind_of_event(kind_of_event),
                .mouse_xpos(mouse_xpos),
                .mouse_ypos(mouse_ypos),
                .event_occured(event_occured_internal[i])
            );
        end
        endgenerate
        
        genvar y;
        generate
        for(y = NUM_CARDS_X; y < 2*NUM_CARDS_X; y = y+1) begin
            event_checker
            #(
                .X_POS(258*(y-NUM_CARDS_X) + 50),
                .Y_POS(234 + 50),
                .WIDTH(150),
                .HEIGHT(200)
            )
            MG_check_if_left_clicked_card (
                .clk(clk),
                .rst(rst),
                .enable(enable),
                .kind_of_event(kind_of_event),
                .mouse_xpos(mouse_xpos),
                .mouse_ypos(mouse_ypos),
                .event_occured(event_occured_internal[y])
            );
        end
        endgenerate
        
        genvar z;
        generate
        for(z = 2*NUM_CARDS_X; z < 3*NUM_CARDS_X; z = z+1) begin
            event_checker
            #(
                .X_POS(258*(z-2*NUM_CARDS_X) + 50),
                .Y_POS(468 + 50),
                .WIDTH(150),
                .HEIGHT(200)
            )
            MG_check_if_left_clicked_card (
                .clk(clk),
                .rst(rst),
                .enable(enable),
                .kind_of_event(kind_of_event),
                .mouse_xpos(mouse_xpos),
                .mouse_ypos(mouse_ypos),
                .event_occured(event_occured_internal[z])
            );
        end
        endgenerate
    
    event_checker
    #(
        .X_POS(50),
        .Y_POS(50),
        .WIDTH(150),
        .HEIGHT(200)    
    )
    MG_check_if_left_clicked_first_card (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .kind_of_event(kind_of_event),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .event_occured(event_occured_internal[0])
    );

    always @(posedge clk) begin
        if(rst) begin
            card_clicked_address <= 4'h0;
            event_occured <= 0;
            event_occured_internal_reg <= 0;
        end
        else begin
            card_clicked_address <= card_clicked_address_nxt;
            event_occured <= event_occured_nxt;
            event_occured_internal_reg <= event_occured_internal_reg_nxt;
        end
    end
    
    always @* begin
        if(enable) begin
            case(event_occured_internal_reg)
                1: card_clicked_address_nxt = 4'h1;
                2: card_clicked_address_nxt = 4'h2;
                4: card_clicked_address_nxt = 4'h3;
                8: card_clicked_address_nxt = 4'h4;
                16: card_clicked_address_nxt = 4'h5;
                32: card_clicked_address_nxt = 4'h6;
                64: card_clicked_address_nxt = 4'h7;
                128: card_clicked_address_nxt = 4'h8;
                256: card_clicked_address_nxt = 4'h9;
                512: card_clicked_address_nxt = 4'ha;
                1024: card_clicked_address_nxt = 4'hb;
                2048: card_clicked_address_nxt = 4'hc;
                default: card_clicked_address_nxt = 4'h0;
            endcase
            event_occured_internal_reg_nxt = event_occured_internal;
            event_occured_nxt = (event_occured_internal_reg == 0) ? 0 : 1;
        end
        else begin
            event_occured_internal_reg_nxt = 0;
            card_clicked_address_nxt = 4'h0;
            event_occured_nxt = 0;
        end
    end
endmodule
