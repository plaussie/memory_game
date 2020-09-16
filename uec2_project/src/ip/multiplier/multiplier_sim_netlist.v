// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Wed Sep 16 21:35:12 2020
// Host        : WOLVEPC running 64-bit major release  (build 9200)
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
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 65000000, PHASE 0.000" *) input CLK;
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
JjANEPeiaGRTde5goy+rylLm5l/9ww3HVQsE2vIg/6GFkQ88UjHhZGj1B1bgTvz6xofNnF+2+u8v
FohFfDVLcU3UJPSlrHwcZr8NadQn87KNb4Z/RNmtkiHiBgT10+/KcUh2yw6awpc1SWGv3xpC6Vww
jBhyK2yNeMYH2nzQOTHPJaJeoL93GMgU7OicZnE6478KAXTcPVEWzx2ArGTGcqGLV4zu3itfpSaw
qzcdjbr33Ezs8GZTxm9qbv50nQT8Qs52in+OyR62tSwyrC/b2UTsaH+dEay5g6JdS73VpI2mpvel
b0IskLmzbWhyZIMxt4BB/NRbACdNBy0uQj7eWg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RrE1/Z3oea20rWFKfDqyhPKy7t3MyHVk/nwg+ubUQ1vg7T1oAMd19t/LE4INT5UHhSyEJzJJZ/+n
KmG5QsiiufLdMDixnG09juX+TLvO+MgJ9iAlxYSew0DbVlG299uXbDfLXvxYDf2JfaK4nuTwl9oe
PUMAYpqSk5TJ2zMPu22xIxNd++Ln5AW4ijhHudqHuXJhSDUCbBFVJknsd6Qos80YCZKChtCs/Ttw
wVTHrf3xvTswTfW7LzR/QEmsp6dr+jgsBN6xfigqunWG1w1hlTtWUfCNigrt8rW0r8qpz8msY+5N
O16V2QEaUrhyGXCiSaNxxnFIV5MEqdXDuEZzSQ==

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
