module top(input  logic        clk, reset,
           output logic [31:0] WriteData, Adr,
           output logic        MemWrite,
			  output logic [31:0] ReadData,
			  output logic [31:0] ALUResult); // test
  
  // определить процессор и общую память
  arm arm(clk, reset, MemWrite, Adr,
          WriteData, ReadData, 
			 ALUResult); // test
  mem mem(clk, MemWrite, Adr, WriteData, ReadData);
endmodule


