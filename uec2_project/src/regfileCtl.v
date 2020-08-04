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
    IDLE = 0,
    INCREMENT_READ_ADDRESS = 1;
    
    always @(posedge clk) begin
        if(rst) begin
            regfile_r_address <= 0;
            state <= IDLE;
        end
        else begin
            regfile_r_address <= regfile_r_address_nxt;
            state <= state_nxt;
        end
    end
    
    always @* begin
        regfile_r_address_nxt = 0;
        case(state)
            IDLE:                   state_nxt = update_cards_en ? INCREMENT_READ_ADDRESS : IDLE;
            INCREMENT_READ_ADDRESS: 
            begin
                                    regfile_r_address_nxt = regfile_r_address + 1;
                                    state_nxt = (regfile_r_address == NUM_CARDS) ? IDLE : INCREMENT_READ_ADDRESS;
            end
        endcase
    end
    
    assign regfile_w_enable = write_data_1[0] ? 1 : 0;
    assign regfile_w_address = write_data_1[0] ? write_data_1[4:1] : 4'h0;
    assign regfile_w_data = write_data_1[0] ? write_data_1[18:5] : 0;
    
endmodule
