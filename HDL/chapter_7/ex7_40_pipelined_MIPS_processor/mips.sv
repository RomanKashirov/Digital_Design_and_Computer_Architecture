// Многотактный MIPS-процессор

module mips(input logic clk, reset,
				output logic [31:0] PCF,
				input logic [31:0] InstrF, 
				output logic MemWriteM,
				output logic [31:0] AluOutM, WriteDataM,
				input logic [31:0] ReadDataM);

	logic RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD, MemtoRegM;
	logic [2:0]ALUControlD;
	logic StallF, StallD, ForwardAD, ForwardBD, FlushE, MemtoRegE, RegWriteE, RegWriteM, RegWriteW;
	logic [4:0] RsD, RtD, RsE, RtE;
	logic [1:0] ForwardAE, ForwardBE;
	logic [4:0] WriteRegE, WriteRegM, WriteRegW;
	logic [1:0] PCSrcD;
	logic [31:0] InstrD;

	controller c(InstrD[31:26], InstrD[5:0], RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, PCSrcD, EqualD);
				
	datapath dp(clk, reset, PCF, InstrD, InstrF, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, RegClrD, EqualD, 
				StallF, StallD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoRegE, RegWriteE, WriteRegM,
				RegWriteM, RegWriteW, WriteRegW,
				MemWriteM, AluOutM, WriteDataM, ReadDataM, PCSrcD, MemtoRegM);
	
	
	hazard hu(StallF, StallD, BranchD, JumpD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoRegE, RegWriteE, WriteRegM,
				RegWriteM, WriteRegW, RegWriteW, MemtoRegM);
endmodule