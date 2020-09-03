// MULTICYCLE DATAPATH

module datapath (input logic clk, reset, 
						output logic [31:0] Instr,
						input logic [1:0] RegSrc, 
						input logic RegWrite, 
						input logic [1:0] ImmSrc,
						input logic ALUSrcA, 
						input logic [1:0] ALUSrcB, ALUControl,
						input logic AdrSrc, PCWrite, IRWrite,
						output logic [31:0] Adr, WriteData, 
						input logic [31:0] ReadData,
						output logic [3:0] ALUFlags,
						input logic [1:0] ResultSrc)
	
	logic [31:0] PCnext, PC, Result;
	logic [31:0] Data;
	logic [3:0] RA1, RA2;
	logic [31:0] RD1, RD2, A, ExtImm;
	logic [31:0] SrcA, SrcB, ALUResult, ALUOut;
	
						
	// next PC logic
	flopenr #(32)   pcreg(clk, reset, PCWrite, PCnext, PC);
	mux2 #(32)    adrmux(PC, Result, AdrSrc, Adr);
	
	
	// register file logic
	flopenr #(32)   instrreg(clk, reset, IRWrite, ReadData, Instr);
	flopr #(32)   datareg(clk, reset, ReadData, Data);
	mux2 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
	mux2 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
	regfile rf(clk, RegWrite, RA1, RA2, Instr[15:12], Result, Result, RD1, RD2);
	extend ext(Instr[23:0], ImmSrc, ExtImm);
	
	// ALU logic
	flopr #(32)   areg(clk, reset, RD1, A);
	flopr #(32)   breg(clk, reset, RD2, WriteData);
	mux2 #(32)  srcamux(A, PC, ALUSrcA, SrcA);
	mux3 #(32)  srcbmux(WriteData, ExtImm, 32'b100, ALUSrcB, SrcB);
	alu alu(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);
	
	// Result logic
	flopr #(32)   resreg(clk, reset, ALUResult, ALUOut);
	mux3 #(32)  resmux(ALUOut, Data, ALUResult, ResultSrc, Result);

endmodule


