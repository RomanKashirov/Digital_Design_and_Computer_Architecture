// Multicycle
//МОДУЛЬ ВЕРХНЕГО УРОВНЯ ПРОЦЕССОРА MIPS
 module top(input  logic        clk, reset,
              output logic [31:0] writedata, adr,
              output logic        memwrite,
				  output logic [3:0] state,
				  output logic [2:0]  alusrcb,
				  output logic [31:0] aluout,
				  output logic [31:0] pc,
				  output logic [31:0] instr,
				  output logic [31:0] srca, srcb); // test
     logic [31:0] readdata;
     // задать процессор и память
     mips mips(clk, reset, adr, writedata, memwrite, readdata, state, alusrcb, 
	  aluout, pc, instr, srca, srcb); // test
	  
     mem mem(clk, memwrite, adr, writedata, readdata);
endmodule
