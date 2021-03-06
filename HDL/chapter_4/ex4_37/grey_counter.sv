
module grey_counter(input logic clk, reset,
            
            output logic [2:0] q);
				
  typedef enum logic [2:0] {S0 = 3'b000, 
									S1 = 3'b001, 
									S2 = 3'b011,
									S3 = 3'b010, 
									S4 = 3'b110, 
									S5 = 3'b111, 
									S6 = 3'b101, 
									S7 = 3'b100} statetype;
  
  statetype state, nextstate;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  
  // input logic
  always_comb
    case (state)
	 
      S0: nextstate = S1;
      S1: nextstate = S2;
      S2: nextstate = S3;
      S3: nextstate = S4;
		S4: nextstate = S5;
		S5: nextstate = S6;
		S6: nextstate = S7;
		S7: nextstate = S0;
      
      default: nextstate = S0;
    endcase
	
// output logic	
 
	assign q = state;
 
endmodule
