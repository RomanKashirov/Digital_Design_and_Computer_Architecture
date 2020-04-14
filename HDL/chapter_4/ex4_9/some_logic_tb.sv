module some_logic_tb();
	timeunit 1ns;
	timeprecision 1ns;
	
  logic a, b, c; logic out;
  
  // задание (определение) тестируемого 
  // устройства
  some_logic dut(a, b, c, out);
  // активировать входы пошагово, 
  // с интервалом проверка результатов
  initial begin
    a = 0; b = 0; c = 0; #10;
	 assert (out === 1) else $error("000 failed.");
	 
	 a = 0; b = 0; c = 1; #10;
	 assert (out === 0) else $error("001 failed.");
	 
	 a = 0; b = 1; c = 0; #10;
	 assert (out === 0) else $error("010 failed.");
	 
	 a = 0; b = 1; c = 1; #10;
	 assert (out === 1) else $error("011 failed.");
	 
	 a = 1; b = 0; c = 0; #10;
	 assert (out === 1) else $error("100 failed.");
	 
	 a = 1; b = 0; c = 1; #10;
	 assert (out === 1) else $error("101 failed.");
	 
	 a = 1; b = 1; c = 0; #10;
	 assert (out === 0) else $error("110 failed.");
	 
	 a = 1; b = 1; c = 1; #10;
	 assert (out === 0) else $error("111 failed.");
	 
    
  end
endmodule
