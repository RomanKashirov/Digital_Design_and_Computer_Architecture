module grey_counter_tb();
  logic clk, reset;
  logic [2:0] q;
  
  
  grey_counter dut(clk, reset, q);
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
  
  
  
  initial
    begin
      
      reset = 1; #11; reset = 0;
    end
 endmodule