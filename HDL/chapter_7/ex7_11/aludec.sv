module aludec(input  logic [5:0] funct,
              input  logic [1:0] aluop,
              output logic [3:0] alucontrol);
  always_comb
    case(aluop)
      2'b00: alucontrol <= 4'b0010; // add (для lw/sw/addi)
      2'b01: alucontrol <= 4'b1010; // sub (для beq)
		2'b11: alucontrol <= 4'b1011; // slt для SLTI
      default: case(funct)        // инструкции R-типа
          6'b100000: alucontrol <= 4'b0010; // add
          6'b100010: alucontrol <= 4'b1010; // sub
          6'b100100: alucontrol <= 4'b0000; // and
          6'b100101: alucontrol <= 4'b0001; // or
          6'b101010: alucontrol <= 4'b1011; // slt
			 6'b000000: alucontrol <= 4'b0100; // sll
          default:   alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
endmodule
