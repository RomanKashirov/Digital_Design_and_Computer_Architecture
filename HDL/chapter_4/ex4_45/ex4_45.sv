module ex4_45(input  logic clk, C, A0, B0, A1, B1,
              output logic S0, S1);
				  
  logic a_0, b_0, c_0, a_1, b_1, c_1, s_0, s_1;
  
  fulladder f1(a_0, b_0, c_0, s_0, c_1), f2(a_1, b_1, c_1, s_1);
  
  
  always_ff @(posedge clk)
    begin
	 a_0 <= A0;
	 b_0 <= B0;
	 c_0 <= C;
	 a_1 <= A1;
	 b_1 <= B1;
	 S0 <= s_0;
	 S1 <= s_1;
	 
	 end
  
endmodule
