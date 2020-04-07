module temp_tb();
  logic a, b, y;
  // задание (определение) тестируемого 
  // устройства
  temp dut(a, b, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
    a = 0; b = 0; #10;
	 assert (y === 0) else $error("00 failed.");
	 
	 a = 0; b = 1; #10;
	 assert (y === 1) else $error("01 failed.");
	 
	 a = 1; b = 0; #10;
	 assert (y === 1) else $error("10 failed.");
	 
	 a = 1; b = 1; #10;
	 assert (y === 0) else $error("11 failed.");
    
  end
endmodule
