// Тракт данных многотактного MIPS-процессора

module datapath(input logic clk, reset, 
					output logic [31:0] PCF, InstrD, 
					input logic [31:0] InstrF, 
					input logic RegWriteD, MemtoRegD, MemWriteD, 
					input logic [2:0] ALUControlD,
					input logic ALUSrcD, RegDstD, RegClrD, 
					output logic EqualD,
					input logic StallF, StallD, ForwardAD, ForwardBD, 
					output logic [4:0]RsD, RtD, 
					input logic FlushE, 
					output logic [4:0]RsE, RtE, 
					input logic [1:0] ForwardAE, ForwardBE, 
					output logic [4:0] WriteRegE, 
					output logic MemtoRegE, RegWriteE, 
					output logic [4:0] WriteRegM,
					output logic RegWriteM, RegWriteW,
					output logic [4:0] WriteRegW,
					output logic MemWriteM,
					output logic [31:0] ALUOutM, WriteDataM,
					input logic [31:0] ReadDataM,
					input logic [1:0] PCSrcD,
					output logic MemtoRegM,
					output logic [31:0] PCPlus4F,
					output logic [31:0] rdBD, // test
					output logic [31:0] ResultW, // test
					output logic [31:0] SrcAE, SrcBE,
					output logic [31:0] JampAdrrD); // test
					 

	logic [31:0] PCnew, PCPlus4D, PCJumpD, rdAD, AD, BD,  SignImmD, SignImmshD,
						PCBranchD, WriteDataE, ALUOutE, AE, BE, SignImmE, ALUOutW, ReadDataW;
	logic [4:0]RdD, RdE;
	logic MemWriteE, ALUSrcE, RegDstE, MemtoRegW;
	logic [2:0]ALUControlE;
	assign RsD = InstrD[25:21];
	assign RtD = InstrD[20:16];
	assign RdD = InstrD[15:11];
	assign JampAdrrD = {PCPlus4D[31:28], PCJumpD[27:0]};
	
// Fetch stage
	pipregF pregF(clk, reset, StallF, PCnew, PCF);	
	adder adderF(PCF, 32'd4, PCPlus4F);
	
// Decode stage
	pipregD pregD(clk, reset, StallD, RegClrD, InstrF, PCPlus4F, InstrD, PCPlus4D);
	regfile rfD(clk, RegWriteW, InstrD[25:21], InstrD[20:16], WriteRegW, 
			ResultW, rdAD, rdBD);	
	mux2 #(32) muxaD(rdAD, ALUOutM, ForwardAD, AD);
	mux2 #(32) muxbD(rdBD, ALUOutM, ForwardBD, BD);
	sl2 addshD(InstrD, PCJumpD);
	signext seD(InstrD[15:0], SignImmD);	
	sl2 immshD(SignImmD, SignImmshD);
	adder adderD(SignImmshD, PCPlus4D, PCBranchD);
	comparator #(32) compD(AD, BD, EqualD);
					 
// Execute stage
	pipregE pregE(clk, reset, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, AD, BD, RsD, RtD, RdD, SignImmD,
												 RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, AE, BE, RsE, RtE, RdE, SignImmE);
	mux2 #(5) muxregE(RtE, RdE, RegDstE, WriteRegE);
	mux3 #(32) muxaE(AE, ResultW, ALUOutM, ForwardAE, SrcAE);
	mux3 #(32) muxbE(BE, ResultW, ALUOutM, ForwardBE, WriteDataE);
	mux2 #(32) muxaluE(WriteDataE, SignImmE, ALUSrcE, SrcBE);
	alu aluE(SrcAE, SrcBE, ALUControlE, ALUOutE);				 

//  Memory stage
	pipregM pregM(clk, reset, RegWriteE, MemtoRegE, MemWriteE, ALUOutE, WriteDataE, WriteRegE,
									  RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);
	
// Writeback stage
	pipregW pregW(clk, reset, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM,
								RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW);
	mux2 #(32) muxresW(ALUOutW, ReadDataW, MemtoRegW, ResultW);
	
	
// next PC logic
	mux3 #(32) muxPCnew(PCPlus4F, PCBranchD, JampAdrrD, PCSrcD, PCnew);



	
					 

endmodule