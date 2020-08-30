`timescale 1ns / 1ps

`define VGA_BUS_SIZE 38

`define CARD_MAX_NUM 16
`define CARD_MAX_NUM_SIZE 5
`define CARD_NUM_EASY 8
`define CARD_NUM_NORMAL 12
`define CARD_NUM_HARD 16

`define CARD_ADDRESS_SIZE 5
`define CARD_COLOR_SIZE 12
`define CARD_STATE_SIZE 2
`define CARD_DATA_SIZE `CARD_COLOR_SIZE+`CARD_STATE_SIZE
`define CARD_YX_POSITION_SIZE 20
`define FIRST_CARD_INDEX 1

`define START_BUTTON_X_POS 412
`define START_BUTTON_Y_POS 328
`define START_BUTTON_WIDTH 200
`define START_BUTTON_HEIGHT 112

`define TEMPORARY_NUM_OF_CARDS 16

module testbench();

    //params
    localparam
        NUM_MODULES = 4;

    reg clk65MHz, rst, left;
    reg [11:0] xpos, ypos;

    
    initial begin
        clk65MHz = 0;
        left = 0;
        xpos = 0;
        ypos = 0;
    end
    
    always begin 
    #15 clk65MHz = !clk65MHz;
    end

    //***The Main State Machine***//
        wire [`CARD_DATA_SIZE-1:0] regfile_w_data, regfile_r_data;
        
        wire start_butt_pressed, card_pressed;
        wire compute_done;
        wire start_butt_en, compute_colors_en, stopwatch_en, update_cards_en, wait_for_click_en, write_card_en, stopwatch_disable, end_screen_en;
        wire [`CARD_ADDRESS_SIZE-1:0] card_clicked_address, write_card_address;
        wire [`CARD_STATE_SIZE-1:0] write_card_state;
    
        state_machine MG_state_machine(
            .clk(clk65MHz),
            .rst(rst),
            .num_of_cards(`TEMPORARY_NUM_OF_CARDS),
            .start_butt_pressed(start_butt_pressed),
            .compute_done(compute_done),
            .card_pressed(card_pressed),
            .card_clicked_address(card_clicked_address),
            .card_clicked_color(regfile_r_data[`CARD_DATA_SIZE-1:`CARD_STATE_SIZE]),
            .start_butt_en(start_butt_en),
            .update_cards_en(update_cards_en),
            .compute_colors_en(compute_colors_en),
            .stopwatch_en(stopwatch_en),
            .stopwatch_disable(stopwatch_disable),
            .wait_for_click_en(wait_for_click_en),
            .write_card_en(write_card_en),
            .end_screen_en(end_screen_en),
            .write_card_state(write_card_state),
            .write_card_address(write_card_address)
        );
        
        //***Stopwatch***//
        
        wire [5:0] minutes, seconds;
        
        stopwatch MG_stopwatch(
            .clk(clk65MHz),
            .rst(rst),
            .start(stopwatch_en),
            .pause(1'b0),
            .stop(stopwatch_disable),
            .minutes(minutes),
            .seconds(seconds)
            
        );
        
        //***Cards Colors Generator***//
        
        wire [`CARD_DATA_SIZE-1:0] card_write_data;
        wire [`CARD_ADDRESS_SIZE-1:0] card_write_address;
    
        compute_colors MG_compute_colors(
            .clk(clk65MHz),
            .rst(rst),
            .enable(compute_colors_en),
            .num_of_cards(`TEMPORARY_NUM_OF_CARDS),
            .done(compute_done),
            .computed_data(card_write_data),
            .computed_address(card_write_address)
        );
        
        //***update_cards_en Delayer***//
        
        wire update_cards_en_delayed_tact;
        
        delay
        #(
            .WIDTH(1),
            .CLK_DEL(1)
        )
        delay_update_cards_en_1(
            .clk(clk65MHz),
            .rst(rst),
            .din(update_cards_en),
            .dout(update_cards_en_delayed_tact)
        );
        
        wire update_cards_en_delayed_2tact;
            
        delay
        #(
            .WIDTH(1),
            .CLK_DEL(2)
        )
        delay_update_cards_en_2(
            .clk(clk65MHz),
            .rst(rst),
            .din(update_cards_en),
            .dout(update_cards_en_delayed_2tact)
        );
    
        //***Cards Positions Generator***//
        
        wire [`CARD_YX_POSITION_SIZE-1:0] yx_card_position;
        
        cards_pos_gen MG_cards_positions(
            .clk(clk65MHz),
            .rst(rst),
            .read_all_positions(update_cards_en),
            .num_of_cards(`TEMPORARY_NUM_OF_CARDS),
            .yx_card_position(yx_card_position)
        );
        
        //***RegFile Controller***//
        
        wire [1:0] regfile_w_enable;
        
        wire [`CARD_ADDRESS_SIZE-1:0] regfile_w_address, regfile_r_address, card_to_test_address;
        
        regfileCtl MG_colors_regfileCtl(
            .clk(clk65MHz),
            .rst(rst),
            .num_of_cards(`TEMPORARY_NUM_OF_CARDS),
            .read_all_cards(update_cards_en_delayed_tact),
            .read_one_card(card_to_test_address),
            .write_data_1({card_write_data, card_write_address, compute_colors_en}),
            .write_data_2({write_card_state, write_card_address, write_card_en}),
            .regfile_w_enable(regfile_w_enable),
            .regfile_w_address(regfile_w_address),
            .regfile_w_data(regfile_w_data),
            .regfile_r_address(regfile_r_address)
        );    
        
        //***RegFile***//
        
        regfile MG_colors_regfile(
            .clk(clk65MHz),
            .w_enable(regfile_w_enable),
            .w_data(regfile_w_data),
            .w_address(regfile_w_address),
            .r_data(regfile_r_data),
            .r_address(regfile_r_address)
        );
    
        //***VGA Timings Generator***//
        
        //VGA bus
        wire [`VGA_BUS_SIZE-1:0] vga_bus [NUM_MODULES:0];
    
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
    
        button_press_checker
        #(
            .X_POS(`START_BUTTON_X_POS),
            .Y_POS(`START_BUTTON_Y_POS),
            .WIDTH(`START_BUTTON_WIDTH),
            .HEIGHT(`START_BUTTON_HEIGHT)    
        )
        MG_check_if_left_clicked_start_butt (
            .clk(clk65MHz),
            .enable(start_butt_en),
            .mouse_left(left),
            .mouse_xpos(xpos),
            .mouse_ypos(ypos),
            .button_pressed(start_butt_pressed),
            .rst(rst)
        );
        
        //***Start Button Display***//
        wire [15:0] pixel_address;
        wire [11:0] rgb_start_button;
        
        draw_image_rom 
        #(
            .X_POS(`START_BUTTON_X_POS),
            .Y_POS(`START_BUTTON_Y_POS),
            .WIDTH(`START_BUTTON_WIDTH),
            .HEIGHT(`START_BUTTON_HEIGHT)
        )
        display_start_button(
            .pclk(clk65MHz),
            .rst(rst),
            .enable(start_butt_en),
            .rgb_pixel(rgb_start_button),
            .vga_in(vga_bus[1]),
            .pixel_address(pixel_address),
            .vga_out(vga_bus[2])
        );
        start_image_rom start_image(
            .clk(clk65MHz),
            .address(pixel_address),
            .rgb(rgb_start_button)
        );
        
        //***Cards Display & Card Press Checker***//
        
        cardsCtl display_clickable_cards(
            .clk(clk65MHz),
            .rst(rst),
            .num_of_cards(`TEMPORARY_NUM_OF_CARDS),
            .yx_card_position(yx_card_position),
            .regfile_in(regfile_r_data),
            .regfile_sync(update_cards_en_delayed_2tact),
            .vga_in(vga_bus[2]),
            .vga_out(vga_bus[3]),
            .card_press_checker_en(wait_for_click_en),
            .mouse_left(left),
            .mouse_xpos(xpos),
            .mouse_ypos(ypos),
            .card_test_state(regfile_r_data[`CARD_STATE_SIZE-1:0]),
            .card_to_test_address(card_to_test_address),
            .card_clicked_address(card_clicked_address),
            .event_occurred(card_pressed)
        );
        
        //***EndScreen Display***//
        
        endgame_screen display_endscreen(
            .pclk(clk65MHz),
            .rst(rst),
            .enable(end_screen_en),
            .game_time({minutes, seconds}),
            .vga_in(vga_bus[3]),
            .vga_out(vga_bus[4])
        );

        
    initial begin
        #50 rst = 1'b0;
        #100 rst = 1'b1;
        #50 rst = 1'b0;
        #50
        //Start button press
        {xpos, ypos, left} = {12'd420, 12'd330, 1'b1};
        #100
        left = 0;
        #1500
        //Card nr 5 pressed
        {xpos, ypos, left} = {12'd60, 12'd210, 1'b1};
        #100
        left = 0;
        #1500
        //Card nr 1 pressed
        {xpos, ypos, left} = {12'd100, 12'd100, 1'b1};
        #100
        left = 0;
        #1500
        //Card nr 13 pressed
        {xpos, ypos, left} = {12'd55, 12'd555, 1'b1};
        #100
        left = 0;
    end
endmodule