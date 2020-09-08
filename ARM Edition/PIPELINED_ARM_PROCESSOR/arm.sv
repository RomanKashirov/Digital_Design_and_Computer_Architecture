// PIPLINED ARM PROCESSOR

module arm(input  logic clk, reset,
				output logic [31:0] PCF, 
				input logic [31:0] InstrF,
				output logic [31:0] ALUOutM,
				output logic MemWriteM, 
				output logic [31:0] WriteDataM,
				input logic [31:0] ReadDataM);

logic [31:0] InstrD;
logic PCSrcD, RegWriteD, MemtoRegD, MemWriteD;
logic [1:0] ALUControlD;  
logic BranchD, ALUSrcD;
logic [1:0] FlagWriteD, ImmSrcD, RegSrcD;
logic StallF, StallD, FlushD, FlushE;
logic [1:0] ForwardAE, ForwardBE;
logic RegWriteM, RegWriteW, MemtoRegE;
logic Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E;
logic PCWrPendingF, PCSrcW, BranchTakenE;

				
controller c(clk, reset, InstrD[27:12], 
             PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
				 ALUControlD, BranchD, ALUSrcD, FlagWriteD,
				 ImmSrcD, RegSrcD);
				 
datapath dp(clk, reset, InstrD, 
             PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
				 ALUControlD, BranchD, ALUSrcD, FlagWriteD,
				 ImmSrcD, RegSrcD,
				 PCF, InstrF, ALUOutM, 
				 MemWriteM, WriteDataM, ReadDataM,
				 StallF, StallD, FlushD, FlushE, ForwardAE,
				 ForwardBE, RegWriteM, RegWriteW, MemtoRegE,
				 Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E,
				 PCWrPendingF, PCSrcW, BranchTakenE);
				 
hazard hu(Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E,
			RegWriteM, RegWriteW, MemtoRegE, PCWrPendingF,
			PCSrcW, BranchTakenE,
			StallF, StallD, FlushD, FlushE,
			ForwardAE, ForwardBE);
				
endmodule




