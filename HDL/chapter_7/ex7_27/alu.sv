// 32-битное АЛУ
module alu (input logic [31:0] a, b,
				input logic [2:0] f,
				output logic [31:0] y,
				output logic zero);
					
		logic [31:0] b_temp, sum;
		
		assign b_temp = f[2]? ~b : b;
		assign sum = a + b_temp + f[2];
		assign zero = (y == 32'b0);
		
		always_comb
		case(f[1:0])
		2'b00: y = a & b_temp;
		2'b01: y = a | b_temp;
		2'b10: y = sum;
		2'b11: y = sum[31];
		endcase
		
endmodule
		
		
					