module sreg_trig(input  logic clk,
                    input  logic reset,
                    output logic  q0, q1, q2, q3);
	
  d_trigger t0(clk, 1'b0, reset, q3, q0);
  d_trigger t1(clk, reset, 1'b0, q0, q1);
  d_trigger t2(clk, reset, 1'b0, q1, q2);
  d_trigger t3(clk, reset, 1'b0, q2, q3);
  
 
 
endmodule