`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Krzysztof Cislo & Jakub Dzialowy
// 
// Create Date: 28.08.2020 19:52:40
// Module Name: card_press_checker
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


module card_press_checker (
    input wire          clk,
    input wire          rst,    
    input wire          enable,
    input wire          kind_of_event,
    input wire          regfile_sync,
    input wire [19:0]   yx_position_in,
    input wire [8:0]    height,
    input wire [7:0]    width,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    
    output reg          regfile_sync_done,
    output reg          event_occurred
    );
    
    reg event_occurred_nxt;
    reg [19:0] yx_position_reg, yx_position_reg_nxt;
    wire regfile_sync_done_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            event_occurred <= 0;
            yx_position_reg <= 0;
            regfile_sync_done <= 0;
        end
        else begin
            event_occurred <= event_occurred_nxt;
            yx_position_reg <= yx_position_reg_nxt;
            regfile_sync_done <= regfile_sync_done_nxt;
        end
    end
    
    always @* begin
        if(enable) begin
            if(kind_of_event) begin
                if((mouse_xpos > yx_position_reg[9:0]) && (mouse_xpos < yx_position_reg[9:0]+width) && (mouse_ypos > yx_position_reg[19:10]) && (mouse_ypos < yx_position_reg[19:10]+height)) begin
                    event_occurred_nxt = 1;
                end
                else begin
                    event_occurred_nxt = 0;
                end
            end
            else begin
                event_occurred_nxt = 0;
            end
        end
        else begin
            event_occurred_nxt = 0;
        end
    end
    
    always @*
        begin
            if(regfile_sync) begin
                yx_position_reg_nxt = yx_position_in;
            end
            else begin
                yx_position_reg_nxt = yx_position_reg;
            end
        end
        
    assign regfile_sync_done_nxt = regfile_sync;
endmodule
