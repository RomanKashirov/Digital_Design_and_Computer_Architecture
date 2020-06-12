// Multicycle
module datapath(input  logic        clk, reset,
                input  logic        lord, irwrite,
                input  logic        regdst, memtoreg,
                input  logic        regwrite, alusrca,
					 input  logic [1:0]  alusrcb,
                input  logic [2:0]  alucontrol,
					 input logic 			pcen,
					 input logic [1:0]	pcsrc,
                output logic        zero, 
                output logic [31:0] adr,
                output logic [31:0] writedata,
                input  logic [31:0] readdata,
					 output logic [31:0] instr,
					 output logic [31:0] aluout,
					 output logic [31:0] pcnext); // отладка
					 
//	logic [31:0] pcnext; // test
	logic [31:0] pc;
	logic [31:0] data;
	logic [4:0] writereg;
	logic [31:0] writeregdata;
	logic [31:0] readdataa, readdatab, a;
	logic [31:0] signimm, signimmsh;
	logic [31:0] srca, srcb;
	logic [31:0] aluresult;
//	logic [31:0] aluout;   // отладка
	logic [31:0] addrsh;
	
	// логика адреса памяти
	flopen #(32)   pcreg(clk, reset, pcen, pcnext, pc);
	mux2 #(32)    adrmux(pc, aluout, lord, adr);
								 
  // логика регистрового файла
  flopen #(32)   instrreg(clk, reset, irwrite, readdata, instr);
  flopr #(32)   datareg(clk, reset, readdata, data);
  mux2 #(5)   wrmux(instr[20:16], instr[15:11], regdst, writereg);
  mux2 #(32)  wdregmux(aluout, data, memtoreg, writeregdata);
  signext     se(instr[15:0], signimm);
  regfile rf(clk, regwrite, instr[25:21], instr[20:16], 
  writereg, writeregdata, readdataa, readdatab);
  
   
  // логика АЛУ
  flopr #(32)   areg(clk, reset, readdataa, a);
  flopr #(32)   breg(clk, reset, readdatab, writedata);
  mux2 #(32)  srcamux(pc, a, alusrca, srca);
  sl2         immsh(signimm, signimmsh);
  mux4 #(32)  srcbmux(writedata, 32'b100, signimm, signimmsh, alusrcb, srcb);
  alu         alu(srca, srcb, alucontrol, aluresult, zero);
  
  // логика следующего pc
  sl2         addsh(instr, addrsh);
  flopr #(32)   alureg(clk, reset, aluresult, aluout);
  mux3 #(32)  pcmux(aluresult, aluout, {pc[31:28], addrsh[27:0]}, pcsrc, pcnext);
  
  
  
endmodule