// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Fri Sep 18 18:54:10 2020
// Host        : WOLVEPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/KRZYSZTOF/Education/Studies/IV_term/Uklady-elektroniki-cyfrowej2/Project/memory_game/uec2_project/src/ip/multiplier/multiplier_sim_netlist.v
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
MJDFdm+M5/FNzremzjXQ6CIUdlKvYS5rjtxr26cStOrXEWCAuxP1bAwERlcyI1QBcDnM+fg/lV9a
UBLukIfCJViHUwh0qU2wsNJK7lMqZohuzPjPA/FitgqtXK5/3wBYf10BTiXlITTycAC3SrkapuYn
ulN0VL0/eBQA+Fj9csFPZ0ILYrcNfbiF6ufjkspSh4ZsO70T5VoUJWRDEN7TBVRTLo+WNOq5r21E
/sO7hfP8iMu0t20JBSPthPlelrGfAO+A0S8ZtcjUGP/XKDZ61lyTfkUCahdAAEWBpFhrC0+ONbLs
iTiXseOqVJxaPCYF8RdeMCLpcY/X4YAEejQ4kg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kXPzVBuE3banFWe9Dg9BsBt9yCFjARZxqkDnkRsH9GnWAY2T6vWv4Nve6pimLhO/9tM2MjsMczjO
vUPUHtFQtytWELeQKz1+ImLh3ursvGps5VFRqG9vVq1t2rVcJtSaGl28490Ol8nJPuo8zPIvJE4d
k2+Vp/MUIBoSAh+ZZQgWtMNmHCJ2iOexPa9iic3zTTYmvYhHw7w8yYPuZ/Gzh4tMsSAWC+RyWoom
dl2y08z/FvzHV2FMFGnB4QnDV+rmBt32mx6vKKEcnLUiMkESGgs2bI4RO7uM8DL9FKWwT4SARdqx
PzAW3DWSuC9tL+vHiMWZUKrMkTD1FyVzxfVDvg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7984)
`pragma protect data_block
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
O6gSsA==
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
