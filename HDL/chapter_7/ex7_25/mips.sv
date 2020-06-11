//Multicycle
module mips(input logic clk, reset,
				output logic [31:0] adr,
				output logic memwrite,
				output logic [31:0] writedata,
				input logic [31:0] readdata);
				


	logic        lord, irwrite;
	logic        regdst, memtoreg;
	logic        regwrite, alusrca;
	logic [1:0]  alusrcb;
	logic [2:0]  alucontrol;
	logic 			pcen;
	logic [1:0]	pcsrc;
	logic        zero; 
	logic [31:0] instr;

	controller c(clk, reset, instr[31:26], instr[5:0], memwrite, lord, irwrite, regdst, 
					memtoreg, regwrite, alusrca, 
					alusrcb, alucontrol, pcen, pcsrc, zero);
					
	datapath dp(clk, reset, lord, irwrite, regdst, memtoreg,regwrite, alusrca, 
					alusrcb, alucontrol, pcen, pcsrc, zero, adr, writedata, readdata, instr);
endmodule


