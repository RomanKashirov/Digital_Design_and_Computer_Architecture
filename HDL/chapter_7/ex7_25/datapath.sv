module datapath(input  logic        clk, reset,
                input  logic        lord, irwrite,
                input  logic        regdst, memtoreg,
                input  logic        regwrite, alusrca,
					 input  logic [1:0]  alusrcb,
                input  logic [2:0]  alucontrol,
					 input logic 			pcen,
					 input logic [1:0]	pcscr,
                output logic        zero, 
                output logic [31:0] adr,
                output logic [31:0] writedata,
                input  logic [31:0] readdata);
	logic [31:0] pcnext;
	logic [31:0] pc;
	logic [31:0] instr;
	logic [31:0] data;
	logic [4:0] writereg;
	logic [31:0] writeregdata;
	logic [31:0] readdata1, readdata2, a;
	logic [31:0] signimm, signimmsh;
	logic [31:0] srca, srcb;
	logic [31:0] aluresult, aluout;
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
  
  
  // закончил тут
  
  
  
  
  
  mux2 #(32)  srcbmux(writedata, signimm, alusrc, srcb);
  alu         alu(srca, srcb, alucontrol, aluout, zero);
endmodule