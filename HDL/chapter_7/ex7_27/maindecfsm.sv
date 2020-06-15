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
						output logic [3:0] st);
						
	logic [14:0] out;
	
	assign {memwrite, lord, irwrite, regdst, memtoreg, regwrite,
							alusrca, alusrcb, pcsrc, aluop, branch, pcwrite} = out;

	
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11} statetype;
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
				default:   nextstate <= S0; // ???
				endcase
		   S2:  if (op == 6'b100011) nextstate <= S3;
				else nextstate <= S5;
			S3: nextstate <= S4;
			S4: nextstate <= S0;
			S5: nextstate <= S0;
			S6: nextstate <= S7;
			S7: nextstate <= S0;
			S8: nextstate <= S0;
			S9: nextstate <= S10;
			S10: nextstate <= S0;
			S11: nextstate <= S0;
			default:   nextstate <= S0;
	endcase

//   memwrite, lord, irwrite, regdst, memtoreg, regwrite, alusrca, alusrcb,  pcsrc, aluop, branch, pcwrite
//s0	0         0     1        0          0       0         0         01       00     00      0       1    
//s1  0         0     0        0          0       0         0         11       00     00      0       0        
//s2  0         0     0        0          0       0         1         10       00     00      0       0
//s3  0         1     0        0          0...
//s4  0         0     0        0          1       1         0...
//s5  1         1     0...
//s6  0         0     0        0          0       0         1         00       00     10...                  
//s7  0         0     0        1          0       1         0...
//s8  0         0     0        0          0       0         1         00       01     01      1       0                                                      
//s9  0         0     0        0          0       0         1         10       0...
//s10 0         0     0        0          0       1         0..
//s11 0         0     0        0          0       0         0         00       10     00      0       1                      


              
	// output logic
	always_comb
		case (state)
			S0: out <= 15'b001000001000001;
			S1: out <= 15'b000000011000000;
		   S2: out <= 15'b000000110000000; 
			S3: out <= 15'b010000000000000;
			S4: out <= 15'b000011000000000;
			S5: out <= 15'b110000000000000;
			S6: out <= 15'b000000100001000;
			S7: out <= 15'b000101000000000;
			S8: out <= 15'b000000100010110;
			S9: out <= 15'b000000110000000;
		  S10: out <= 15'b000001000000000;
		  S11: out <= 15'b000000000100001;
	 default: out <= 15'bxxxxxxxxxxxxxxx;
	endcase
	
endmodule	
				 
  
  
