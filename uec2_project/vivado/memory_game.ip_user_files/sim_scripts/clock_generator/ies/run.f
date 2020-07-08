-makelib ies_lib/xil_defaultlib -sv \
  "D:/Program_Files_Studies/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Program_Files_Studies/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../../src/ip/clock_generator/clock_generator_clk_wiz.v" \
  "../../../../../src/ip/clock_generator/clock_generator.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

