//Multicycle
module mips(input logic clk, reset,
				output logic [31:0] adr,
				output logic [31:0] writedata,
				output logic memwrite,
				input logic [31:0] readdata,
				output logic [3:0] state,
				output logic [1:0]  alusrcb,
				output logic [31:0] aluout,  // test
				output logic [31:0] pc,
				output logic [31:0] instr,
				output logic [31:0] srca, srcb); // test
				


	logic        lord, irwrite;
	logic        regdst, memtoreg;
	logic        regwrite, alusrca;
//	logic [1:0]  alusrcb;
	logic [2:0]  alucontrol;
	logic 			pcen;
	logic [1:0]	pcsrc;
	logic        zero; 
//	logic [31:0] instr;

	controller c(clk, reset, instr[31:26], instr[5:0], memwrite, lord, irwrite, regdst, 
					memtoreg, regwrite, alusrca, 
					alusrcb, alucontrol, pcen, pcsrc, zero, state);
					
	datapath dp(clk, reset, lord, irwrite, regdst, memtoreg,regwrite, alusrca, 
					alusrcb, alucontrol, pcen, pcsrc, zero, adr, writedata, readdata, instr, 
					aluout, pc, srca, srcb); // test
endmodule


