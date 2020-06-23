// Конвейерные регистры

//Reg-file F
module regfileF (input logic clk, reset, nEN,
	input logic [31:0] PCW,
	output logic [31:0] PCF);
	always_ff @(posedge clk, posedge reset)
	if (reset) PCF <= 0;
	else if (nEN == 0) PCF <= PCW;
endmodule


// Reg-file D
module regfileD (input logic clk, reset, nEN, CLR,
	input logic [31:0] InstrF, PCPlus4F,
	output logic [31:0] InstrD, PCPlus4D);
	
	logic [63:0] q;
	
	assign {InstrD, PCPlus4D} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset | CLR) q <= 0;
	else if (nEN == 0) q <= {InstrF, PCPlus4F};
endmodule



// Reg-file E
module regfileE (input logic clk, reset, CLR,
						input logic RegWriteD, MemtoRegD, MemWriteD, 
						input logic [2:0] ALUControlD,
						input logic ALUSrcD, RegDstD,
						input logic [31:0] AD, BD,
						input logic [5:0] RsD, RtD, RdD,
						input logic [31:0] SignImmD,
						
						output logic RegWriteE, MemtoRegE, MemWriteE, 
						output logic [2:0] ALUControlE,
						output logic ALUSrcE, RegDstE,
						output logic [31:0] AE, BE,
						output logic [4:0] RsE, RtE, RdE,
						output logic [31:0] SignImmE);
	
	logic [108:0] q;
	
	assign {RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, AE, BE, RsE, RtE, RdE, SignImmE} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset | CLR) q <= 0;
	else q <= {RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, AD, BD, RsD, RtD, RdD, SignImmD};
endmodule



// Reg-file M
module regfileM (input logic clk, reset, 
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


// Reg-file W
module regfileW (input logic clk, reset, 
						input logic RegWriteM, MemtoRegM, 
						input logic [31:0] ReadDataM,
						input logic [31:0] ALUOutM,
						input logic [4:0] WriteRegM,
						
						output logic RegWriteW, MemtoRegW, 
						input logic [31:0] ReadDataW,
						input logic [31:0] ALUOutW,
						input logic [4:0] WriteRegW);
	
	logic [70:0] q;
	
	assign {RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW} = q;
	
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else q <= {RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM};
endmodule
