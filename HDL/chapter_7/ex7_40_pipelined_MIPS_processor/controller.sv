module controller(input  logic [5:0] op, funct, 
						output logic regwrite, memtoreg, memwrite, 
						output logic [2:0] alucontrol,
						output logic alusrc, regdst, jump, branch, RegClrD, 
						output logic [1:0] PCSrcD, 
						input logic EqualD);
						
  logic [1:0] aluop;
  logic pcsrc0;
  
  
  maindec md(op, memtoreg, memwrite, branch, 
             alusrc, regdst, regwrite, jump, aluop);
				 
  aludec ad(funct, aluop, alucontrol);
  
  assign pcsrc0 = branch & EqualD;
  assign PCSrcD = {jump, pcsrc0};
  assign RegClrD = pcsrc0 | jump;
  
  
endmodule
