// Многотактный MIPS-процессор

module mips(input logic clk, reset,
				output logic [31:0] PCF,
				input logic [31:0] InstrF,
				output logic MemWriteM,
				output logic [31:0] AluOutM, WriteDataM,
				input logic [31:0] ReadDataM);

	logic RegWriteD, MemtoRegD, MemWriteD, 
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD;
	logic [2:0]ALUControlD;
	logic StallF, StallD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				  MemtoregE, RegWriteE, 
				RegWriteM, RegWriteW;
	logic [1:0] ForwardAE, ForwardBE;
	logic [4:0] WriteRegE, WriteRegM;

	controller c(InstrD[31:26], InstrD[5:0], RegWriteD, MemtoRegD, MemWriteD, ALUControlD[2:0],
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD);
				
	datapath dp(clk, reset, PCF, InstrD, InstrF, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD, 
				StallF, StallD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE, ForwardBE, WriteRegE, MemtoregE, RegWriteE, WriteRegM,
				RegWriteM, RegWriteW,
				MemWriteM, AluOutM, WriteDataM, ReadDataM);
	
	
	hazard hu(StallF, StallD, BranchD, JumpD, ForwardAD, ForwardBD, RsD, RtD, FlushE, RsE, RtE, 
				ForwardAE[1:0], ForwardBE[1:0], WriteRegE[4:0], MemtoregE, RegWriteE, WriteRegM[4:0],
				RegWriteM, RegWriteW);
endmodule