
module state_machine3_23(input logic clk, reset,
            input logic a, b,
            output logic y);
				
  typedef enum logic [1:0] {S0, S1, S2} statetype;
  
  statetype state, nextstate;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  
  // input logic
  always_comb
    case (state)
      S0: if (a) nextstate = S1;
          else       nextstate = S0;
			 
      S1: if (b) nextstate = S2;
          else       nextstate = S0;
			 
		S2: if (a & b) nextstate = S2;
          else       nextstate = S0;
      
      default:       nextstate = S0;
    endcase
	
// output logic	
 // assign y = (state == S2)&a&b;
 always_comb
    case (state)
      
      S2: if (a & b) y = 1;
          else       y = 0;
			 
      default:       y = 0;
  endcase
endmodule
