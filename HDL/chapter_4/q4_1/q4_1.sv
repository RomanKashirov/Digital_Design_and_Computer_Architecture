module q4_1(input  logic [31:0] data, 
				input logic sel,
                  output logic [31:0] result);
         
         assign result = sel ? data : 32'b0;  
			
         
      endmodule
