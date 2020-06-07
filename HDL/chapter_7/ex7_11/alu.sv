// 32-битное АЛУ
module alu (input logic [31:0] a, b,
				input logic [3:0] alu_control,
				input logic [4:0] shamt,
				output logic [31:0] y,
				output logic zero,
				output logic LTEZ);
					
		logic [31:0] b_temp, sum;
		
		assign b_temp = alu_control[3]? ~b : b;
		assign sum = a + b_temp + alu_control[3];
		assign zero = (y == 32'b0);
		assign LTEZ = zero | y[31];
		
		always_comb
		case(alu_control[2:0])
		3'b000: y = a & b_temp;
		3'b001: y = a | b_temp;
		3'b010: y = sum;
		3'b011: y = sum[31];
		3'b100: y = (b_temp << shamt); // SLL
		default:   y = 31'bx; 
		
		endcase
		
endmodule
		
		
					