

module up_down_counter_tb();
	logic clk, reset;
  logic up;
  logic [31:0]q;
  
  // задание (определение) тестируемого 
  // устройства
  up_down_counter dut(clk, reset, up, q);
   
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
	
	always
   begin
     up = 1; #50; up = 0; #50;
   end
	
  
  initial
    begin
      
      reset = 1; #7; reset = 0;
    end
   
  
  
endmodule
