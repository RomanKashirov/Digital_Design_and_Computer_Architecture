// Многотактный MIPS-процессор

module mips(input logic clk, reset,
				output logic [31:0] PCF,
				input logic [31:0] InstrF, InstrD,
				output logic MemWriteM,
				output logic [31:0] AluOutM, WriteDataM,
				input logic [31:0] ReadDataM);

	logic RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD;
	logic [2:0]ALUControlD;
	logic StallF, StallD, ForwardAD, ForwardBD, FlushE, MemtoregE, RegWriteE, RegWriteM, RegWriteW;
	logic [4:0] RsD, RtD, RsE, RtE;
	logic [1:0] ForwardAE, ForwardBE;
	logic [4:0] WriteRegE, WriteRegM, WriteRegW;
	logic [1:0] PCSrcD;

	controller c(InstrD[31:26], InstrD[5:0], RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, PCSrcD, EqualD);
				
	datapath dp(clk, reset, PCF, InstrD, InstrF, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, RegClrD, EqualD, 
				StallF, StallD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoregE, RegWriteE, WriteRegM,
				RegWriteM, RegWriteW, WriteRegW,
				MemWriteM, AluOutM, WriteDataM, ReadDataM, PCSrcD);
	
	
	hazard hu(StallF, StallD, BranchD, JumpD, ForwardAD, ForwardBD, RsD[4:0], RtD[4:0], FlushE, RsE[4:0], RtE[4:0], 
				ForwardAE[1:0], ForwardBE[1:0], WriteRegE[4:0], MemtoregE, RegWriteE, WriteRegM[4:0],
				RegWriteM, WriteRegW[4:0], RegWriteW);
endmodule