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

module button_image_rom
    #( parameter
        ROM_ADDRESS_SIZE   = 16,
        ROM_PIXELS_NUM   = 20,
        ROM_PATH   = ""
    )
    (
    input wire clk ,
    input wire [ROM_ADDRESS_SIZE-1:0] address,  // address = {addry[7:0], addrx[7:0]}
    output reg [11:0] rgb
    );


    reg [ROM_ADDRESS_SIZE-1:0] rom [0:ROM_PIXELS_NUM-1];
    
    initial $readmemh(ROM_PATH, rom); 
    
    always @(posedge clk)
    begin
        rgb <= rom[address];
    end

endmodule
