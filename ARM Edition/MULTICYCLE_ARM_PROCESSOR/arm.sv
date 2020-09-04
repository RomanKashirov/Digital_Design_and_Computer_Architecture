// MULTICYCLE ARM PROCESSOR

module arm(input  logic clk, reset,
				output logic MemWrite, 
				output logic [31:0] Adr, WriteData,
				input logic [31:0] ReadData,
				output logic [31:0] ALUResult); // test
				
logic [31:0] Instr;
logic [1:0] RegSrc, ImmSrc, ALUSrcB, ALUControl;  
logic RegWrite, ALUSrcA, AdrSrc, PCWrite, IRWrite;
logic [3:0] ALUFlags;
logic [1:0] ResultSrc;
logic Shift;
				
controller c(clk, reset, Instr[31:12], 
             RegSrc, RegWrite, ImmSrc,
             ALUSrcA, ALUSrcB, ALUControl,
             MemWrite, AdrSrc, PCWrite, IRWrite, ALUFlags, ResultSrc, Shift);
				 
datapath dp(clk, reset, Instr, 
             RegSrc, RegWrite, ImmSrc,
             ALUSrcA, ALUSrcB, ALUControl,
             AdrSrc, PCWrite, IRWrite,
				 Adr, WriteData, ReadData, ALUFlags, ResultSrc, 
				 ALUResult, // test	
				 Shift);			
endmodule




