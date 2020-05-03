module counter_4 #(parameter N = 32)
                (input logic clk,
                 input logic reset,
					  input logic Load,
					  input logic [N-1:0] D,
					  
                 output logic [N-1:0] q);
   always_ff @(posedge clk, posedge reset)
     if (reset)q <= 0;
     else      if (Load) q <= D;
	  else q <= {q[31:2] + 1, 2'b00};
endmodule
