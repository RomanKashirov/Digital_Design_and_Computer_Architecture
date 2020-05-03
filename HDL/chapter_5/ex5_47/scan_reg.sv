module scan_reg (input logic clk,
                 input logic test,
					  input logic sin,
					  input logic [3:0] D,
					  
                 output logic sout,
					  output logic [3:0] q);
					  
					  logic s0, s1, s2;
					  
scan_trigg str0(clk, test, D[0], sin, q[0]), 
str1(clk, test, D[1], q[0], q[1]), 
str2(clk, test, D[2], q[1], q[2]), 
str3(clk, test, D[3], q[2], q[3]);

assign sout = q[3];
   
endmodule



module scan_trigg (input logic clk,
                 
					  input logic test,
					  input logic D,
					  input logic sin,
					  
                 output logic q);
					  
					  
		always_ff @(posedge clk)
           if (test) q <= sin;
	  else q <= D;
  
endmodule

