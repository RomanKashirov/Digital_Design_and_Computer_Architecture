module controller(input  logic [5:0] op, funct,
                  input  logic       zero, LTEZ,			// BLEZ
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc, 
						output logic [1:0] alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [3:0] alucontrol);
						
  logic [1:0] aluop;
  logic       branch;
  logic		BLEZ;														// BLEZ
  
  maindec md(op, memtoreg, memwrite, branch, BLEZ,			//BLEZ 
             alusrc, regdst, regwrite, jump, aluop);
				 
  aludec ad(funct, aluop, alucontrol);
  
  assign pcsrc = (branch & zero) | (BLEZ & LTEZ);			//BLEZ
  
endmodule
