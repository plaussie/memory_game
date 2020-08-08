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
// For this moment, cards_to_compare is unused
//////////////////////////////////////////////////////////////////////////////////


module card_press_checker(
    input wire          clk,
    input wire          rst,    
    input wire          enable,
    input wire          kind_of_event,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output wire [3:0]   card_clicked_address,
    output wire [8:0]   cards_to_compare, // [8:5] second card address, [4:1] first card address, [0]go_to_compare
    output wire         event_occured
    );
    
    localparam
    NUM_CARDS_X = 4,
    NUM_CARDS_Y = 3,
    NUM_CARDS = NUM_CARDS_X*NUM_CARDS_Y;
    
    reg [3:0] card_address_reg [1:0];
    reg [3:0] card_address_reg_nxt [1:0];
    reg [3:0] temp_address;
    wire [11:0] event_occured_internal;
    
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

    always @(posedge clk) begin
        if(rst) begin
            card_address_reg[0] <= 4'h0;
            card_address_reg[1] <= 4'h0;
        end
        else begin
            card_address_reg[0] <= card_address_reg_nxt[0];
            card_address_reg[1] <= card_address_reg_nxt[1];
        end
    end
    
    always @* begin
        if(enable) begin 
            card_address_reg_nxt[0] = (card_address_reg[0] && card_address_reg[1]) ? 4'h0 : card_address_reg[0];
            card_address_reg_nxt[1] = (card_address_reg[0] && card_address_reg[1]) ? 4'h0 : card_address_reg[1];
            case(event_occured_internal)
                1:    temp_address = 4'h1;
                2:    temp_address = 4'h2;
                4:    temp_address = 4'h3;
                8:    temp_address = 4'h4;
                16:   temp_address = 4'h5;
                32:   temp_address = 4'h6;
                64:   temp_address = 4'h7;
                128:  temp_address = 4'h8;
                256:  temp_address = 4'h9;
                512:  temp_address = 4'ha;
                1024: temp_address = 4'hb;
                2048: temp_address = 4'hc;
                default: temp_address = 4'h0;
            endcase
            if(card_address_reg[0] == 4'h0) begin
                card_address_reg_nxt[0] = temp_address;
                card_address_reg_nxt[1] = 4'h0;
            end
            else if(card_address_reg[1] == 4'h0 && card_address_reg[0] != temp_address) begin
                card_address_reg_nxt[0] = card_address_reg[0];
                card_address_reg_nxt[1] = temp_address;
            end
            else begin
                //This situation should never happens, but was left for safety reasons
                card_address_reg_nxt[0] = temp_address;
                card_address_reg_nxt[1] = 4'h0;
            end
        end
        else begin
            card_address_reg_nxt[0] = card_address_reg[0];
            card_address_reg_nxt[1] = card_address_reg[1];
            temp_address = 4'h0;
        end
    end
    
    assign event_occured        = event_occured_internal && (card_address_reg[0] != temp_address) ? 1 : 0;
    assign card_clicked_address = card_address_reg[1] ? card_address_reg[1] :
                                  card_address_reg[0] ? card_address_reg[0] : 4'h0;
                                  
    assign cards_to_compare     = (card_address_reg[0] && card_address_reg[1]) ? {card_address_reg[1], card_address_reg[0], 1'b1} : 0;
endmodule
