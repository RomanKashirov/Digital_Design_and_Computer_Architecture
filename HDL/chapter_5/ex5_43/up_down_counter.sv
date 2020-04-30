module up_down_counter 
                (input logic clk,
                 input logic reset,
					  input logic up,
                 output logic [31:0] q);
					  
					  logic [31:0] x;
	always_comb
		case(up)
		0: x = 32'hFFFFFFFF;
		1:	x = 32'h00000001;
		endcase
	
   always_ff @(posedge clk, posedge reset)
     if (reset)q <= 0;
     else      q <= q + x;
	  
	  
endmodule