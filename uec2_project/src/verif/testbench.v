`timescale 1ns / 1ps
`define VGA_BUS_SIZE 38
`define NUM_MODULES 3

module testbench();

    reg clk65MHz, rst, left;
    reg [11:0] xpos, ypos;
    wire done;

    
    initial begin
        clk65MHz = 0;
        left = 0;
        xpos = 0;
        ypos = 0;
    end
    
    always begin 
    #15 clk65MHz = !clk65MHz;
    end

    wire start_butt_pressed, card_pressed;
    wire compute_done;
    wire start_butt_en, compute_colors_en, update_cards_en, wait_for_click_en, write_card_en;
    wire [3:0] card_clicked_address, write_card_address;
    wire [1:0] write_card_state;
    
    state_machine MG_state_machine(
        .clk(clk65MHz),
        .rst(rst),
        .start_butt_pressed(start_butt_pressed),
        .compute_done(compute_done),
        .card_pressed(card_pressed),
        .card_clicked_address(card_clicked_address),
        .card_clicked_color(regfile_r_data[13:2]),
        .start_butt_en(start_butt_en),
        .update_cards_en(update_cards_en),
        .compute_colors_en(compute_colors_en),
        .wait_for_click_en(wait_for_click_en),
        .write_card_en(write_card_en),
        .write_card_state(write_card_state),
        .write_card_address(write_card_address)
    );
    
    //***Cards Colors Generator***//
    
    wire [13:0] card_write_data;
    wire [3:0] card_write_address;

    compute_colors MG_compute_colors(
        .clk(clk65MHz),

        .rst(rst),
        .enable(compute_colors_en),
        .done(compute_done),
        .computed_data(card_write_data),
        .computed_address(card_write_address)
    );
    
    //***RegFile Controller***//
    
    wire [1:0] regfile_w_enable;
    wire [13:0] regfile_w_data, regfile_r_data;
    wire [3:0] regfile_w_address, regfile_r_address, card_to_test_address;
    
    regfileCtl MG_regfileCtl(
        .clk(clk65MHz),
        .rst(rst),
        .read_all_cards(update_cards_en),
        .read_one_card(card_to_test_address),
        .write_data_1({card_write_data, card_write_address, compute_colors_en}),
        .write_data_2({write_card_state, write_card_address, write_card_en}),
        .regfile_w_enable(regfile_w_enable),
        .regfile_w_address(regfile_w_address),
        .regfile_w_data(regfile_w_data),
        .regfile_r_address(regfile_r_address)
    );
     
    //***RegFile***//
    
    regfile MG_regfile(
        .clk(clk65MHz),
        .w_enable(regfile_w_enable),
        .w_data(regfile_w_data),
        .w_address(regfile_w_address),
        .r_data(regfile_r_data),
        .r_address(regfile_r_address)
    );
    
    //***Card Press Checker with returned card index***// na ten moment, bez zwracania, która karta
    
    card_press_checker MG_card_press_checker (
        .clk(clk65MHz),
        .rst(rst),
        .enable(wait_for_click_en),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .card_test_state(regfile_r_data[1:0]),
        .card_to_test_address(card_to_test_address),
        .card_clicked_address(card_clicked_address),
        .event_occurred(card_pressed)
    );

    //***VGA Timings Generator***//
    
    //VGA bus
    wire [`VGA_BUS_SIZE-1:0] vga_bus [`NUM_MODULES:0];

    vga_timing MG_vga_timing (
        .pclk(clk65MHz),
        .rst(rst),
        .vga_out(vga_bus[0])
    );

    //***Background Display***//

    draw_background display_background(
        .pclk(clk65MHz),
        .rst(rst),
        .vga_in(vga_bus[0]),
        .vga_out(vga_bus[1])
    );  
    
    //***Start Button Press Checker***//       

    event_checker
    #(
        .X_POS(312),
        .Y_POS(284),
        .WIDTH(400),
        .HEIGHT(200) 
    )
    MG_check_if_left_clicked_start_butt (
        .clk(clk65MHz),
        .enable(start_butt_en),
        .kind_of_event(left),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .event_occurred(start_butt_pressed),
        .rst(rst)
    );
    
    //***Start Button Display***//
    
    draw_rect 
    #(
        .X_POS(312),
        .Y_POS(284),
        .WIDTH(400),
        .HEIGHT(200),
        .COLOR(12'h0_A_A)
    )
    display_start_button(
        .pclk(clk65MHz),
        .rst(rst),
        .enable(start_butt_en),
        .vga_in(vga_bus[1]),
        .vga_out(vga_bus[2])
    );
    
    //***update_cards_en Delayer***//
    
    wire update_cards_en_delayed;
    
    delay
    #(
        .WIDTH(1),
        .CLK_DEL(1)
    )
    delay_update_cards_en(
        .clk(clk65MHz),
        .rst(rst),
        .din(update_cards_en),
        .dout(update_cards_en_delayed)
    );
    
    //***Cards Display***//
    
    draw_cards display_cards(
        .pclk(clk65MHz),
        .rst(rst),
        .regfile_in(regfile_r_data),
        .regfile_sync(update_cards_en_delayed),
        .regfile_sync_done(),
        .vga_in(vga_bus[2]),
        .vga_out(vga_bus[3])
    );
        
    initial begin
        #50 rst = 1'b0;
        #100 rst = 1'b1;
        #50 rst = 1'b0;
        #50
        //Start button press
        {xpos, ypos, left} = {12'd400, 12'd300, 1'b1};
        #100
        left = 0;
        #900
        //Card nr 6 pressed
        left = 1;
        #100
        left = 0;
        #600
        //Card nr 1 pressed
        {xpos, ypos, left} = {12'd100, 12'd100, 1'b1};
        #100
        left = 0;
    end
endmodule