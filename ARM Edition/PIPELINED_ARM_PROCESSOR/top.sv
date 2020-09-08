// TOP-LEVEL MODULE

module top(input logic clk, reset,
output logic [31:0] WriteDataM, ALUOutM, 
output logic MemWriteM); 

logic [31:0] PCF, InstrF, ReadDataM;

// instantiate processor and memories
arm arm(clk, reset, PCF, InstrF, ALUOutM, MemWriteM,
WriteDataM, ReadDataM);

imem imem(PCF, InstrF);

dmem dmem(clk, MemWriteM, ALUOutM, WriteDataM, ReadDataM); // DataAdr = ALUOutM
endmodule
