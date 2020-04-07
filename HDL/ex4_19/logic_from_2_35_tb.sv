

module logic_from_2_35_tb();
  logic[3:0] a;
  logic p, d;
  // задание (определение) тестируемого 
  // устройства
  logic_from_2_35 dut(a, p, d);
  // активировать входы пошагово, 
  // с интервалом проверка результатов
  initial begin
    a = 0;#10;
    assert ((p === 0)&(d === 0)) else $error("0 failed.");
    
	 a = 1;#10;
    assert ((p === 0)&(d === 0)) else $error("1 failed.");
	 
	 a = 2;#10;
    assert ((p === 1)&(d === 0)) else $error("2 failed.");
	 
	 a = 3;#10;
    assert ((p === 1)&(d === 1)) else $error("3 failed.");
	 
	 a = 4;#10;
    assert ((p === 0)&(d === 0)) else $error("4 failed.");
	 
	 a = 5;#10;
    assert ((p === 1)&(d === 0)) else $error("5 failed.");
	 
	 a = 6;#10;
    assert ((p === 0)&(d === 1)) else $error("6 failed.");
	 
	 a = 7;#10;
    assert ((p === 1)&(d === 0)) else $error("7 failed.");
	 
	 a = 8;#10;
    assert ((p === 0)&(d === 0)) else $error("8 failed.");
	 
	 a = 9;#10;
    assert ((p === 0)&(d === 1)) else $error("9 failed.");
	 
	 a = 10;#10;
    assert ((p === 0)&(d === 0)) else $error("10 failed.");
	 
	 a = 11;#10;
    assert ((p === 1)&(d === 0)) else $error("11 failed.");
	 
	 a = 12;#10;
    assert ((p === 0)&(d === 1)) else $error("12 failed.");
	 
	 a = 13;#10;
    assert ((p === 1)&(d === 0)) else $error("13 failed.");
	 
	 a = 14;#10;
    assert ((p === 0)&(d === 0)) else $error("14 failed.");
	 
	 a = 15;#10;
    assert ((p === 0)&(d === 1)) else $error("15 failed.");
	 
  end
endmodule
