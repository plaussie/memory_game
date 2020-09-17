// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Thu Sep 17 13:04:08 2020
// Host        : LAPTOP-IVH6M5RF running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/dzial/Documents/Mikroelektronika_AGH/II_rok/IV_semestr/UEC/project_uec/uec2_project/src/ip/multiplier/multiplier_sim_netlist.v
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
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
oKRbmKlaqjpXLdYsQ7Gb7AyiVrx1gDdoAlKqYpNbsHa92rmFb1O1giVKbQYukMGe9ANccPq5xQXj
9mOt8yk/zNrg2C5VvNAsTtjsknCuZDPQvZUWQc2Efc26qFNfD2YLLkpMBLRVneoGI6ug0SwTBGO7
nPPqcl0tn0d6rIxSUHVmRePWG9EqFGN0JpRSFJ5zlIhrWg22BpFlgNnW06OJ9y4njt3z0LTDwIaC
EY3ykRHpc9amyKFpsAcGGA9CN/zsaaIE56oyQAkxLw1i76t6oPkOFnX33VRLcMFiqOU+0Cbxn+BB
SmJoYTDLYe0/caY7nIIEXtaMJFePxTwNUUJIhA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XOHa7IpkqOroQAWbaY8XKcXbftIZBplxj7564smlgqEEe9IAd8HCg4CBJWpwZT60S+QnM4itpoXR
OuJRl1vjqIxKqw3nat28Fbi2CPhL89A/hwSlOwXcg1h7kwFF1ilvwi8fA9e5DfD/cf//jb3Z4Geq
W6R2tvTOQWNAL6h5oJG/BR8U/SYEuDB442q3PIv9oIfq4x0wKL3vfBezXMGEWnPUQunkKpVXNj2A
Z919vG1aUhKKN8tW6bkgEgUbQjBpk+V61OzMXR4lT228W5aCzwq4uG8Co/sgGARQxug33FYpVnUY
/Yh0PLmo1pVOz/e5N8ut/kXUvvR6ed5ILx10rg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7984)
`pragma protect data_block
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
ckUqFQ==
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
