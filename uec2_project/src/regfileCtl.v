`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 04.08.2020 15:14:21
// Module Name: regfileCtl
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.40 - Added regfile with its control unit
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// w_enable[0] = 1 write every bit; = 0 write disable
// w_enable[1] = 1 write [1:0] bits; = 0 write disable

`include "_cards_macros.vh"

`define REGFILE_WRITE_ALL_SIZE `CARD_DATA_SIZE+`CARD_ADDRESS_SIZE+1
`define REGFILE_WRITE_STATE_SIZE `CARD_STATE_SIZE+`CARD_ADDRESS_SIZE+1

module regfileCtl(
    input wire clk,
    input wire rst,
    input wire [`CARD_MAX_NUM_SIZE-1:0] num_of_cards,
    input wire read_all_cards,
    input wire [`CARD_ADDRESS_SIZE-1:0] read_one_card,
    input wire [`REGFILE_WRITE_ALL_SIZE-1:0] write_data_1,   // [19:6] data, [5:1] address, [0] enable
    input wire [`REGFILE_WRITE_STATE_SIZE-1:0] write_data_2,    // [7:6] card_state, [5:1] address, [0] enable
    
    output wire [1:0] regfile_w_enable,
    output wire [`CARD_ADDRESS_SIZE-1:0] regfile_w_address,
    output wire [`CARD_DATA_SIZE-1:0] regfile_w_data,
    output reg [`CARD_ADDRESS_SIZE-1:0] regfile_r_address
    );
    
    reg [`CARD_ADDRESS_SIZE-1:0] regfile_r_address_nxt;
    reg state, state_nxt;
    
    localparam
    READ_ONE_CARD = 1'b0,
    READ_ALL_CARDS = 1'b1;
    
    always @(posedge clk) begin
        if(rst) begin
            regfile_r_address <= 0;
            state <= READ_ONE_CARD;
        end
        else begin
            regfile_r_address <= regfile_r_address_nxt;
            state <= state_nxt;
        end
    end
    
    always @* begin
        case(state)
            READ_ONE_CARD:
            begin   
                if(read_all_cards) begin
                    state_nxt = READ_ALL_CARDS;
                    regfile_r_address_nxt = `FIRST_CARD_INDEX;
                end  
                else begin       
                    state_nxt = state;
                    regfile_r_address_nxt = read_one_card;
                end
            end
            READ_ALL_CARDS: 
            begin
                if(regfile_r_address == num_of_cards) begin
                    state_nxt = READ_ONE_CARD;
                    regfile_r_address_nxt = read_one_card;
                end
                else begin
                    state_nxt = state;
                    regfile_r_address_nxt = regfile_r_address + 1;
                end
            end
            default: begin
            
            end
        endcase
    end
    
    assign regfile_w_enable[0]  = write_data_1[0];
    assign regfile_w_enable[1]  = write_data_2[0];
    assign regfile_w_address    = write_data_1[0] ? write_data_1[`CARD_ADDRESS_SIZE:1] :
                                  write_data_2[0] ? write_data_2[`CARD_ADDRESS_SIZE:1] : 5'd0;
    assign regfile_w_data[`CARD_DATA_SIZE-1:`CARD_STATE_SIZE]   = write_data_1[0] ? write_data_1[`REGFILE_WRITE_ALL_SIZE-1:`REGFILE_WRITE_STATE_SIZE] : 0;
    assign regfile_w_data[`CARD_STATE_SIZE-1:0]                 = write_data_1[0] ? write_data_1[`REGFILE_WRITE_STATE_SIZE-1:`CARD_ADDRESS_SIZE+1] :
                                                                  write_data_2[0] ? write_data_2[`REGFILE_WRITE_STATE_SIZE-1:`CARD_ADDRESS_SIZE+1] : 0;  
                                                                   
endmodule
