`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 29.08.2020 20:30:39
// Module Name: button_image_rom
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

`include "_game_params.vh"

module button_image_rom
    #( parameter
        ROM_WIDTH_SIZE = 8,
        ROM_HEIGHT_SIZE = 8,
        ROM_PATH   = ""
    )
    (
    input wire [ROM_WIDTH_SIZE+ROM_HEIGHT_SIZE-1:0] address,  // address = {addry[7:0], addrx[7:0]}
    output wire [11:0] rgb
    );
    
    wire [ROM_WIDTH_SIZE-1:0] addrx;
    wire [ROM_HEIGHT_SIZE-1:0] addry;
    assign addry = address[ROM_WIDTH_SIZE+ROM_HEIGHT_SIZE-1:ROM_WIDTH_SIZE];
    assign addrx = address[ROM_WIDTH_SIZE-1:0];

    reg [2**ROM_WIDTH_SIZE-1:0] rom [0:2**ROM_HEIGHT_SIZE-1];
    
    initial $readmemb(ROM_PATH, rom); 
    
    assign rgb = (rom[addry][addrx] == 1) ? `BUTTON_TXT_COLOR : `BUTTON_COLOR;

endmodule
