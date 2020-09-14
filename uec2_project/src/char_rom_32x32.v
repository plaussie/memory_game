`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 25.08.2020 19:54:42
// Module Name: char_rom_32x32
// Project Name: Memory Game
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Changed to 32x32
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "_cards_macros.vh" 

module char_rom_32x32
    (
        input  wire         clk,
        input  wire         rst,
        input  wire         points_calculated,
        input  wire         enable,
        input  wire         game_over_en,          
        input  wire [12:0]  game_time,              // {seconds[12:7], hundredths[6:0]}
        input  wire [9:0]   char_yx,                // {char_y[4:0], char_x[4:0]}
        input  wire [13:0]  final_score,
        output reg  [6:0]   char_code               // code of the given char_yx
    );
    localparam
    HIGHSCORES_MAX_NUM = 5;

    localparam
    IDLE = 0,
    NEW_RECORD = 1,
    WAIT_FOR_NEW_GAME = 2;
    

    // signal declaration
    //if dozens or unity are from 0 to 5 like in stopwatch, you need 3bit wire
    //if dozens or unity are from 0 to 9 like normal, you need 4bit wire
    wire [2:0] seconds_dozens;
    wire [3:0] seconds_unity, hundredths_of_second_unity, hundredths_of_second_dozens; 
    wire [3:0] final_points_thousands, final_points_hundreds, final_points_dozens, final_points_unity;
    reg [6:0] data;
    
    reg [1:0] state, state_nxt;
    
    reg [13:0] highscores [0:4];
    reg [13:0] highscores_nxt [0:4];
    wire [13:0] current_score;
    wire [3:0] highscores_thousands [0:4];
    wire [3:0] highscores_hundreds  [0:4];
    wire [3:0] highscores_dozens    [0:4];
    wire [3:0] highscores_unity     [0:4];
    
    assign current_score = game_over_en ? 0 : final_score;
    
    assign final_points_thousands = final_score/10'd1000;
    assign final_points_hundreds = (final_score%10'd1000)/7'd100;
    assign final_points_dozens = ((final_score%10'd1000)%7'd100)/4'd10;
    assign final_points_unity = ((final_score%10'd1000)%7'd100)%4'd10;
    
    generate
    genvar i;
        for(i=0; i < HIGHSCORES_MAX_NUM; i = i+1) begin
            assign highscores_thousands[i] = highscores[i]/10'd1000;
            assign highscores_hundreds [i] = (highscores[i]%10'd1000)/7'd100;
            assign highscores_dozens   [i] = ((highscores[i]%10'd1000)%7'd100)/4'd10;
            assign highscores_unity    [i] = ((highscores[i]%10'd1000)%7'd100)%4'd10;
        end
    endgenerate
    
    assign seconds_dozens = game_time[12:7]/4'd10;
    assign seconds_unity = game_time[12:7]%4'd10;
    assign hundredths_of_second_dozens = game_time[6:0]/4'd10;
    assign hundredths_of_second_unity = game_time[6:0]%4'd10;
    
    // body
    
    always @(posedge clk) begin
        if(rst) begin
            char_code <= 0;
            state <= IDLE;
            highscores[0] <= 0;
            highscores[1] <= 0;
            highscores[2] <= 0;
            highscores[3] <= 0;
            highscores[4] <= 0;
        end
        else begin
            char_code <= data;
            state <= state_nxt;
            highscores[0] <= highscores_nxt[0];
            highscores[1] <= highscores_nxt[1];
            highscores[2] <= highscores_nxt[2];
            highscores[3] <= highscores_nxt[3];
            highscores[4] <= highscores_nxt[4];
        end
    end
    
    always @* begin
        highscores_nxt[0] = highscores[0];
        highscores_nxt[1] = highscores[1];
        highscores_nxt[2] = highscores[2];
        highscores_nxt[3] = highscores[3];
        highscores_nxt[4] = highscores[4];
        case(state)
            IDLE: begin
                state_nxt = points_calculated ? NEW_RECORD : state;
            end
            NEW_RECORD: begin
                state_nxt = WAIT_FOR_NEW_GAME;
                if(current_score > highscores[4]) begin
                    if(current_score > highscores[3]) begin
                        highscores_nxt[4] = highscores[3];
                        if(current_score > highscores[2]) begin
                            highscores_nxt[3] = highscores[2];
                            if(current_score > highscores[1]) begin
                                highscores_nxt[2] = highscores[1];
                                if(current_score > highscores[0]) begin
                                    highscores_nxt[1] = highscores[0];
                                    highscores_nxt[0] = current_score;
                                end
                                else begin
                                    highscores_nxt[1] = current_score;
                                end
                            end
                            else begin
                                highscores_nxt[2] = current_score;
                            end
                        end
                        else begin
                            highscores_nxt[3] = current_score;
                        end
                    end
                    else begin
                        highscores_nxt[4] = current_score;
                    end
                end
                else begin
                    //do nothing
                end
            end   
            WAIT_FOR_NEW_GAME: begin
                state_nxt = enable ? state : IDLE;
            end
            default: begin
                state_nxt = state;
            end
        endcase
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
            10'h04d: data = game_over_en ? 48  : 48 + final_points_thousands     ;       //score
            10'h04e: data = game_over_en ? 48  : 48 + final_points_hundreds      ;       //score
            10'h04f: data = game_over_en ? 48  : 48 + final_points_dozens        ;       //score
            10'h050: data = game_over_en ? 48  : 48 + final_points_unity         ;       //score

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
                                
            10'h200: data = 0                             ;
            10'h201: data = 49                            ;
            10'h202: data = 46                            ;
            10'h203: data = 0                             ;
            10'h204: data = 48 + highscores_thousands[0]  ;
            10'h205: data = 48 + highscores_hundreds [0]  ;
            10'h206: data = 48 + highscores_dozens   [0]  ;
            10'h207: data = 48 + highscores_unity    [0]  ;
            10'h208: data = 0                             ;
            10'h209: data = 112                           ;
            10'h20a: data = 111                           ;
            10'h20b: data = 105                           ;
            10'h20c: data = 110                           ;
            10'h20d: data = 116                           ;
            10'h20e: data = 115                           ;
            10'h20f: data = 0                             ;
            10'h210: data = 0                             ;
            
            //18th line (2nd score)
                                                    
            10'h220: data = 0                             ;
            10'h221: data = 50                            ;
            10'h222: data = 46                            ;
            10'h223: data = 0                             ;
            10'h224: data = 48 + highscores_thousands[1]  ;
            10'h225: data = 48 + highscores_hundreds [1]  ;
            10'h226: data = 48 + highscores_dozens   [1]  ;
            10'h227: data = 48 + highscores_unity    [1]  ;
            10'h228: data = 0                             ;
            10'h229: data = 112                           ;
            10'h22a: data = 111                           ;
            10'h22b: data = 105                           ;
            10'h22c: data = 110                           ;
            10'h22d: data = 116                           ;
            10'h22e: data = 115                           ;
            10'h22f: data = 0                             ;
            10'h230: data = 0                             ;
            
            //19th line (3rd score)   
                                      
            10'h240: data = 0                             ;      
            10'h241: data = 51                            ;      
            10'h242: data = 46                            ;      
            10'h243: data = 0                             ;      
            10'h244: data = 48 + highscores_thousands[2]  ;  
            10'h245: data = 48 + highscores_hundreds [2]  ;   
            10'h246: data = 48 + highscores_dozens   [2]  ;     
            10'h247: data = 48 + highscores_unity    [2]  ;      
            10'h248: data = 0                             ;      
            10'h249: data = 112                           ;      
            10'h24a: data = 111                           ;      
            10'h24b: data = 105                           ;      
            10'h24c: data = 110                           ;      
            10'h24d: data = 116                           ;      
            10'h24e: data = 115                           ;      
            10'h24f: data = 0                             ;      
            10'h250: data = 0                             ;   
            
            //19th line (4th score)   
                                                  
            10'h260: data = 0                             ;      
            10'h261: data = 52                            ;      
            10'h262: data = 46                            ;      
            10'h263: data = 0                             ;      
            10'h264: data = 48 + highscores_thousands[3]  ;  
            10'h265: data = 48 + highscores_hundreds [3]  ;   
            10'h266: data = 48 + highscores_dozens   [3]  ;     
            10'h267: data = 48 + highscores_unity    [3]  ;      
            10'h268: data = 0                             ;      
            10'h269: data = 112                           ;      
            10'h26a: data = 111                           ;      
            10'h26b: data = 105                           ;      
            10'h26c: data = 110                           ;      
            10'h26d: data = 116                           ;      
            10'h26e: data = 115                           ;      
            10'h26f: data = 0                             ;      
            10'h270: data = 0                             ;   
            
            //19th line (5th score)   
                                                  
            10'h280: data = 0                             ;      
            10'h281: data = 53                            ;      
            10'h282: data = 46                            ;      
            10'h283: data = 0                             ;      
            10'h284: data = 48 + highscores_thousands[4]  ;  
            10'h285: data = 48 + highscores_hundreds [4]  ;   
            10'h286: data = 48 + highscores_dozens   [4]  ;     
            10'h287: data = 48 + highscores_unity    [4]  ;      
            10'h288: data = 0                             ;      
            10'h289: data = 112                           ;      
            10'h28a: data = 111                           ;      
            10'h28b: data = 105                           ;      
            10'h28c: data = 110                           ;      
            10'h28d: data = 116                           ;      
            10'h28e: data = 115                           ;      
            10'h28f: data = 0                             ;      
            10'h290: data = 0                             ;
                                
            default: data = 0;
        endcase
    end
endmodule 
