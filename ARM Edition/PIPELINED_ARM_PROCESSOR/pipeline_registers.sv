// Конвейерные регистры

//Pipeline register F
module pipregF (input logic clk, reset, StallF,
	input logic [31:0] NextPC,
	output logic [31:0] PCF);
	
	always_ff @(posedge clk, posedge reset)
	if (reset) PCF <= 0;
	else if (StallF != 1) PCF <= NextPC;
	
endmodule


// Pipeline register D 
module pipregD (input logic clk, reset, StallD, FlushD,
					input logic [31:0] InstrF, 
					output logic [31:0] InstrD);
					
	always_ff @(posedge clk, posedge reset)
	if (reset) InstrD <= 0;
	else if (FlushD) InstrD <= 0;
	else if (StallD != 1 ) InstrD <= InstrF;
	
endmodule



// Pipeline register E
module pipregE (input logic clk, reset, FlushE,
					 input logic PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
					 input logic [1:0] ALUControlD, 
					 input logic BranchD, ALUSrcD, 
					 input logic [1:0] FlagWriteD,
					 input logic [3:0] CondD, Flags,	
					RD1D, RD2D, WA3D, ExtImmD, RA1D, RA2D, 
					
					PCSrcE, RegWriteE, MemtoRegE, MemWriteE,
					ALUControlE, BranchE, ALUSrcE, FlagWriteE,
					CondE, FlagsE,	
					RD1E, RD2E, WA3E, ExtImmE, RA1E, RA2E);
					
					
					PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
						input logic [1:0] ALUControlD,
						input logic BranchD, ALUSrcD,
						input logic [1:0] FlagWriteD
					
	
	logic [118:0] q;
	
	assign {RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, AE, BE, RsE, RtE, RdE, SignImmE} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else if (FlushE) q <= 0;
	else q <= {RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, AD, BD, RsD, RtD, RdD, SignImmD};
endmodule



// Pipeline register M
module pipregM (input logic clk, reset, 
						input logic RegWriteE, MemtoRegE, MemWriteE, 
						input logic [31:0] ALUOutE,
						input logic [31:0] WriteDataE,
						input logic [4:0] WriteRegE,
						
						output logic RegWriteM, MemtoRegM, MemWriteM, 
						output logic [31:0] ALUOutM,
						output logic [31:0] WriteDataM,
						output logic [4:0] WriteRegM);
	
	logic [71:0] q;
	
	assign {RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else q <= {RegWriteE, MemtoRegE, MemWriteE, ALUOutE, WriteDataE, WriteRegE};
endmodule


// Pipeline register W
module pipregW (input logic clk, reset, 
						input logic RegWriteM, MemtoRegM, 
						input logic [31:0] ReadDataM,
						input logic [31:0] ALUOutM,
						input logic [4:0] WriteRegM,
						
						output logic RegWriteW, MemtoRegW, 
						output logic [31:0] ReadDataW,
						output logic [31:0] ALUOutW,
						output logic [4:0] WriteRegW);
	
	logic [70:0] q;
	
	assign {RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else q <= {RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM};
endmodule
