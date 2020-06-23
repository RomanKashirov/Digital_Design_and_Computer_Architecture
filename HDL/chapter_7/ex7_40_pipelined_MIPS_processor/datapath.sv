// Тракт данных многотактного MIPS-процессора

module datapath(input logic clk, reset, 
					output logic [31:0] PCF, InstrD, 
					input logic RegWriteD, MemtoRegD, MemWriteD, 
					input logic [2:0] ALUControlD,
					input logic ALUSrcD, RegDstD, JumpD, BranchD, RegClrD, 
					output logic EqualD,
					input logic StallF, StallD, ForwardAD, ForwardBD, 
					output logic RsD, RtD, 
					input logic FlushE, 
					output logic RsE, RtE, 
					input logic [1:0] ForwardAE, ForwardBE, 
					output logic [4:0] WriteRegE, 
					output logic MemtoregE, RegWriteE, 
					output logic [4:0] WriteRegM,
					output logic RegWriteM, RegWriteW,
					output logic [4:0] WriteRegW,
					output logic MemWriteM,
					output logic [31:0] AluOutM, WriteDataM,
					input logic [31:0] ReadDataM); 
					 

	logic [31:0] PCW, PCPlus4F, PCPlus4D, ResultW, rdAD, rdBD, AD, BD, PCJumpD, SignImmD;
	
// Fetch stage
	pipregF pregF(clk, reset, StallF, PCW, PCF);	
	adder adderF(PCF, 32'd4, PCPlus4F);
	
// Decode stage
	pipregD pregD(clk, reset, StallD, RegClrD, InstrF, PCPlus4F, InstrD, PCPlus4D);
	regfile rfD(clk, RegWriteW, InstrD[25:21], InstrD[20:16], WriteRegW, 
			ResultW, rd1D, rd2D);	
	mux2 #(32) muxaD(rdAD, AluOutM, ForwardAD, AD);
	mux2 #(32) muxbD(rdBD, AluOutM, ForwardBD, BD);
	sl2 addshD(InstrD, PCJumpD);
	signext seD(InstrD[15:0], SignImmD);	
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
	
	// логика адреса памяти
	flopen #(32)   pcreg(clk, reset, pcen, pcnext, pc);
	mux2 #(32)    adrmux(pc, aluout, lord, adr);
								 
  // логика регистрового файла
  flopen #(32)   instrreg(clk, reset, irwrite, readdata, instr);
  flopr #(32)   datareg(clk, reset, rd, data);		//lb
  mux2 #(5)   wrmux(instr[20:16], instr[15:11], regdst, writereg);
  mux2 #(32)  wdregmux(aluout, data, memtoreg, writeregdata);
  signext     se(instr[15:0], signimm);
  regfile rf(clk, regwrite, instr[25:21], instr[20:16], 
  writereg, writeregdata, readdataa, readdatab);
  
  mux4 #(8)  databytemux(readdata[7:0], readdata[15:8], readdata[23:16], readdata[31:24], adr[1:0], readdatabyte);//lb
  signext7 se7(readdatabyte, readdata7ex); // lb
  mux3 #(32)  datamux(readdata, readdata7ex, readdataunex, lb, rd); //lb lbu
  
  unsignext7 unse(readdatabyte, readdataunex); // lbu
  
   
  // логика АЛУ
  flopr #(32)   areg(clk, reset, readdataa, a);
  flopr #(32)   breg(clk, reset, readdatab, writedata);
  mux2 #(32)  srcamux(pc, a, alusrca, srca);
  sl2         immsh(signimm, signimmsh);
  mux5_32  srcbmux(writedata, 32'b100, signimm, signimmsh, zeroeximm, alusrcb, srcb); // andi
  alu         alu(srca, srcb, alucontrol, aluresult, zero);
  zeroext ze(instr[15:0], zeroeximm); // andi
  
  
  // логика следующего pc
  sl2         addsh(instr, addrsh);
  flopr #(32)   alureg(clk, reset, aluresult, aluout);
  mux3 #(32)  pcmux(aluresult, aluout, {pc[31:28], addrsh[27:0]}, pcsrc, pcnext);
  
  
  
endmodule