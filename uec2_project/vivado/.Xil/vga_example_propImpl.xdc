set_property SRC_FILE_INFO {cfile:c:/Users/Krzysztof/Dropbox/IV_term/Uklady-elektroniki-cyfrowej2/Project/memory_game/uec2_project/src/ip/clock_generator/clock_generator.xdc rfile:../../src/ip/clock_generator/clock_generator.xdc id:1 order:EARLY scoped_inst:my_clock/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk]] 0.1
