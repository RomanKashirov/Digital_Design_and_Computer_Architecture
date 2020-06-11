// Multicycle
// CONTROL UNIT
module controller(input logic clk, reset,
						input  logic [5:0] op, funct,
						output logic memwrite,
						output logic lord, irwrite, regdst, memtoreg,
                  output  logic regwrite, alusrca,
                  output logic [1:0]  alusrcb,
						output logic [2:0]  alucontrol,
						output logic pcen,
						output logic [1:0]	pcsrc,
						input logic        zero);
						
						
	logic [1:0] aluop;
	logic branch;
	logic pcwrite;
	
  maindecfsm md(clk, reset, op, memwrite,lord, irwrite, regdst, memtoreg,
            regwrite, alusrca, alusrcb, pcen, pcsrc, aluop, 
				branch, pcwrite);
				 
  aludec ad(funct, aluop, alucontrol);
  
  assign pcen = (branch & zero) | pcwrite;
  
endmodule
