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

module regfileCtl(
    input wire clk,
    input wire rst,
    input wire read_all_cards,
    input wire [3:0] read_one_card,
    input wire [18:0] write_data_1,   // [18:5] data, [4:1] address, [0] enable
    input wire [6:0] write_data_2,    // [6:5] card_state, [4:1] address, [0] enable
    
    output wire [1:0] regfile_w_enable,
    output wire [3:0] regfile_w_address,
    output wire [13:0] regfile_w_data,
    output reg [3:0] regfile_r_address
    );
    
    reg [3:0] regfile_r_address_nxt;
    reg state, state_nxt;
    
    localparam
    NUM_CARDS = 4'hc,
    FIRST_CARD_INDEX = 4'h1,
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
                    regfile_r_address_nxt = FIRST_CARD_INDEX;
                end  
                else begin       
                    state_nxt = state;
                    regfile_r_address_nxt = read_one_card;
                end
            end
            READ_ALL_CARDS: 
            begin
                if(regfile_r_address == NUM_CARDS) begin
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
    assign regfile_w_address    = write_data_1[0] ? write_data_1[4:1] :
                                  write_data_2[0] ? write_data_2[4:1] : 4'h0;
    assign regfile_w_data[13:2] = write_data_1[0] ? write_data_1[18:7] : 0;
    assign regfile_w_data[1:0]  = write_data_1[0] ? write_data_1[6:5] :
                                  write_data_2[0] ? write_data_2[6:5] : 0;
    
endmodule
