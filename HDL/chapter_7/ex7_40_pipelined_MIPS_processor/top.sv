//МОДУЛЬ ВЕРХНЕГО УРОВНЯ ПРОЦЕССОРА MIPS
module top(input  logic        clk, reset,
           output logic [31:0] writedata, dataadr, instr, readdata,
           output logic        memwrite,
			  output logic [31:0] instrD,
			  output logic stallD,
			  output logic [31:0] PCPlus4F,
			  output logic MemWriteD,
			  output logic [31:0] rdBD);
  logic [31:0] pc;
  // определить процессор и память
  mips mips(clk, reset, pc, instr, memwrite, dataadr,
            writedata, readdata, instrD, stallD, PCPlus4F, MemWriteD, rdBD);
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule
