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
    input wire butt,
    output reg db_butt
    );
    
    reg butt_d1, butt_d2;
   
    always @(posedge clk) begin
        butt_d1 <= butt;
        butt_d2 <= butt_d1;
        db_butt <= butt_d2;
    end

endmodule
