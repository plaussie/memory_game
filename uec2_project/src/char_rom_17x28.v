`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 25.08.2020 19:54:42
// Module Name: char_rom_17x28
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

module char_rom_17x28
    (
        input  wire         clk,
        input  wire         game_over_en, 
        input  wire [5:0]   discovered_pairs_ctr,   // {dozens[2:0], unity[2:0]}
        input  wire [6:0]   seconds_dozens_unity,   // {dozens[2:0], unity[3:0]}
        input  wire [7:0]   hundredths_of_second,   // {dozens[3:0], unity[3:0]}
        input  wire [9:0]   char_yx,                // {char_y[4:0], char_x[4:0]}
        output reg  [6:0]   char_code               // code of the given char_yx
    );

    // signal declaration
    wire [2:0] seconds_dozens, discovered_pairs_ctr_dozens, discovered_pairs_ctr_unity;
    wire [3:0] seconds_unity, hundredths_of_second_unity, hundredths_of_second_dozens;
    reg [6:0] data;

    // body
    assign seconds_dozens = seconds_dozens_unity[6:4];
    assign seconds_unity = seconds_dozens_unity[3:0];
    assign hundredths_of_second_dozens = hundredths_of_second[7:4];
    assign hundredths_of_second_unity = hundredths_of_second[3:0];
    assign discovered_pairs_ctr_dozens = discovered_pairs_ctr[5:3];
    assign discovered_pairs_ctr_unity = discovered_pairs_ctr[2:0];
    
    always @(posedge clk) begin
        char_code <= data;
    end

    always @* begin
        if (game_over_en) begin
            case (char_yx)
                //1st line
                10'h000: data = 0; 
                10'h001: data = 0;
                10'h002: data = 0;
                10'h003: data = 71;
                10'h004: data = 65; 
                10'h005: data = 77; 
                10'h006: data = 69;  
                10'h007: data = 0;
                10'h008: data = 79;
                10'h009: data = 86;
                10'h00a: data = 69;
                10'h00b: data = 82;
                10'h00c: data = 33;
                10'h00d: data = 0;
                10'h00e: data = 0;
                10'h00f: data = 0;
                10'h010: data = 0;
            
                //2nd line
                10'h020: data = 0;
                10'h021: data = 0;
                10'h022: data = 0;
                10'h023: data = 0;
                10'h024: data = 0;
                10'h025: data = 0;
                10'h026: data = 0;
                10'h027: data = 0;
                10'h028: data = 0;
                10'h029: data = 0;
                10'h02a: data = 0;
                10'h02b: data = 0;
                10'h02c: data = 0;
                10'h02d: data = 0;
                10'h02e: data = 0;
                10'h02f: data = 0;
                10'h030: data = 0;
            
                //3rd line
                10'h040: data = 0;
                10'h041: data = 89;
                10'h042: data = 111;
                10'h043: data = 117;
                10'h044: data = 114;
                10'h045: data = 0;
                10'h046: data = 115;
                10'h047: data = 99;
                10'h048: data = 111;
                10'h049: data = 114;
                10'h04a: data = 101;
                10'h04b: data = 58;
                10'h04c: data = 0;
                10'h04d: data = 48;         //score
                10'h04e: data = 48;         //score
                10'h04f: data = 48;         //score
                10'h050: data = 48;         //score

                //4th line
                10'h060: data = 0;
                10'h061: data = 0;
                10'h062: data = 0;
                10'h063: data = 0;
                10'h064: data = 0;
                10'h065: data = 0;
                10'h066: data = 0;
                10'h067: data = 0;
                10'h068: data = 0;
                10'h069: data = 0;
                10'h06a: data = 0;
                10'h06b: data = 0;
                10'h06c: data = 0;
                10'h06d: data = 0;
                10'h06e: data = 0;
                10'h06f: data = 0;
                10'h070: data = 0;
                
                //5th line
                10'h080: data = 0;
                10'h081: data = 89;
                10'h082: data = 111;
                10'h083: data = 117;
                10'h084: data = 114;
                10'h085: data = 0;
                10'h086: data = 116;
                10'h087: data = 105;
                10'h088: data = 109;
                10'h089: data = 101;
                10'h08a: data = 0;
                10'h08b: data = 112;
                10'h08c: data = 97;   
                10'h08d: data = 115;  
                10'h08e: data = 115;   
                10'h08f: data = 101;   
                10'h090: data = 100;   

                default: data = 0;        
            endcase
        end
        else begin
            case (char_yx)
                //1st line
                10'h000: data = 0; 
                10'h001: data = 67;
                10'h002: data = 111;
                10'h003: data = 110;
                10'h004: data = 103; 
                10'h005: data = 114; 
                10'h006: data = 97;  
                10'h007: data = 116;
                10'h008: data = 117;
                10'h009: data = 108;
                10'h00a: data = 97;
                10'h00b: data = 116;
                10'h00c: data = 105;
                10'h00d: data = 111;
                10'h00e: data = 110;
                10'h00f: data = 33;
                10'h010: data = 0;
    
                //2nd line
                10'h020: data = 0;
                10'h021: data = 0;
                10'h022: data = 0;
                10'h023: data = 0;
                10'h024: data = 0;
                10'h025: data = 0;
                10'h026: data = 0;
                10'h027: data = 0;
                10'h028: data = 0;
                10'h029: data = 0;
                10'h02a: data = 0;
                10'h02b: data = 0;
                10'h02c: data = 0;
                10'h02d: data = 0;
                10'h02e: data = 0;
                10'h02f: data = 0;
                10'h030: data = 0;
    
                //3rd line
                10'h040: data = 0;
                10'h041: data = 89;
                10'h042: data = 111;
                10'h043: data = 117;
                10'h044: data = 114;
                10'h045: data = 0;
                10'h046: data = 115;
                10'h047: data = 99;
                10'h048: data = 111;
                10'h049: data = 114;
                10'h04a: data = 101;
                10'h04b: data = 58;
                10'h04c: data = 0;
                10'h04d: data = 48;         //score
                10'h04e: data = 48;         //score
                10'h04f: data = 48 + discovered_pairs_ctr_dozens;         //score
                10'h050: data = 48 + discovered_pairs_ctr_unity;         //score
                
                //4th line
                10'h060: data = 0;
                10'h061: data = 0;
                10'h062: data = 0;
                10'h063: data = 0;
                10'h064: data = 0;
                10'h065: data = 0;
                10'h066: data = 0;
                10'h067: data = 0;
                10'h068: data = 0;
                10'h069: data = 0;
                10'h06a: data = 0;
                10'h06b: data = 0;
                10'h06c: data = 0;
                10'h06d: data = 0;
                10'h06e: data = 0;
                10'h06f: data = 0;
                10'h070: data = 0;
                
                //5th line
                10'h080: data = 0;
                10'h081: data = 89;
                10'h082: data = 111;
                10'h083: data = 117;
                10'h084: data = 114;
                10'h085: data = 0;
                10'h086: data = 116;
                10'h087: data = 105;
                10'h088: data = 109;
                10'h089: data = 101;
                10'h08a: data = 58;
                10'h08b: data = 0;
                10'h08c: data = 48+seconds_dozens;   //time
                10'h08d: data = 48+seconds_unity;    //time
                10'h08e: data = 46;                  //time
                10'h08f: data = 48+hundredths_of_second_dozens;   //time
                10'h090: data = 48+hundredths_of_second_unity;    //time
                /*
                //6th line
                10'h50: data = 3;
                10'h51: data = 3;
                10'h52: data = 3;
                10'h53: data = 3;
                10'h54: data = 3;
                10'h55: data = 3;
                10'h56: data = 3;
                10'h57: data = 3;
                10'h58: data = 3;
                10'h59: data = 3;
                10'h5a: data = 3;
                10'h5b: data = 3;
                10'h5c: data = 3;
                10'h5d: data = 3;
                10'h5e: data = 3;
                10'h5f: data = 3;
                
                //7th line
                10'h60: data = 4;
                10'h61: data = 4;
                10'h62: data = 4;
                10'h63: data = 4;
                10'h64: data = 4;
                10'h65: data = 4;
                10'h66: data = 4;
                10'h67: data = 4;
                10'h68: data = 4;
                10'h69: data = 4;
                10'h6a: data = 4;
                10'h6b: data = 4;
                10'h6c: data = 4;
                10'h6d: data = 4;
                10'h6e: data = 4;
                10'h6f: data = 4;
                
                //8th line                
                10'h70: data = 5;
                10'h71: data = 5;
                10'h72: data = 5;
                10'h73: data = 5;
                10'h74: data = 5;
                10'h75: data = 5;
                10'h76: data = 5;
                10'h77: data = 5;
                10'h78: data = 5;
                10'h79: data = 5;
                10'h7a: data = 5;
                10'h7b: data = 5;
                10'h7c: data = 5;
                10'h7d: data = 5;
                10'h7e: data = 5;
                10'h7f: data = 5;
                
                //9th line                
                10'h80: data = 6;
                10'h81: data = 6;
                10'h82: data = 6;
                10'h83: data = 6;
                10'h84: data = 6;
                10'h85: data = 6;
                10'h86: data = 6;
                10'h87: data = 6;
                10'h88: data = 6;
                10'h89: data = 6;
                10'h8a: data = 6;
                10'h8b: data = 6;
                10'h8c: data = 6;
                10'h8d: data = 6;
                10'h8e: data = 6;
                10'h8f: data = 6;
                              
                //10th line                
                10'h90: data = 13;
                10'h91: data = 13;
                10'h92: data = 13;
                10'h93: data = 13;
                10'h94: data = 13;
                10'h95: data = 13;
                10'h96: data = 13;
                10'h97: data = 13;
                10'h98: data = 13;
                10'h99: data = 13;
                10'h9a: data = 13;
                10'h9b: data = 13;
                10'h9c: data = 13;
                10'h9d: data = 13;
                10'h9e: data = 13;
                10'h9f: data = 13;
                
                //11th line                
                10'ha0: data = 14;
                10'ha1: data = 14;
                10'ha2: data = 14;
                10'ha3: data = 14;
                10'ha4: data = 14;
                10'ha5: data = 14;
                10'ha6: data = 14;
                10'ha7: data = 14;
                10'ha8: data = 14;
                10'ha9: data = 14;
                10'haa: data = 14;
                10'hab: data = 14;
                10'hac: data = 14;
                10'had: data = 14;
                10'hae: data = 14;
                10'haf: data = 14;
                
                //12th line                
                10'hb0: data = 0;
                10'hb1: data = 0;
                10'hb2: data = 0;
                10'hb3: data = 0;
                10'hb4: data = 0;
                10'hb5: data = 0;
                10'hb6: data = 0;
                10'hb7: data = 0;
                10'hb8: data = 0;
                10'hb9: data = 0;
                10'hba: data = 0;
                10'hbb: data = 0;
                10'hbc: data = 0;
                10'hbd: data = 0;
                10'hbe: data = 0;
                10'hbf: data = 0;
                
                //13th line
                10'hc0: data = 0;
                10'hc1: data = 0;
                10'hc2: data = 0;
                10'hc3: data = 0;
                10'hc4: data = 0;
                10'hc5: data = 0;
                10'hc6: data = 0;
                10'hc7: data = 0;
                10'hc8: data = 0;
                10'hc9: data = 0;
                10'hca: data = 0;
                10'hcb: data = 0;
                10'hcc: data = 0;
                10'hcd: data = 0;
                10'hce: data = 0;
                10'hcf: data = 0;
                
                //14th line               
                10'hd0: data = 0;
                10'hd1: data = 0;
                10'hd2: data = 0;
                10'hd3: data = 0;
                10'hd4: data = 0;
                10'hd5: data = 0;
                10'hd6: data = 0;
                10'hd7: data = 0;
                10'hd8: data = 0;
                10'hd9: data = 0;
                10'hda: data = 0;
                10'hdb: data = 0;
                10'hdc: data = 0;
                10'hdd: data = 0;
                10'hde: data = 0;
                10'hdf: data = 0;
                
                //15th line                
                10'he0: data = 0;
                10'he1: data = 0;
                10'he2: data = 0;
                10'he3: data = 0;
                10'he4: data = 0;
                10'he5: data = 0;
                10'he6: data = 0;
                10'he7: data = 0;
                10'he8: data = 0;
                10'he9: data = 0;
                10'hea: data = 0;
                10'heb: data = 0;
                10'hec: data = 0;
                10'hed: data = 0;
                10'hee: data = 0;
                10'hef: data = 0;
                              
                //16th line                
                10'hf0: data = 95;
                10'hf1: data = 95;
                10'hf2: data = 95;
                10'hf3: data = 95;
                10'hf4: data = 95;
                10'hf5: data = 95;
                10'hf6: data = 95;
                10'hf7: data = 95;
                10'hf8: data = 95;
                10'hf9: data = 95;
                10'hfa: data = 95;
                10'hfb: data = 95;
                10'hfc: data = 95;
                10'hfd: data = 95;
                10'hfe: data = 95;
                10'hff: data = 95; 
                */
                default: data = 0;
            endcase
        end
        end
endmodule 
