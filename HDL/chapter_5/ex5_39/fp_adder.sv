module fp_adder(input  logic [31:0] a, input  logic [31:0] b,
                  output logic [31:0] y);
  
   logic [7:0] exp_a, exp_b, exp_big;
	logic [23:0] frac_big, frac_lil, frac_y;
	logic [24:0] temp_frac_y;
	
	
	assign exp_a = {a[30:23]};
	assign exp_b = {b[30:23]};
	
	assign frac_big = (exp_a >= exp_b)? {1'b1, a[22:0]} : {1'b1, b[22:0]};
	assign frac_lil = (exp_a >= exp_b)? {{1'b1, b[22:0]} >> (exp_a - exp_b)}: 
	{{1'b1, a[22:0]} >> (exp_b - exp_a)};
	assign exp_big = (exp_a >= exp_b)? exp_a: exp_b;
	
	
	
	always_comb
	begin
	temp_frac_y = frac_big + frac_lil;
	frac_y = temp_frac_y[23:0] >> temp_frac_y[24];
	y = {1'b0, exp_big + temp_frac_y[24], frac_y[22:0] };
	end
	
	
	
	
  
endmodule
