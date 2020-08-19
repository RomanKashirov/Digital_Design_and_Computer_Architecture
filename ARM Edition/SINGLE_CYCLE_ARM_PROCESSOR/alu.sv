// 32-битное АЛУ

module alu (input logic [31:0] SrcA, SrcB,
				input logic [1:0] ALUControl,
				output logic [31:0] ALUResult,
				output logic [3:0] ALUFlags);
				
		logic neg, zero, carry, overflow;			
		logic [31:0] sum;
		assign ALUFlags = {neg, zero, carry, overflow}; 
		
		
		assign sum = SrcA + SrcB;
		assign zero = (ALUResult == 32'b0);
		assign neg = ALUResult[31];
		assign overflow = SrcA[31] & SrcB[31] & ~sum[31] |
                        ~SrcA[31] & ~SrcB[31] & sum[31];
		assign carry = (SrcA[31] | SrcB[31]) & ~sum[31];
		
		
		
		always_comb
		case(ALUControl[1:0])
		2'b00: ALUResult = SrcA & SrcB;
		2'b01: ALUResult = SrcA | SrcB;
		2'b10: ALUResult = sum;
		2'b11: ALUResult = sum[31];
		endcase
		
		
      
     
     

		
endmodule


// Negative, Zero, Carry, oVerflow

