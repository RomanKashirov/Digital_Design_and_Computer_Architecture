module Light_Controller(input logic clk, reset,
            input logic Ta, Tb,
            output logic [1:0] La, output logic [1:0] Lb);
				
  logic [1:0] state, nextstate;
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  always_comb
    case (state)
      S0: begin
			 La = 2'b00; 
			 Lb = 2'b10;
			 if (Ta == 0) nextstate = S1; 
          else       nextstate = S0;
			 end
			 
      S1: begin 
			 La = 2'b01; 
			 Lb = 2'b10;
			 nextstate = S2;
			 end
		
      S2: begin 
			 La = 2'b10; 
			 Lb = 2'b00;
			 if (Tb == 0) nextstate = S3;
          else       nextstate = S2;
			 end
			 
      S3: begin
			 La = 2'b10; 
			 Lb = 2'b01;
			 nextstate = S0;
			 end
      
      default:  nextstate = S0;
    endcase
	 
  

endmodule
