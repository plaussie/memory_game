`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 28.08.2020 19:50:40
// Module Name: cardsCtl
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

`include "_vga_macros.vh"
`include "_cards_macros.vh"

module cardsCtl(
    // General
    input wire clk,
    input wire rst,
    // Display
    input wire regfile_sync,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position,
    input wire [`CARD_DATA_SIZE-1:0] regfile_in,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    // Card press checker
    input wire card_press_checker_en,
    input wire mouse_left,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [`CARD_STATE_SIZE-1:0]    card_test_state,
    
    // Display
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    // Card press checker
    output reg [`CARD_ADDRESS_SIZE-1:0]    card_to_test_address,
    output reg [`CARD_ADDRESS_SIZE-1:0]    card_clicked_address,
    output reg          event_occurred
    );
    
    localparam
        WAIT_FOR_EVENT = 2'b00,
        CHECK_IF_CARD_ACTIVE = 2'b01,
        GENERATE_EVENT = 2'b10;
        
    wire [`CARD_MAX_NUM:0] event_occurred_internal;
    reg enable_internal, enable_internal_nxt, event_occurred_nxt;
    reg [`CARD_ADDRESS_SIZE-1:0] card_clicked_address_nxt, card_to_test_address_nxt;
    reg [1:0] state, state_nxt;
    
    wire [8:0] height;
    wire [7:0] width;
    
    assign height = (num_of_cards == `CARD_NUM_EASY) ? 9'd300 :
                    (num_of_cards == `CARD_NUM_NORMAL) ? 9'd200 :
                    (num_of_cards == `CARD_NUM_HARD) ? 9'd150 : 9'd0;
    assign width  = (num_of_cards == `CARD_NUM_EASY) ? 8'd200 :
                    (num_of_cards == `CARD_NUM_NORMAL) ? 8'd150 :
                    (num_of_cards == `CARD_NUM_HARD) ? 8'd100 : 8'd0;
    
    wire [`VGA_BUS_SIZE-1:0] vga_internal_bus [`CARD_MAX_NUM:0];
    assign vga_internal_bus[0] = vga_in;
    assign vga_out = vga_internal_bus[`CARD_MAX_NUM];
    
    wire regfile_sync_bus1 [`CARD_MAX_NUM:0];
    assign regfile_sync_bus1[0] = regfile_sync;
    
    wire regfile_sync_bus2 [`CARD_MAX_NUM:0];
    assign regfile_sync_bus2[0] = regfile_sync;
    
    genvar i;
        generate
        for(i = 0; i < `CARD_MAX_NUM; i = i+1) begin
            draw_one_card u_card_1(
                .pclk(clk),
                .rst(rst),
                .regfile_in(regfile_in),
                .regfile_sync(regfile_sync_bus1[i]),
                .yx_position_in(yx_card_position),
                .height(height),
                .width(width),
                .regfile_sync_done(regfile_sync_bus1[i+1]),
                .vga_in(vga_internal_bus[i]),
                .vga_out(vga_internal_bus[i+1])
            );
            
            card_press_checker u_card_press_checker_1(
                .clk(clk),
                .rst(rst),
                .enable(enable_internal),
                .kind_of_event(mouse_left),
                .regfile_sync(regfile_sync_bus2[i]),
                .yx_position_in(yx_card_position),
                .height(height),
                .width(width),
                .mouse_xpos(mouse_xpos),
                .mouse_ypos(mouse_ypos),
                .regfile_sync_done(regfile_sync_bus2[i+1]),
                .event_occurred(event_occurred_internal[i])   
            );
        end
        endgenerate
    
    always @(posedge clk) begin
        if(rst) begin
            state <= WAIT_FOR_EVENT;
            enable_internal <= 0;
            card_clicked_address <= 0;
            card_to_test_address <= 0;
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
        
        if(card_press_checker_en) begin
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
            1:      card_to_test_address_nxt = 5'd1;
            2:      card_to_test_address_nxt = 5'd2;
            4:      card_to_test_address_nxt = 5'd3;
            8:      card_to_test_address_nxt = 5'd4;
            16:     card_to_test_address_nxt = 5'd5;
            32:     card_to_test_address_nxt = 5'd6;
            64:     card_to_test_address_nxt = 5'd7;
            128:    card_to_test_address_nxt = 5'd8;
            256:    card_to_test_address_nxt = 5'd9;
            512:    card_to_test_address_nxt = 5'd10;
            1024:   card_to_test_address_nxt = 5'd11;
            2048:   card_to_test_address_nxt = 5'd12;
            4098:   card_to_test_address_nxt = 5'd13;
            8192:   card_to_test_address_nxt = 5'd14;
            16384:  card_to_test_address_nxt = 5'd15;
            32768:  card_to_test_address_nxt = 5'd16;
            65536:  card_to_test_address_nxt = 5'd17;
            131072: card_to_test_address_nxt = 5'd18;
            default: card_to_test_address_nxt = card_to_test_address;
        endcase
    end
endmodule
