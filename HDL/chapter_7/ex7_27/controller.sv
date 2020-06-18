// Multicycle
// CONTROL UNIT
module controller(input logic clk, reset,
						input  logic [5:0] op, funct,
						output logic memwrite,
						output logic lord, irwrite, regdst, memtoreg,
                  output  logic regwrite, alusrca,
                  output logic [2:0]  alusrcb,
						output logic [2:0]  alucontrol,
						output logic pcen,
						output logic [1:0]	pcsrc,
						input logic        zero,
						output logic [3:0] state,
						output logic [1:0] lb);
						
						
	logic [1:0] aluop;
	logic branch;
	logic pcwrite;
	logic bne;
	
  maindecfsm md(clk, reset, op, memwrite,lord, irwrite, regdst, memtoreg,
            regwrite, alusrca, alusrcb, pcsrc, aluop, 
				branch, pcwrite, state, bne, lb);
				 
  aludec ad(funct, aluop, alucontrol);
  
  assign pcen = (bne & ~zero) | (branch & zero) | pcwrite;
  
endmodule
