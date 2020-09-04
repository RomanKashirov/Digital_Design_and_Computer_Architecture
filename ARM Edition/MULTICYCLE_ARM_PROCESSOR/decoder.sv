// DECODER

module decoder(input logic clk, reset, 
					input logic  [1:0] Op,
               input logic  [5:0] Funct,
               input logic  [3:0] Rd,
               output logic [1:0] FlagW,
               output logic       PCS, NextPC, RegW, MemW,
               output logic       IRWrite, AdrSrc, 
               output logic [1:0] ResultSrc,
					output logic ALUSrcA,
					output logic [1:0] ALUSrcB, ImmSrc, RegSrc, ALUControl);
					
	logic [11:0]  controls;
	logic        Branch, ALUOp;
	assign {Branch, RegW, MemW, IRWrite, NextPC, AdrSrc, 
			ResultSrc, ALUSrcA, ALUSrcB, ALUOp} = controls;
	// Main FSM	
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11} statetype;
	statetype state, nextstate;
	
	// state register
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= S0;
		else state <= nextstate;


	// next state logic
	always_comb
		case (state)
			S0: nextstate<=S1;
			S1: case(Op)       
					2'b00: 	if (Funct[5] == 1'b1) nextstate <= S7;
								else nextstate <= S6;  // Data-processing instructions 
					2'b01: nextstate <= S2; // LDR, STR
					2'b10: nextstate <= S9; // sw
				 default:   nextstate <= S0; // ???
				endcase
		   S2:  	if (Funct[0] == 1'b1) nextstate <= S3;
					else nextstate <= S5;
			S3: nextstate <= S4;
			S4: nextstate <= S0;
			S5: nextstate <= S0;
			S6: nextstate <= S8;
			S7: nextstate <= S8;
			S8: nextstate <= S0;
			S9: nextstate <= S0;
			default:   nextstate <= S0;
	endcase
	
	// output logic
	always_comb
		case (state)
			S0: controls <= 12'b000110101100;
			S1: controls <= 12'b000000101100;
		   S2: controls <= 12'b000000000010; 
			S3: controls <= 12'b000001000000;
			S4: controls <= 12'b010000010000;
			S5: controls <= 12'b001001000000;
			S6: controls <= 12'b000000000001;
			S7: controls <= 12'b000000000011;
			S8: controls <= 12'b010000000000;
			S9: controls <= 12'b100000100010;
		 default: controls <= 12'bx;
	endcase
	
	// PC Logic
  assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

	// Instr Decoder
	logic [3:0] InstrDecOut;
	assign {RegSrc, ImmSrc} = InstrDecOut;
	always_comb
		begin          
			case(Op)
				2'b00: InstrDecOut = 4'b0000; 
				4'b01: InstrDecOut = 4'b1001; 
				4'b10: InstrDecOut = 4'bx110;
				4'b11: InstrDecOut = 4'bx;
				default: InstrDecOut = 2'bx;
			endcase
	end
	
	// ALU Decoder
  always_comb
  if (ALUOp) begin          // какая команда ОД?
     case(Funct[4:1])
         4'b0100: ALUControl = 2'b00; // ADD
         4'b0010: ALUControl = 2'b01; // SUB
         4'b0000: ALUControl = 2'b10; // AND
         4'b1100: ALUControl = 2'b11; // ORR
			default: ALUControl = 2'bx; // не реализовано
     endcase
     // обновить флаги, если bit S поднят
     // (C & V только для арифм. операций)
     FlagW[1] = Funct[0];
     FlagW[0] = Funct[0] &
       (ALUControl == 2'b00 | ALUControl == 2'b01);
  end else begin
     ALUControl = 2'b00; // для не ОД-команд
     FlagW = 2'b00;      // не обновлять флаги
  end				
			
endmodule	
					
  
   
  
  
  
  
  
  
  
  
  
	 