`timescale 1 ns / 1 ps
/////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 02.09.2020 18:29:41
// Module Name: debounce
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module debounce(
    input wire clk,
    input wire clock_locked,
    output wire core_rst
    );
    
    reg d1, d2;
   
    always @(posedge clk) begin
        d1 <= clock_locked;
        d2 <= d1;
    end
    
    assign core_rst = !d2;

endmodule
