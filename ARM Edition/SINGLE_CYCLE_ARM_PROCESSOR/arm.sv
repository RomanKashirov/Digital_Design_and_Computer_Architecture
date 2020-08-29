//  ОДНОТАКТНЫЙ ПРОЦЕССОР

module arm(input  logic        clk, reset,
           output logic [31:0] PC,
           input  logic [31:0] Instr,
           output logic        MemWrite,
           output logic [31:0] ALUResult, WriteData,
           input  logic [31:0] ReadData,
			  output logic [31:0] SrcA); // test
logic [3:0] ALUFlags;
logic       RegWrite, ShftCtrl,
            ALUSrc, MemtoReg, PCSrc;
logic [1:0] RegSrc, ImmSrc, ALUControl;
controller c(clk, reset, Instr[31:12], ALUFlags,
             RegSrc, RegWrite, ImmSrc,
             ALUSrc, ALUControl,
             MemWrite, MemtoReg, PCSrc, ShftCtrl);
datapath dp(clk, reset,
            RegSrc, RegWrite, ImmSrc,
            ALUSrc, ALUControl,
            MemtoReg, PCSrc,
            ALUFlags, PC, Instr,
            ALUResult, WriteData, ReadData, ShftCtrl,
				SrcA); // test
endmodule