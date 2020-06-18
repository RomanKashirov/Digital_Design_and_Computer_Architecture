module maindecfsm(input logic clk, reset,
						input  logic [5:0] op,
						output logic memwrite,
						output logic lord, irwrite, regdst, memtoreg,
                  output  logic regwrite, alusrca,
                  output logic [2:0]  alusrcb,
						output logic [1:0]	pcsrc,
						output logic [1:0] aluop,
						output logic branch,
						output logic pcwrite,
						output logic [3:0] st,
						output logic bne,
						output logic [1:0] lb);
						
	logic [18:0] out;
	
	assign {memwrite, lord, irwrite, regdst, memtoreg, regwrite,
							alusrca, alusrcb, pcsrc, aluop, branch, pcwrite, bne, lb} = out;

	
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, 
										S7, S8, S9, S10, S11, S12, S13, S14, S15} statetype;
	statetype state, nextstate;
	
	assign st = state;

	// state register
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= S0;
		else state <= nextstate;


	// next state logic
	always_comb
		case (state)
			S0: nextstate<=S1;
			S1: case(op)       
					6'b000000: nextstate <= S6;  // инструкции R-типа
					6'b100011: nextstate <= S2; // lw
					6'b101011: nextstate <= S2; // sw
					6'b000100: nextstate <= S8; // beq
					6'b001000: nextstate <= S9; // addi
					6'b000010: nextstate <= S11; // j
					6'b000101: nextstate <= S12; // bne
					6'b100000: nextstate <= S2; //lb
					6'b100100: nextstate <= S2; //lbu
					6'b001100: nextstate <= S15; // andi
				default:   nextstate <= S0; // ???
				endcase
		   S2:  case(op)
					6'b100011: nextstate <= S3;
				   6'b101011: nextstate <= S5;
					6'b100000: nextstate <= S13;  // lb
					6'b100100: nextstate <= S14; //lbu
			    default:   nextstate <= S0; // ???
				 endcase
			S3: nextstate <= S4;
			S4: nextstate <= S0;
			S5: nextstate <= S0;
			S6: nextstate <= S7;
			S7: nextstate <= S0;
			S8: nextstate <= S0;
			S9: nextstate <= S10;
			S10: nextstate <= S0;
			S11: nextstate <= S0;
			S12: nextstate <= S0;
			S13: nextstate <= S4;
			S14: nextstate <= S4;
			S15: nextstate <= S10;
			default:   nextstate <= S0;
	endcase

//   memwrite, lord, irwrite, regdst, memtoreg, regwrite, alusrca, alusrcb,  pcsrc, aluop, branch, pcwrite,  bne  lb
//s0	0         0     1        0          0       0         0         001       00     00      0       1       0   00
//s1  0         0     0        0          0       0         0         011       00     00      0       0       0 	00
//s2  0         0     0        0          0       0         1         010       00     00      0       0       0	00
//s3  0         1     0        0          0...
//s4  0         0     0        0          1       1         0...
//s5  1         1     0...
//s6  0         0     0        0          0       0         1         000       00     10...                  
//s7  0         0     0        1          0       1         0...
//s8  0         0     0        0          0       0         1         000       01     01      1       0       0 	00                                            
//s9  0         0     0        0          0       0         1         010       0...
//s10 0         0     0        0          0       1         0..
//s11 0         0     0        0          0       0         0         000       10     00      0       1       0 	00              
//s12 0         0     0        0          0       0         1         000       01     01      0       0       1	00
//s13 0         1     0        0          0			0			0			000			00      00      0       0       0   01
//s14	0         1     0        0          0			0			0			000			00      00      0       0       0   10	
//s15 0         0     0        0          0       0         1         100       00     10...

 
	// output logic
	always_comb
		case (state)
			S0: out <= 19'b0010000001000001000;
			S1: out <= 19'b0000000011000000000;
		   S2: out <= 19'b0000001010000000000; 
			S3: out <= 19'b0100000000000000000;
			S4: out <= 19'b0000110000000000000;
			S5: out <= 19'b1100000000000000000;
			S6: out <= 19'b0000001000001000000;
			S7: out <= 19'b0001010000000000000;
			S8: out <= 19'b0000001000010110000;
			S9: out <= 19'b0000001010000000000;
		  S10: out <= 19'b0000010000000000000;
		  S11: out <= 19'b0000000000100001000;
		  S12: out <= 19'b0000001000010100100;
		  S13: out <= 19'b0100000000000000001;
		  S14: out <= 19'b0100000000000000010;
		  S15: out <= 19'b0000001100001000000;
	 default: out <= 19'bxxxxxxxxxxxxxxxxxxx;
	endcase
	
endmodule	
				 
  
  
