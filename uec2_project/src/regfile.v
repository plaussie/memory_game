`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 27.07.2020 21:03:20
// Module Name: regfile
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

// [1:0] to bity mówi¹ce o stanie karty, 00 - karta nieaktywna, 01 - karta przodem, 10 - karta ty³em;
// [13:2] to bity mówi¹ce o kolorze karty, kolejnoœæ MSB:r,g,b:LSB

module regfile(
    input wire clk,
    input wire w_enable,
    input wire [13:0] w_data,
    input wire [3:0] w_address,
    input wire [3:0] r_address,
    output wire [13:0] r_data
    );
    
    reg [13:0] rf [3:0];
    
    always @(posedge clk) begin
        if(w_enable) begin
            rf[w_address] <= w_data;
        end
    end
    
    assign r_data = rf[r_address];
endmodule
