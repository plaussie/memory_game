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


module regfileCtl(
    input wire clk,
    input wire rst,
    input wire update_cards_en,
    input wire [18:0] write_data_1,   // [18:5] data, [4:1] address, [0:0] enable
    
    output wire regfile_w_enable,
    output wire [3:0] regfile_w_address,
    output wire [13:0] regfile_w_data,
    output reg [3:0] regfile_r_address
    );
    
    reg [3:0] regfile_r_address_nxt;
    reg state, state_nxt;
    
    localparam
    NUM_CARDS = 12,
    FIRST_CARD_INDEX = 1,
    IDLE = 0,
    INCREMENT_READ_ADDRESS = 1;
    
    always @(posedge clk) begin
        if(rst) begin
            regfile_r_address <= FIRST_CARD_INDEX;
            state <= IDLE;
        end
        else begin
            regfile_r_address <= regfile_r_address_nxt;
            state <= state_nxt;
        end
    end
    
    always @* begin
        regfile_r_address_nxt = FIRST_CARD_INDEX;
        case(state)
            IDLE:
            begin                
                                state_nxt = update_cards_en ? INCREMENT_READ_ADDRESS : IDLE;
                                regfile_r_address_nxt = update_cards_en ? regfile_r_address + 1 : 0;
            end
            INCREMENT_READ_ADDRESS: 
            begin
                                state_nxt = (regfile_r_address == NUM_CARDS+FIRST_CARD_INDEX) ? IDLE : INCREMENT_READ_ADDRESS;
                                regfile_r_address_nxt = regfile_r_address + 1;
            end
        endcase
    end
    
    assign regfile_w_enable = write_data_1[0] ? 1 : 0;
    assign regfile_w_address = write_data_1[0] ? write_data_1[4:1] : 4'h0;
    assign regfile_w_data = write_data_1[0] ? write_data_1[18:5] : 0;
    
endmodule
