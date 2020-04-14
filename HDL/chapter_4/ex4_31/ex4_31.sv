module ex4_31(input  logic clk, 
               input  logic A, B, C, D,
               output logic X, Y);
  logic n1, n2;
  logic rega, regb, regc, regd;
  always_ff @(posedge clk)
    begin
      X <= n1; // блокирующее 
      Y <= n2; // блокирующее
		rega <= A;
		regb <= B;
		regc <= C;
		regd <= D;
	
    end
	 
	 assign n1 = (rega & regb) | regc;
	 assign n2 = ~(n1 | regd);
endmodule
