module maindecfsm(input logic clk, reset,
						input  logic [5:0] op,
						output logic memwrite,
						output logic lord, irwrite, regdst, memtoreg,
                  output  logic regwrite, alusrca,
                  output logic [1:0]  alusrcb,
						output logic pcen,
						output logic [1:0]	pcsrc,
						output logic aluop
						output logic branch,
						output logic pcwrite);
						
						
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11} statetype;
	statetype [3:0] state, nextstate;


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


	// output logic
	assign y=(state==S0);
	
endmodule	
				 
  
  
