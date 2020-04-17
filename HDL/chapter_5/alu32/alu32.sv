// 32-битное АЛУ
module alu32 (input logic [31:0] a, b,
					input logic [2:0] f,
					output logic overflow,
					output logic zero,
					output logic [31:0] y);
					
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
		
		always_comb
		case(f[2:1])
		2'b01: overflow = ~a[31]&~b[31]&sum[31] | a[31]&b[31]&~sum[31];
		2'b11: overflow = ~a[31]&b[31]&sum[31] | a[31]&~b[31]&~sum[31];
		default: overflow = 1'b0;
		endcase
		
		endmodule
		
		
					