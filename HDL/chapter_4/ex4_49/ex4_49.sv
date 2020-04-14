module ex4_49(input  logic clk, a, b, c,
                output logic y, z);
     logic x;
     always_ff @(posedge clk) begin
      
		x = a & b;
		y = x | c;
      z = x; 
     end
   
	
	
	
endmodule