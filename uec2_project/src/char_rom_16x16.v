//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 08.07.2020 19:54:42
// Module Name: char_rom_16x16
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

`timescale 1ns / 1ps

module char_rom_16x16
    (
        input  wire         clk,
        input  wire [7:0]   char_yx,           // {char_y[3:0], char_x[3:0]}
        output reg  [6:0]   char_code          // code of the given char_yx
    );

    // signal declaration
    reg [6:0] data;

    // body
    always @(posedge clk)
        char_code <= data;

    always @*
        case (char_yx)
            //1st line
            8'h00: data = 84; 
            8'h01: data = 119;
            8'h02: data = 111;
            8'h03: data = 114;
            8'h04: data = 99; 
            8'h05: data = 97; 
            8'h06: data = 0;  
            8'h07: data = 116;
            8'h08: data = 101;
            8'h09: data = 103;
            8'h0a: data = 111;
            8'h0b: data = 0;
            8'h0c: data = 0;
            8'h0d: data = 0;
            8'h0e: data = 0;
            8'h0f: data = 0;
            
            //2nd line
            8'h10: data = 116;
            8'h11: data = 101;
            8'h12: data = 107;
            8'h13: data = 115;
            8'h14: data = 116;
            8'h15: data = 117;
            8'h16: data = 0;
            8'h17: data = 106;
            8'h18: data = 101;
            8'h19: data = 115;
            8'h1a: data = 116;
            8'h1b: data = 0;
            8'h1c: data = 0;
            8'h1d: data = 0;
            8'h1e: data = 0;
            8'h1f: data = 0;
            
            //3rd line
            8'h20: data = 75;
            8'h21: data = 114;
            8'h22: data = 122;
            8'h23: data = 121;
            8'h24: data = 115;
            8'h25: data = 122;
            8'h26: data = 116;
            8'h27: data = 111;
            8'h28: data = 102;
            8'h29: data = 0;
            8'h2a: data = 67;
            8'h2b: data = 105;
            8'h2c: data = 115;
            8'h2d: data = 108;
            8'h2e: data = 111;
            8'h2f: data = 33;
            
            //4th line
            8'h30: data = 1;
            8'h31: data = 1;
            8'h32: data = 1;
            8'h33: data = 1;
            8'h34: data = 1;
            8'h35: data = 1;
            8'h36: data = 1;
            8'h37: data = 1;
            8'h38: data = 1;
            8'h39: data = 1;
            8'h3a: data = 1;
            8'h3b: data = 1;
            8'h3c: data = 1;
            8'h3d: data = 1;
            8'h3e: data = 1;
            8'h3f: data = 1;
            
            //5th line
            8'h40: data = 2;
            8'h41: data = 2;
            8'h42: data = 2;
            8'h43: data = 2;
            8'h44: data = 2;
            8'h45: data = 2;
            8'h46: data = 2;
            8'h47: data = 2;
            8'h48: data = 2;
            8'h49: data = 2;
            8'h4a: data = 2;
            8'h4b: data = 2;
            8'h4c: data = 2;
            8'h4d: data = 2;
            8'h4e: data = 2;
            8'h4f: data = 2;
            
            //6th line
            8'h50: data = 3;
            8'h51: data = 3;
            8'h52: data = 3;
            8'h53: data = 3;
            8'h54: data = 3;
            8'h55: data = 3;
            8'h56: data = 3;
            8'h57: data = 3;
            8'h58: data = 3;
            8'h59: data = 3;
            8'h5a: data = 3;
            8'h5b: data = 3;
            8'h5c: data = 3;
            8'h5d: data = 3;
            8'h5e: data = 3;
            8'h5f: data = 3;
            
            //7th line
            8'h60: data = 4;
            8'h61: data = 4;
            8'h62: data = 4;
            8'h63: data = 4;
            8'h64: data = 4;
            8'h65: data = 4;
            8'h66: data = 4;
            8'h67: data = 4;
            8'h68: data = 4;
            8'h69: data = 4;
            8'h6a: data = 4;
            8'h6b: data = 4;
            8'h6c: data = 4;
            8'h6d: data = 4;
            8'h6e: data = 4;
            8'h6f: data = 4;
            
            //8th line                
            8'h70: data = 5;
            8'h71: data = 5;
            8'h72: data = 5;
            8'h73: data = 5;
            8'h74: data = 5;
            8'h75: data = 5;
            8'h76: data = 5;
            8'h77: data = 5;
            8'h78: data = 5;
            8'h79: data = 5;
            8'h7a: data = 5;
            8'h7b: data = 5;
            8'h7c: data = 5;
            8'h7d: data = 5;
            8'h7e: data = 5;
            8'h7f: data = 5;
            
            //9th line                
            8'h80: data = 6;
            8'h81: data = 6;
            8'h82: data = 6;
            8'h83: data = 6;
            8'h84: data = 6;
            8'h85: data = 6;
            8'h86: data = 6;
            8'h87: data = 6;
            8'h88: data = 6;
            8'h89: data = 6;
            8'h8a: data = 6;
            8'h8b: data = 6;
            8'h8c: data = 6;
            8'h8d: data = 6;
            8'h8e: data = 6;
            8'h8f: data = 6;
                            
            //10th line                
            8'h90: data = 13;
            8'h91: data = 13;
            8'h92: data = 13;
            8'h93: data = 13;
            8'h94: data = 13;
            8'h95: data = 13;
            8'h96: data = 13;
            8'h97: data = 13;
            8'h98: data = 13;
            8'h99: data = 13;
            8'h9a: data = 13;
            8'h9b: data = 13;
            8'h9c: data = 13;
            8'h9d: data = 13;
            8'h9e: data = 13;
            8'h9f: data = 13;
            
            //11th line                
            8'ha0: data = 14;
            8'ha1: data = 14;
            8'ha2: data = 14;
            8'ha3: data = 14;
            8'ha4: data = 14;
            8'ha5: data = 14;
            8'ha6: data = 14;
            8'ha7: data = 14;
            8'ha8: data = 14;
            8'ha9: data = 14;
            8'haa: data = 14;
            8'hab: data = 14;
            8'hac: data = 14;
            8'had: data = 14;
            8'hae: data = 14;
            8'haf: data = 14;
            
            //12th line                
            8'hb0: data = 0;
            8'hb1: data = 0;
            8'hb2: data = 0;
            8'hb3: data = 0;
            8'hb4: data = 0;
            8'hb5: data = 0;
            8'hb6: data = 0;
            8'hb7: data = 0;
            8'hb8: data = 0;
            8'hb9: data = 0;
            8'hba: data = 0;
            8'hbb: data = 0;
            8'hbc: data = 0;
            8'hbd: data = 0;
            8'hbe: data = 0;
            8'hbf: data = 0;
            
            //13th line
            8'hc0: data = 0;
            8'hc1: data = 0;
            8'hc2: data = 0;
            8'hc3: data = 0;
            8'hc4: data = 0;
            8'hc5: data = 0;
            8'hc6: data = 0;
            8'hc7: data = 0;
            8'hc8: data = 0;
            8'hc9: data = 0;
            8'hca: data = 0;
            8'hcb: data = 0;
            8'hcc: data = 0;
            8'hcd: data = 0;
            8'hce: data = 0;
            8'hcf: data = 0;
            
            //14th line               
            8'hd0: data = 0;
            8'hd1: data = 0;
            8'hd2: data = 0;
            8'hd3: data = 0;
            8'hd4: data = 0;
            8'hd5: data = 0;
            8'hd6: data = 0;
            8'hd7: data = 0;
            8'hd8: data = 0;
            8'hd9: data = 0;
            8'hda: data = 0;
            8'hdb: data = 0;
            8'hdc: data = 0;
            8'hdd: data = 0;
            8'hde: data = 0;
            8'hdf: data = 0;
            
            //15th line                
            8'he0: data = 0;
            8'he1: data = 0;
            8'he2: data = 0;
            8'he3: data = 0;
            8'he4: data = 0;
            8'he5: data = 0;
            8'he6: data = 0;
            8'he7: data = 0;
            8'he8: data = 0;
            8'he9: data = 0;
            8'hea: data = 0;
            8'heb: data = 0;
            8'hec: data = 0;
            8'hed: data = 0;
            8'hee: data = 0;
            8'hef: data = 0;
                            
            //16th line                
            8'hf0: data = 95;
            8'hf1: data = 95;
            8'hf2: data = 95;
            8'hf3: data = 95;
            8'hf4: data = 95;
            8'hf5: data = 95;
            8'hf6: data = 95;
            8'hf7: data = 95;
            8'hf8: data = 95;
            8'hf9: data = 95;
            8'hfa: data = 95;
            8'hfb: data = 95;
            8'hfc: data = 95;
            8'hfd: data = 95;
            8'hfe: data = 95;
            8'hff: data = 95;
        endcase
    
endmodule