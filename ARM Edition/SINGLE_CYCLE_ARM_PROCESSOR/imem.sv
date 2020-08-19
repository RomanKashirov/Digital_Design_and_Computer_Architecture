//  INSTRUCTION MEMORY

module imem(input logic [31:0] a,
output logic [31:0] rd);
logic [31:0] RAM[63:0];
initial
$readmemh("D:/Git/Digital_Design_and_Computer_Architecture/ARM Edition/SINGLE_CYCLE_ARM_PROCESSOR/memfile.dat",RAM);
assign rd = RAM[a[31:2]]; // word aligned
endmodule
