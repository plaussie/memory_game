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
// Revision 0.40 - Added regfile with its control unit
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// rf[x][0] = 1 card is active; = 0 card is inactive
// rf[x][1] = 1 card is discovered; = 0 card is covered
// rf[x][13:2] represents card's computed color [ MSB:r,g,b:LSB ]
// rf[x] where 'x' is from 4'h1 to 4'hc

// w_enable[0] = 1 write every bit; = 0 write disable
// w_enable[1] = 1 write [1:0] bits; = 0 write disable

module regfile(
    input wire clk,
    input wire  [1:0]  w_enable,
    input wire  [13:0] w_data,
    input wire  [3:0]  w_address,
    input wire  [3:0]  r_address,
    output wire [13:0] r_data
    );
    
    reg [13:0] rf [15:0];
    
    always @(posedge clk) begin
        if(w_enable[0]) begin
            rf[w_address] <= w_data;
        end
        else if(w_enable[1]) begin
            rf[w_address][1:0] <= w_data[1:0];
        end
    end
    
    assign r_data = rf[r_address];
endmodule
