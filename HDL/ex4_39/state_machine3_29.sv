
module state_machine3_29(input logic clk, reset,
            input logic a, b,
            output logic q);
				
  typedef enum logic  {S0 = 1'b0, 
							  S1 = 1'b1 
							  } statetype;
  
  statetype state, nextstate;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  
  // input logic
  always_comb
    case (a)
	 
      1'b0: nextstate = S0;
      1'b1: nextstate = S1;
            
      default: nextstate = S0;
    endcase
	
// output logic	
 
	assign q = ~b & a & state | b & (a | state);
 
endmodule
