onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+clock_generator -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clock_generator xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {clock_generator.udo}

run -all

endsim

quit -force
