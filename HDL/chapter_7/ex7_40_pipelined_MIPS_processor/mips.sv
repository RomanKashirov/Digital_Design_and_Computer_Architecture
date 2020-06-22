// Многотактный MIPS-процессор

module mips(input logic clk, reset,
				output logic [31:0] pc,
				input logic [31:0] instr,
				output logic memwrite,
				output logic [31:0] aluout, writedata,
				input logic [31:0] readdata);

	logic RegWriteD, MemtoRegD, MemWriteD, 
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD;
	logic ALUControlD[2:0];

	controller c(instr[31:26], instr[5:0], RegWriteD, MemtoRegD, MemWriteD, ALUControlD[2:0],
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD);
				
	datapath dp(clk, reset, instr, RegWriteD, MemtoRegD, MemWriteD, ALUControlD[2:0],
				ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, EqualD 
				StallF, StallD, ForwardAD, ForwardBD);

				
				
				
				
				
				
				
				
//				
logic memtoreg, alusrc, regdst,
regwrite, jump, pcsrc, zero;

logic [2:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero,
				memtoreg, memwrite, pcsrc,
				alusrc, regdst, regwrite, jump,
				alucontrol);
				
datapath dp(clk, reset, memtoreg, pcsrc,
				alusrc, regdst, regwrite, jump,
				alucontrol,
				zero, pc, instr,
				aluout, writedata, readdata);
endmodule