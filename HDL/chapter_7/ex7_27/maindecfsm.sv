module maindecfsm(input logic clk, reset,
						input  logic [5:0] op,
						output logic memwrite,
						output logic lord, irwrite, regdst, memtoreg,
                  output  logic regwrite, alusrca,
                  output logic [1:0]  alusrcb,
						output logic [1:0]	pcsrc,
						output logic [1:0] aluop,
						output logic branch,
						output logic pcwrite,
						output logic [3:0] st,
						output logic bne,
						output logic [1:0] lb);
						
	logic [17:0] out;
	
	assign {memwrite, lord, irwrite, regdst, memtoreg, regwrite,
							alusrca, alusrcb, pcsrc, aluop, branch, pcwrite, bne, lb} = out;

	
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, 
										S7, S8, S9, S10, S11, S12, S13, S14} statetype;
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
			default:   nextstate <= S0;
	endcase

//   memwrite, lord, irwrite, regdst, memtoreg, regwrite, alusrca, alusrcb,  pcsrc, aluop, branch, pcwrite,  bne  lb
//s0	0         0     1        0          0       0         0         01       00     00      0       1       0   00
//s1  0         0     0        0          0       0         0         11       00     00      0       0       0 	00
//s2  0         0     0        0          0       0         1         10       00     00      0       0       0	00
//s3  0         1     0        0          0...
//s4  0         0     0        0          1       1         0...
//s5  1         1     0...
//s6  0         0     0        0          0       0         1         00       00     10...                  
//s7  0         0     0        1          0       1         0...
//s8  0         0     0        0          0       0         1         00       01     01      1       0       0 	00                                            
//s9  0         0     0        0          0       0         1         10       0...
//s10 0         0     0        0          0       1         0..
//s11 0         0     0        0          0       0         0         00       10     00      0       1       0 	00              
//s12 0         0     0        0          0       0         1         00       01     01      0       0       1	00
//s13 0         1     0        0          0			0			0			00			00      00      0       0       0   01
//s14	0         1     0        0          0			0			0			00			00      00      0       0       0   10	
              
	// output logic
	always_comb
		case (state)
			S0: out <= 18'b001000001000001000;
			S1: out <= 18'b000000011000000000;
		   S2: out <= 18'b000000110000000000; 
			S3: out <= 18'b010000000000000000;
			S4: out <= 18'b000011000000000000;
			S5: out <= 18'b110000000000000000;
			S6: out <= 18'b000000100001000000;
			S7: out <= 18'b000101000000000000;
			S8: out <= 18'b000000100010110000;
			S9: out <= 18'b000000110000000000;
		  S10: out <= 18'b000001000000000000;
		  S11: out <= 18'b000000000100001000;
		  S12: out <= 18'b000000100010100100;
		  S13: out <= 18'b010000000000000001;
		  S14: out <= 18'b010000000000000010;
	 default: out <= 18'bxxxxxxxxxxxxxxxxxx;
	endcase
	
endmodule	
				 
  
  
