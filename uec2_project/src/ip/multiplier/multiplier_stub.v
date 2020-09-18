// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Fri Sep 18 18:54:10 2020
// Host        : WOLVEPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/KRZYSZTOF/Education/Studies/IV_term/Uklady-elektroniki-cyfrowej2/Project/memory_game/uec2_project/src/ip/multiplier/multiplier_stub.v
// Design      : multiplier
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_13,Vivado 2017.3" *)
module multiplier(CLK, A, CE, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[5:0],CE,P[12:0]" */;
  input CLK;
  input [5:0]A;
  input CE;
  output [12:0]P;
endmodule
