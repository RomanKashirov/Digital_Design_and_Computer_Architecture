// Многотактный MIPS-процессор

module mips(input logic clk, reset,
				output logic [31:0] PCF,
				input logic [31:0] InstrF, 
				output logic MemWriteM,
				output logic [31:0] AluOutM, WriteDataM,
				input logic [31:0] ReadDataM,
				output logic [31:0] InstrD, // test
				output logic StallD,				// test
				output logic [31:0] PCPlus4F, // test
				output logic MemWriteD,			// test
				output logic [31:0] rdBD,rdAD, AD, BD,			// test
				output logic [4:0] WriteRegW, // test
				output logic RegWriteW, // test
				output logic [31:0] ResultW, SrcAE, SrcBE, //test
				output logic [31:0] JampAdrrD,
				output logic EqualD); // test

	logic RegWriteD, MemtoRegD, ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, MemtoRegM;
	logic [2:0]ALUControlD;
	logic StallF, ForwardAD, ForwardBD, FlushE, MemtoRegE, RegWriteE, RegWriteM;
	logic [4:0] RsD, RtD, RsE, RtE;
	logic [1:0] ForwardAE, ForwardBE;
	logic [4:0] WriteRegE, WriteRegM;
	logic [1:0] PCSrcD;
//	logic [31:0] InstrD;

	controller c(InstrD[31:26], InstrD[5:0], RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, PCSrcD, EqualD);
				
	datapath dp(clk, reset, PCF, InstrD, InstrF, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, RegClrD, EqualD, 
				StallF, StallD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoRegE, RegWriteE, WriteRegM,
				RegWriteM, RegWriteW, WriteRegW,
				MemWriteM, AluOutM, WriteDataM, ReadDataM, PCSrcD, MemtoRegM, PCPlus4F, rdBD, rdAD, AD, BD,ResultW, SrcAE, SrcBE,
				JampAdrrD);
	
	
	hazard hu(StallF, StallD, BranchD, JumpD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoRegE, RegWriteE, WriteRegM,
				RegWriteM, WriteRegW, RegWriteW, MemtoRegM);
endmodule