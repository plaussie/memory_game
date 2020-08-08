`timescale 1ns / 1ps


module testbench();
    wire compute_done;
    reg clk, rst, do; 
    reg compute_colors_en;
    wire [13:0] card_write_data;
    wire [3:0] card_write_address;
    //wire done;
    
    initial begin
        clk = 0;
        do = 0;
    end
    
    always begin 
    #15 clk = !clk;
    end
    
    compute_colors MG_compute_colors(
        .clk(clk),
        .rst(rst),
        .enable(compute_colors_en),
        .done(compute_done),
        .computed_data(card_write_data),
        .computed_address(card_write_address)
    );
    
    always @(posedge clk) begin
        if(compute_done) compute_colors_en = 1'b0;
    end
    
        initial begin
            #40 rst = 1'b0;
            #100 rst = 1'b1;
            #50 rst = 1'b0;
            #50 compute_colors_en = 1'b1;
            
        end
    
/*
    draw_cards display_cards(
        .pclk(clk),
        .rst(rst),
        .do(do),
        .done(done),
        .vga_in(),
        .vga_out()
    );
        
    initial begin
        #40 rst = 1'b0;
        #100 rst = 1'b1;
        #50 rst = 1'b0;
        
        while (1) begin
            if (1'b1 === done)
                $display("It is done!! done = %d", done);
  
        #300 do = 1'b1;
        #30 do = 1'b0;
       
        end
    end

*/
    
endmodule