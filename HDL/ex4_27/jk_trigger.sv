module jk_trigger(input logic clk, reset,
            input logic j, k,
            output logic q);
  
  always_ff @(posedge clk, posedge reset)
   if (reset) q <= 0;
   else      
  
    case ({j, k})
      
      2'b01: q <= 0;
      2'b10: q <= 1;
      2'b11: q <= ~q;
        
      
    endcase
  
endmodule
