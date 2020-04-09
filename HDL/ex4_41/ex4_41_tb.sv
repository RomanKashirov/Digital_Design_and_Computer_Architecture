

module ex4_41_tb();
	logic clk, start;
  logic a;
  logic q;
  
  // задание (определение) тестируемого 
  // устройства
  ex4_41 dut(clk, start, a, q);
   
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
  
  initial
    begin
      
      start = 1; #7; start = 0;
    end
   
  
  // активировать входы пошагово, 
  // с интервалом проверка результатов
  initial begin
    a = 1'b0;#13;
	 a = 1'b0;#13;
	 a = 1'b0;#13;
	 a = 1'b1;#13;
	 a = 1'b0;#13;
	 a = 1'b1;#13;
	 a = 1'b1;#13;
	 a = 1'b0;#13;
	 a = 1'b1;#13;
	 a = 1'b0;#13;
	 a = 1'b1;#13;
	 a = 1'b0;#13;
	 a = 1'b0;#13;
	 a = 1'b1;#13;
	 
    
  end
endmodule
