// TOP-LEVEL MODULE

module top(input logic clk, reset,
output logic [31:0] WriteData, DataAdr, PC,
output logic MemWrite,
output logic [31:0] SrcA); // test
logic [31:0] Instr, ReadData;
// instantiate processor and memories
arm arm(clk, reset, PC, Instr, MemWrite, DataAdr,
WriteData, ReadData,
SrcA); // test
imem imem(PC, Instr);
dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
