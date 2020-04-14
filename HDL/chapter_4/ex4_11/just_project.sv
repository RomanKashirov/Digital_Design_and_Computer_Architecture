module just_project(input  logic clk, reset,
            
            output logic q);
  
  
  
  
  always_ff @(posedge clk, posedge reset)
    if(reset) q <= 0;
    else q <= ~q;
    
endmodule
