//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:56:42
// Module Name: image_rom
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.10 - File Copied from UEC2 Lab
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// This is the ROM for the 'AGH48x64.png' image.
// The image size is 48 x 64 pixels.
// The input 'address' is a 12-bit number, composed of the concatenated
// 6-bit y and 6-bit x pixel coordinates.
// The output 'rgb' is 12-bit number with concatenated
// red, green and blue color values (4-bit each)

module start_image_rom (
    input wire clk ,
    input wire [15:0] address,  // address = {addry[7:0], addrx[7:0]}
    output reg [11:0] rgb
    );


    reg [15:0] rom [0:65535];
    
    initial $readmemh("./start.data", rom); 
    
    always @(posedge clk)
    begin
        rgb <= rom[address];
    end

endmodule
