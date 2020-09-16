// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Mon Sep 14 21:14:12 2020
// Host        : LAPTOP-IVH6M5RF running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top multiplier -prefix
//               multiplier_ multiplier_sim_netlist.v
// Design      : multiplier
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multiplier,mult_gen_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_13,Vivado 2017.3" *) 
(* NotValidForBitStream *)
module multiplier
   (CLK,
    A,
    CE,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [5:0]A;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [12:0]P;

  wire [5:0]A;
  wire CE;
  wire CLK;
  wire [12:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "6" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "1100101" *) 
  (* C_B_WIDTH = "7" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "12" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multiplier_mult_gen_v12_0_13 U0
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "6" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "1100101" *) (* C_B_WIDTH = "7" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "12" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module multiplier_mult_gen_v12_0_13
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [5:0]A;
  input [6:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [12:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [5:0]A;
  wire CE;
  wire CLK;
  wire [12:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "6" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "1100101" *) 
  (* C_B_WIDTH = "7" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "12" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multiplier_mult_gen_v12_0_13_viv i_mult
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
dWWkLS4MAxTabZJf/z6PdYqCAGBEFl60TKb71Rh2J+7fWDO/9CrkzmRY6MvLyDNa6XcNwmyjo+vH
IT27waHJUw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
PStuquU0P15n6Yubm4HMz3YAXAHDJepiOAryzYKQSHrg15urbj1rVu7aY4DMfqLAeOhhBf2TxCH+
9b87ufCRohY5ifOwzlMpKd1I3Si+/3GUzw9K8cI1mIMThIsp8ehAXs7z6PmPe8fpb58yK53dOUFC
FlXVFlQ6H75gMzv2rk4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kwri0+QxipG5A83IfKXbnNqYBPHFYGaIsFL2KUvt2+LL7U18MJTQM+vo3V0pETK3opNpZ2mjFhXX
ZzMyYH6qWunSiWYrhs76sXNQ6knBLUhyk1u3tR5DMBXeoO/LVNQv6j3UGT0axEDoKmA+owk75POw
nrWnrkyYKkBEjVQZp/KPABPhhmASMkggWTXY3g6g0xQjGCQ+VxdTkVKoA6XMhNWaRzxDsRy9OUbU
oxP2nChnJTZkuYS+wwzHiaJ1lvMrtfYzNGg/Kwwtey0hN3IfMuVmf2ekPAKJQbUdvdbdMnS6FRz2
0u1JY8tUdctyWIwH3hvfVDk66bxGiWjLknoPjQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ESY/ZH+AOdR3bJqVthBiqNmS1Jk9vG9eNoc6T4mvQxABeWInTaMFH5NkdbdUlHov8eF7SmZE70WB
4IRayOKfvPxA8JUbj4JtuPw5Z4chCBY7T1gFg85KCLWBceRIQFqhSQS7Yp5ruOHM1R3lABf0DrmT
pMIKsz09QJbnVuBRr6EcSYXweqOMVf23gE+j/5QrN3W3+YU4uOqVekWMf+NXuLpJit85XZmiXOP8
MLPN6QA6ojsaqurh6u0qqqdHu0ueB2zuQJUF9OY7BElgqWCuKnmNopoG6VpfRlow3aoOnx0BItXF
4WZA0b0UvdATxN0d9vul2AZzEkxuVibl5QhmEw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QU2aH6P/xI2F+KTH+343BxpGAPnWdbPeRjqVBInBEYpd+kSziCSub3j2t6XzCbhEMu7Bz1gAUEpo
Rz9cEAi8Mhig12ELCTQBLt97IIIBB3EMMaYdXYFuALnAdGET5Ls2k6BA+/reYpsZPGJ6N0G+rIP2
xOT6QhtjQ7J0/d4KKdSBMFWxpl9bBh77/oLyB7lgZZXOH5qEh/fQj1XmVhY+VKLQAAgJU6AdPvaS
aTUfNcvM2zkAICgPbm1M6JoBZcHBu9ktB06412Ip0F1kmmDtlQsv6MxYdIireAvAN5pJySI0QCVM
9z9D3cJYBl/AoBjSk6RhPa6oMfZXShIgwATRFQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
QVcKNT3uT/N+TRIZq6fZRukT5w/zN0mLW+8srEKbzCGBtUWWAfY/ZXcAsiFOAUT8P74Eem/5yLlJ
NCqhFDs56cEcv3DUmVRq19feSFq5jL+Msg5JbEWK1Q4def4qnJmLvbdTedENrnhiab7fS5umsdXK
mhSuM8LyfzEDuEodUPk=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nndcpEnL0nNbk8F4xWqpm+K5naMnFaJozpsJN51Ns0zsRSSUESxbqyxF13pa+9yK3A37adCOywfl
yNwUoQmpZcxHTWaDgNBWp0wt0aOJr+62A/yO4qrxnVqJGbzacN1x09Ssxtj21Mjkl7vJ7j+P/GzX
4iEjHQzZU24x5XwW/no4kbj+s28zKN71Rf1EZCiEdnAoPS9dCC6orFOYwwSg68oXF/eLVXo4zFJF
NV6pcjlZlONhbZsycUyqLAAH8qqHB6dlnSHMbkHqjlIByg78JrwEUEOe5dYxw8YELwI6Y5pZwv63
0s6oFSRksaznFGTyhsiGLv4RmK42MPI2MyrLoA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OtqkuDVYtiQW0hDX1TTQThzOHRPdaIYdftN/8kdaSQfBdtx/o0om5jk0NsJOQgGVgkets2rG5KKD
VIy+wCx5aecEqoxUbkIcgtjeDeHP7Th1JvjJWyezNockHVWXvOpbpHl+do9puSJdzFrkFbdFJK04
eyzwEf7Xg7WBJQqGMqeKzmkrcH/vuSTxCqpVb+BYrtQhXZZZMayzcu9i5DP9SUHQrI83Ld22Exmo
8uTpOPrv7oISGKfSk4tZtkhgLWwwA5F47+nz1iBd07XnT/MmjY5I8ZmlCyMkkrpih5FmLOidVX7U
UsndonbAOv81lDUGqOFdNJyQClgfiYLGQlDV7Q==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bhOdLAt2vyvjSvlFFy9Nor1D4CPwHQdoo9jZ49gp52wc74JPDb91UY8wOhraUBtxpPP9oqykS7Ds
jSz3ryJ2mn+WBqwyhyyFOnizQ48Nku5JTHs939tels+aAgoPgGamUjb8ZY3pO/cQEGNcvjjoqHyb
2NxO//eZRKOiavSYc3/PK52Bb2F1O1nIQbmRKFgFgalttskNtkAThoxifQts51kimTFPaW/r1s4d
7wa8P3ujo64DNXJIEhxP42l5yfvc33/qIqicx4Q7+dwmfwaRsjZZoo8mVDix9S2bcbWpVA8NHEhl
qTw6Zg//2nN9bEGB0Ina2t+N7hmgvBSNtPmddg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 8080)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
