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
    input wire [1:0]    card_test_state,
    
    output reg [3:0]    card_clicked_address,
    output reg [3:0]    card_to_test_address,
    output reg          event_occurred
    );
    
    localparam
    NUM_CARDS_X = 4,
    NUM_CARDS_Y = 3,
    NUM_CARDS = NUM_CARDS_X*NUM_CARDS_Y;
    
    localparam
        WAIT_FOR_EVENT = 2'b00,
        CHECK_IF_CARD_ACTIVE = 2'b01,
        GENERATE_EVENT = 2'b10;
    
    wire [11:0] event_occurred_internal;
    reg enable_internal, enable_internal_nxt, event_occurred_nxt;
    reg [3:0] card_clicked_address_nxt, card_to_test_address_nxt;
    reg [1:0] state, state_nxt;

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
            .enable(enable_internal),
            .kind_of_event(kind_of_event),
            .mouse_xpos(mouse_xpos),
            .mouse_ypos(mouse_ypos),
            .event_occurred(event_occurred_internal[i])
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
            .enable(enable_internal),
            .kind_of_event(kind_of_event),
            .mouse_xpos(mouse_xpos),
            .mouse_ypos(mouse_ypos),
            .event_occurred(event_occurred_internal[y])
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
            .enable(enable_internal),
            .kind_of_event(kind_of_event),
            .mouse_xpos(mouse_xpos),
            .mouse_ypos(mouse_ypos),
            .event_occurred(event_occurred_internal[z])
        );
    end
    endgenerate
   
    always @(posedge clk) begin
        if(rst) begin
            state <= WAIT_FOR_EVENT;
            enable_internal <= 0;
            card_clicked_address <= 4'h0;
            card_to_test_address <= 4'h0;
            event_occurred <= 0;
        end
        else begin
            state <= state_nxt;
            enable_internal <= enable_internal_nxt;
            card_clicked_address <= card_clicked_address_nxt;
            card_to_test_address <= card_to_test_address_nxt;
            event_occurred <= event_occurred_nxt;
        end
    end
    
    always @* begin
        state_nxt = state;
        enable_internal_nxt = 0;
        event_occurred_nxt = 0;
        card_clicked_address_nxt = card_clicked_address;
        
        if(enable) begin
            case(state)
                WAIT_FOR_EVENT: begin
                    enable_internal_nxt = 1;
                    state_nxt = event_occurred_internal ? CHECK_IF_CARD_ACTIVE : state;
                end
                CHECK_IF_CARD_ACTIVE: begin
                    state_nxt = card_test_state[0] == 0 ? WAIT_FOR_EVENT :
                                card_test_state[1] == 1 ? WAIT_FOR_EVENT : GENERATE_EVENT;
                end
                GENERATE_EVENT: begin
                    event_occurred_nxt = 1;
                    card_clicked_address_nxt = card_to_test_address;
                    state_nxt = WAIT_FOR_EVENT;
                end
            endcase
        end
    end
    
    always @* begin
        case(event_occurred_internal)
            1:    card_to_test_address_nxt = 4'h1;
            2:    card_to_test_address_nxt = 4'h2;
            4:    card_to_test_address_nxt = 4'h3;
            8:    card_to_test_address_nxt = 4'h4;
            16:   card_to_test_address_nxt = 4'h5;
            32:   card_to_test_address_nxt = 4'h6;
            64:   card_to_test_address_nxt = 4'h7;
            128:  card_to_test_address_nxt = 4'h8;
            256:  card_to_test_address_nxt = 4'h9;
            512:  card_to_test_address_nxt = 4'ha;
            1024: card_to_test_address_nxt = 4'hb;
            2048: card_to_test_address_nxt = 4'hc;
            default: card_to_test_address_nxt = card_to_test_address;
        endcase
    end
endmodule
