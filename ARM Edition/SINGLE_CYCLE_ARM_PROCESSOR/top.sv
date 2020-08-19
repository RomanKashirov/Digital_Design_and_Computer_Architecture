// TOP-LEVEL MODULE

module top(input logic clk, reset,
output logic [31:0] WriteData, DataAdr, PC,
output logic MemWrite);
logic [31:0] Instr, ReadData;
// instantiate processor and memories
arm arm(clk, reset, PC, Instr, MemWrite, DataAdr,
WriteData, ReadData);
imem imem(PC, Instr);
dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
