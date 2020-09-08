// PIPLINED ARM PROCESSOR DATAPATH

module datapath (input logic clk, reset, 
						output logic [31:0] InstrD,
						input logic PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
						input logic [1:0] ALUControlD,
						input logic BranchD, ALUSrcD,
						input logic [1:0] FlagWriteD, ImmSrcD, RegSrcD,
						output logic [31:0] PCF, 
						input logic [31:0] InstrF,
						output logic [31:0] ALUOutM,
						output logic MemWriteM, 
						output logic [31:0] WriteDataM,
						input logic [31:0] ReadDataM,
						input logic StallF, StallD, FlushD, FlushE,
						input logic [1:0] ForwardAE, ForwardBE,
						output logic RegWriteM, RegWriteW, MemtoRegE,
						output logic Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E,
						output logic PCWrPendingF, PCSrcW, BranchTakenE); 

logic [31:0] NextPC, PCPlus4F, PCPlus8D; 
logic [3:0] RA1D, RA2D, WA3D;
logic [3:0] WA3W, RD1D, RD2D;
logic [31:0] ResultW, ExtImmD;
logic [3:0] CondD, CondE;
//logic [3:0] ALUFlags;
//logic [3:0] RA1D, RA2D, WA3E;
//logic [3:0] RA1E, RA2E, WA3M, WA3W;
//logic PCSrcD, PCSrcE, PCSrcM;

// Fetch

pipregF regF(clk, reset, StallF, NextPC, PCF);
adder #(32) pcaddF(PCF, 32'b100, PCPlus4F);
assign PCPlus8D = PCPlus4F;

// Decode

assign WA3D = InstrD[15:12];
pipregD regD (clk, reset, StallD, FlushD, InstrF, InstrD);
mux2 #(4) ra1muxD(InstrD[19:16], 4'b1111, RegSrcD[0], RA1D);
mux2 #(4) ra2muxD(InstrD[3:0], WA3D, RegSrcD[1], RA2D);
regfile rfD(clk, RegWriteW, RA1D, RA2D, WA3W, ResultW, PCPlus8D, RD1D, RD2D);
extend extD(InstrD[23:0], ImmSrcD, ExtImmD);

// Execute

assign CondD = InstrD[31:28];
pipregE regE (clk, reset, FlushE, 
					PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
					ALUControlD, BranchD, ALUSrcD, FlagWriteD,
					CondD, Flags,	
					RD1D, RD2D, WA3D, ExtImmD, RA1D, RA2D, 
					
					PCSrcE, RegWriteE, MemtoRegE, MemWriteE,
					ALUControlE, BranchE, ALUSrcE, FlagWriteE,
					CondE, FlagsE,	
					RD1E, RD2E, WA3E, ExtImmE, RA1E, RA2E);

// signals for hazard unit

assign Match_1E_M = (RA1E == WA3M);
assign Match_1E_W = (RA1E == WA3W);
assign Match_2E_M = (RA2E == WA3M);
assign Match_2E_W = (RA2E == WA3W);	
assign Match_12D_E = (RA1D == WA3E) | (RA2D == WA3E);
assign PCWrPendingF = PCSrcD | PCSrcE | PCSrcM;

endmodule


