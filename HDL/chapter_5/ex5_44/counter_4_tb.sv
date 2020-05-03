

module counter_4_tb();
	logic clk, reset;
  
  logic [31:0]q;
  
  // задание (определение) тестируемого 
  // устройства
  counter_4 dut(clk, reset, q);
   
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
	
	
	
  
  initial
    begin
      
      reset = 1; #7; reset = 0;
    end
   
  
  
endmodule
