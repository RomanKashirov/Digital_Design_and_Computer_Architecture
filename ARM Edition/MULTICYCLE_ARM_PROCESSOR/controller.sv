// УСТРОЙСТВО УПРАВЛЕНИЯ

module controller(input logic         clk, reset,
                  input logic [31:12] Instr,
                  output logic [1:0]  RegSrc,
                  output logic        RegWrite,
                  output logic [1:0]  ImmSrc,
                  output logic        ALUSrcA,
						output logic [1:0]  ALUSrcB,
						output logic [1:0]  ALUControl,
                  output logic        MemWrite,
						output logic 		  AdrSrc, PCWrite, IRWrite,
						input logic [3:0]   ALUFlags,
						output logic [1:0] ResultSrc);
						
	logic [1:0] FlagW;
	logic       PCS, NextPC, RegW, MemW;
  
	decoder dec(clk, reset, Instr[27:26], Instr[25:20],
         Instr[15:12], FlagW, PCS, NextPC, RegW, MemW,
         IRWrite, AdrSrc, ResultSrc, ALUSrcA, ALUSrcB, ImmSrc, RegSrc, ALUControl);
			
	condlogic cl(clk, reset, Instr[31:28], ALUFlags,
             FlagW, PCS, NextPC, RegW, MemW,
             PCWrite, RegWrite, MemWrite);
endmodule


