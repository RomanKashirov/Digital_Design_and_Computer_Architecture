module d_trigger(input  logic clk,
                    input  logic reset, set,
						  input  logic d,
                    output logic  q);

  always_ff @(posedge clk, posedge reset)
    if (reset) q = 0;
    else if(set) q = 1;
	 else q = d;
 
endmodule