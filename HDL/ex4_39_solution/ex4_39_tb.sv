

module ex4_39_tb();
	logic clk, reset;
  logic a, b;
  logic q;
  
  // задание (определение) тестируемого 
  // устройства
  ex4_39 dut(clk, reset, a, b, q);
   
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
  
  initial
    begin
      
      reset = 1; #11; reset = 0;
    end
   
  
  // активировать входы пошагово, 
  // с интервалом проверка результатов
  initial begin
    {a, b} = 2'b00;#13;
	 {a, b} = 2'b10;#13;
	 {a, b} = 2'b10;#13;
	 {a, b} = 2'b01;#13;
	 {a, b} = 2'b00;#13;
	 {a, b} = 2'b11;#13;
	 {a, b} = 2'b01;#13;
	 {a, b} = 2'b00;#13;
	 {a, b} = 2'b10;#13;
	 {a, b} = 2'b11;#13;
	 {a, b} = 2'b10;#13;
	 {a, b} = 2'b01;#13;
    
  end
endmodule
