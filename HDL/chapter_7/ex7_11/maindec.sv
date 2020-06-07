module maindec(input  logic [5:0] op,
               output logic       memtoreg, memwrite,
               output logic       branch, BLEZ, 			//BLEZ
					output logic [1:0] alusrc,
               output logic       regdst, regwrite,
               output logic       jump,
               output logic [1:0] aluop);
  logic [10:0] controls;
  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, aluop, BLEZ} = controls;
  always_comb
    case(op)
      6'b000000: controls <= 11'b11000000100; // RTYPE
      6'b100011: controls <= 11'b10010010000; // LW
      6'b101011: controls <= 11'b00010100000; // SW
      6'b000100: controls <= 11'b00001000010; // BEQ
      6'b001000: controls <= 11'b10010000000; // ADDI
      6'b000010: controls <= 11'b00000001000; // J
		6'b001111: controls <= 11'b10100000000;	// LUI
		6'b001010: controls <= 11'b10010000110; // SLTI
		6'b000110: controls <= 11'b00000000011; // BLEZ
      default:   controls <= 11'bxxxxxxxxxxx; // недействит.инстр.
    endcase
endmodule