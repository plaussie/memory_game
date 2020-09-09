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

// char rom is 32x32

module char_rom_17x28
    (
        input  wire         clk,
        input  wire         game_over_en, 
        input  wire [7:0]   discovered_pairs_ctr,   // {dozens[3:0], unity[3:0]}
        input  wire [6:0]   seconds_dozens_unity,   // {dozens[2:0], unity[3:0]}
        input  wire [7:0]   hundredths_of_second,   // {dozens[3:0], unity[3:0]}
        input  wire [9:0]   char_yx,                // {char_y[4:0], char_x[4:0]}
        output reg  [6:0]   char_code               // code of the given char_yx
    );

    // signal declaration
    wire [2:0] seconds_dozens;
    wire [3:0] seconds_unity, hundredths_of_second_unity, hundredths_of_second_dozens, discovered_pairs_ctr_dozens, discovered_pairs_ctr_unity;
    reg [6:0] data;

    // body
    assign seconds_dozens = seconds_dozens_unity[6:4];
    assign seconds_unity = seconds_dozens_unity[3:0];
    assign hundredths_of_second_dozens = hundredths_of_second[7:4];
    assign hundredths_of_second_unity = hundredths_of_second[3:0];
    assign discovered_pairs_ctr_dozens = discovered_pairs_ctr[7:4];
    assign discovered_pairs_ctr_unity = discovered_pairs_ctr[3:0];
    
    always @(posedge clk) begin
        char_code <= data;
    end

    always @* begin
        case (char_yx)
            //1st line
            10'h000: data = game_over_en ? 0   : 0  ; 
            10'h001: data = game_over_en ? 0   : 67 ;
            10'h002: data = game_over_en ? 0   : 111;
            10'h003: data = game_over_en ? 71  : 110;
            10'h004: data = game_over_en ? 65  : 103; 
            10'h005: data = game_over_en ? 77  : 114; 
            10'h006: data = game_over_en ? 69  : 97 ;  
            10'h007: data = game_over_en ? 0   : 116;
            10'h008: data = game_over_en ? 79  : 117;
            10'h009: data = game_over_en ? 86  : 108;
            10'h00a: data = game_over_en ? 69  : 97 ;
            10'h00b: data = game_over_en ? 82  : 116;
            10'h00c: data = game_over_en ? 33  : 105;
            10'h00d: data = game_over_en ? 0   : 111;
            10'h00e: data = game_over_en ? 0   : 110;
            10'h00f: data = game_over_en ? 0   : 115;
            10'h010: data = game_over_en ? 0   : 33 ;
            //test
            10'h011: data = game_over_en ? 0   : 67 ;
            10'h012: data = game_over_en ? 0   : 111;
            10'h013: data = game_over_en ? 71  : 110;
            10'h014: data = game_over_en ? 65  : 103; 
            10'h015: data = game_over_en ? 77  : 114; 
            10'h016: data = game_over_en ? 69  : 97 ;  
            10'h017: data = game_over_en ? 0   : 116;
            10'h018: data = game_over_en ? 79  : 117;
            10'h019: data = game_over_en ? 86  : 108;
            10'h01a: data = game_over_en ? 69  : 97 ;
            10'h01b: data = game_over_en ? 82  : 116;
            10'h01c: data = game_over_en ? 33  : 105;
            10'h01d: data = game_over_en ? 0   : 111;
            10'h01e: data = game_over_en ? 0   : 110;
            10'h01f: data = game_over_en ? 0   : 115;
        
            //2nd line is empty
        
            //3rd line
            10'h040: data = game_over_en ? 0   : 0                               ;
            10'h041: data = game_over_en ? 89  : 89                              ;
            10'h042: data = game_over_en ? 111 : 111                             ;
            10'h043: data = game_over_en ? 117 : 117                             ;
            10'h044: data = game_over_en ? 114 : 114                             ;
            10'h045: data = game_over_en ? 0   : 0                               ;
            10'h046: data = game_over_en ? 115 : 115                             ;
            10'h047: data = game_over_en ? 99  : 99                              ;
            10'h048: data = game_over_en ? 111 : 111                             ;
            10'h049: data = game_over_en ? 114 : 114                             ;
            10'h04a: data = game_over_en ? 101 : 101                             ;
            10'h04b: data = game_over_en ? 58  : 58                              ;
            10'h04c: data = game_over_en ? 0   : 0                               ;
            10'h04d: data = game_over_en ? 48  : 48                              ;       //score
            10'h04e: data = game_over_en ? 48  : 48                              ;       //score
            10'h04f: data = game_over_en ? 48  : 48 + discovered_pairs_ctr_dozens;       //score
            10'h050: data = game_over_en ? 48  : 48 + discovered_pairs_ctr_unity ;       //score

            //4th line is empty
            
            //5th line
            10'h080: data = game_over_en ? 0   : 0                             ;
            10'h081: data = game_over_en ? 89  : 89                            ;
            10'h082: data = game_over_en ? 111 : 111                           ;
            10'h083: data = game_over_en ? 117 : 117                           ;
            10'h084: data = game_over_en ? 114 : 114                           ;
            10'h085: data = game_over_en ? 0   : 0                             ;
            10'h086: data = game_over_en ? 116 : 116                           ;
            10'h087: data = game_over_en ? 105 : 105                           ;
            10'h088: data = game_over_en ? 109 : 109                           ;
            10'h089: data = game_over_en ? 101 : 101                           ;
            10'h08a: data = game_over_en ? 0   : 58                            ;
            10'h08b: data = game_over_en ? 112 : 0                             ;
            10'h08c: data = game_over_en ? 97  : 48+seconds_dozens             ;         //time  
            10'h08d: data = game_over_en ? 115 : 48+seconds_unity              ;         //time 
            10'h08e: data = game_over_en ? 115 : 46                            ;         //time  
            10'h08f: data = game_over_en ? 101 : 48+hundredths_of_second_dozens;         //time  
            10'h090: data = game_over_en ? 100 : 48+hundredths_of_second_unity ;         //time  
            
            //15th line
            
            10'h1c0: data = 0;
            10'h1c1: data = 0;
            10'h1c2: data = 0;
            10'h1c3: data = 72;
            10'h1c4: data = 105;
            10'h1c5: data = 103;
            10'h1c6: data = 104;
            10'h1c7: data = 115;
            10'h1c8: data = 99;
            10'h1c9: data = 111;
            10'h1ca: data = 114;
            10'h1cb: data = 101;
            10'h1cc: data = 115;
            10'h1cd: data = 0;
            10'h1ce: data = 0;
            10'h1cf: data = 0;
            10'h1d0: data = 0;
            
            //16th line is empty
            
            //17th line (1st score)
                                
            10'h200: data = 49;
            10'h201: data = 46;
            10'h202: data = 0;
            10'h203: data = 0;
            10'h204: data = 0;
            10'h205: data = 0;
            10'h206: data = 0;
            10'h207: data = 0;
            10'h208: data = 0;
            10'h209: data = 0;
            10'h20a: data = 0;
            10'h20b: data = 0;
            10'h20c: data = 0;
            10'h20d: data = 0;
            10'h20e: data = 0;
            10'h20f: data = 0;
            10'h210: data = 0;
            
            //18th line (2nd score)
                                                    
            10'h220: data = 50;
            10'h221: data = 46;
            10'h222: data = 0;
            10'h223: data = 0;
            10'h224: data = 0;
            10'h225: data = 0;
            10'h226: data = 0;
            10'h227: data = 0;
            10'h228: data = 0;
            10'h229: data = 0;
            10'h22a: data = 0;
            10'h22b: data = 0;
            10'h22c: data = 0;
            10'h22d: data = 0;
            10'h22e: data = 0;
            10'h22f: data = 0;
            10'h230: data = 0;
            
            //19th line (3rd score)   
                                      
            10'h240: data = 51;       
            10'h241: data = 46;       
            10'h242: data = 0;        
            10'h243: data = 0;        
            10'h244: data = 0;        
            10'h245: data = 0;        
            10'h246: data = 0;        
            10'h247: data = 0;        
            10'h248: data = 0;        
            10'h249: data = 0;        
            10'h24a: data = 0;        
            10'h24b: data = 0;        
            10'h24c: data = 0;        
            10'h24d: data = 0;        
            10'h24e: data = 0;        
            10'h24f: data = 0;        
            10'h250: data = 0;        
                                
            default: data = 0;
        endcase
    end
endmodule 
