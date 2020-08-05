`timescale 1ns / 1ps


module testbench();

    reg clk, rst, do;
    wire done;
    
    initial begin
        clk = 0;
        do = 0;
    end
    
    always begin 
    #15 clk = !clk;
    end

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


    
endmodule