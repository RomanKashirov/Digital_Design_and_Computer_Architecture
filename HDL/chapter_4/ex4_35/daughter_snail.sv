
module daughter_snail(input logic clk, reset,
            input logic in,
            output logic q);
				
  typedef enum logic [2:0] {S0, S1, S2, S3, S4} statetype;
  
  statetype state, nextstate;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  
  // input logic
  always_comb
    case (state)
      S0: if (in) nextstate = S1;
          else    nextstate = S0;
			 
      S1: if (in) nextstate = S2;
          else    nextstate = S0;
			 
		S2: if (in) nextstate = S4;
          else    nextstate = S3;
		
		S3: if (in) nextstate = S1;
          else    nextstate = S0;
			 
		S4: if (in) nextstate = S4;
          else    nextstate = S3;
      
      default:    nextstate = S0;
    endcase
	
// output logic	
 
 always_comb
    case (state)
      
      S3: if (in) q = 1;
          else    q = 0;
			 
		S4: if (in) q = 0;
          else    q = 1;
			 
      default:    q = 0;
  endcase
endmodule
