module some_logic(input  logic a, b, c,
            
            output logic  y);
				
				
  
  mux8 muxic_8({a, b, c}, 1, 0, 0, 1, 1, 1, 0, 0, y);
  
endmodule
