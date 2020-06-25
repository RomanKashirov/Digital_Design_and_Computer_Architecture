//ПАМЯТЬ КОМАНД
module imem(input  logic [5:0] a,
            output logic [31:0] rd);
  logic [31:0] RAM[63:0];
  initial
    $readmemh("D:/Git/Digital_Design_and_Computer_Architecture/HDL/chapter_7/ex7_40_pipelined_MIPS_processor/hazard_test.dat", RAM);
  assign rd = RAM[a]; // выровнять пословно
endmodule
