// Тракт данных многотактного MIPS-процессора

module datapath(input logic clk, reset, 
					output logic [31:0] PCF, InstrD, 
					input logic RegWriteD, MemtoRegD, MemWriteD, 
					input logic [2:0] ALUControlD,
					input logic ALUSrcD, RegDstD, RegClrD, 
					output logic EqualD,
					input logic StallF, StallD, ForwardAD, ForwardBD, 
					output logic [4:0]RsD, RtD, 
					input logic FlushE, 
					output logic RsE, RtE, 
					input logic [1:0] ForwardAE, ForwardBE, 
					output logic [4:0] WriteRegE, 
					output logic MemtoRegE, RegWriteE, 
					output logic [4:0] WriteRegM,
					output logic RegWriteM, RegWriteW,
					output logic [4:0] WriteRegW,
					output logic MemWriteM,
					output logic [31:0] ALUOutM, WriteDataM,
					input logic [31:0] ReadDataM); 
					 

	logic [31:0] PCW, PCPlus4F, PCPlus4D, ResultW, rdAD, rdBD, AD, BD, PCJumpD, SignImmD, SignImmshD,
						PCBranchD, SrcAE, WriteDataE, SrcBE, ALUOutE, AE, BE, SignImmE, ReadDataM, ALUOutW;
	logic [4:0]RdD, RdE;
	logic MemWriteE, ALUSrcE, RegDstE, MemtoRegM, MemtoRegW;
	logic [2:0]ALUControlE;
	assign RsD = InstrD[25:21];
	assign RtD = InstrD[20:16];
	assign RdD = InstrD[15:11];
	
// Fetch stage
	pipregF pregF(clk, reset, StallF, PCW, PCF);	
	adder adderF(PCF, 32'd4, PCPlus4F);
	
// Decode stage
	pipregD pregD(clk, reset, StallD, RegClrD, InstrF, PCPlus4F, InstrD, PCPlus4D);
	regfile rfD(clk, RegWriteW, InstrD[25:21], InstrD[20:16], WriteRegW, 
			ResultW, rd1D, rd2D);	
	mux2 #(32) muxaD(rdAD, AluOutM, ForwardAD, AD);
	mux2 #(32) muxbD(rdBD, AluOutM, ForwardBD, BD);
	sl2 addshD(InstrD, PCJumpD);
	signext seD(InstrD[15:0], SignImmD);	
	sl2 immshD(SignImmD, SignImmshD);
	adder adderD(SignImmshD, PCPlus4D, PCBranchD);
	comparator #(32) compD(AD, BD, EqualD);
					 
// Execute stage
	pipregE pregE(clk, reset, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, AD, BD, RsD, RtD, RdD, SignImmD,
												 RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, AE, BE, RsE, RtE, RdE, SignImmE);
	mux2 #(5) muxregE(RtE, RdE, RegDstE, WriteRegE);
	mux3 #(32) muxaE(AE, ResultW, AluOutM, ForwardAE, SrcAE);
	mux3 #(32) muxbE(BE, ResultW, AluOutM, ForwardBE, WriteDataE);
	mux2 #(32) muxaluE(WriteDataE, SignImmE, ALUSrcE, SrcBE);
	alu aluE(SrcAE, SrcBE, ALUControlE, AluOutE);				 

//  Memory stage
	pipregM pregM(clk, reset, RegWriteE, MemtoRegE, MemWriteE, ALUOutE, WriteDataE, WriteRegE,
									  RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);
	
// Writeback stage
	pipregW (clk, reset, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM,
								RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW);
	mux2 #(32) muxresW(ReadDataW, ALUOutW, MemtoRegW, ResultW);
	
	
	
	
	mux3 #(32) muxpcW(PCPlus4F, PCBranchD, PCJumpD, PCSrcD, PCW);



	
					 

endmodule