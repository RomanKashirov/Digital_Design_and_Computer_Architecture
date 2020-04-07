module sevenseg_tb();
	timeunit 1ns;
	timeprecision 1ns;
  logic [3:0] data; logic [6:0] segments;
  // задание (определение) тестируемого 
  // устройства
  sevenseg dut(data, segments);
  // активировать входы пошагово, 
  // с интервалом проверка результатов
  initial begin
    data = 0; #10;
	 assert (segments === 7'b111_1110) else $error("0 failed.");
	 data = 1; #10;
	 assert (segments === 7'b011_0000) else $error("1 failed.");
	 data = 2; #10;
	 assert (segments === 7'b110_1101) else $error("2 failed.");
	 data = 3; #10;
	 assert (segments === 7'b111_1001) else $error("3 failed.");
	 data = 4; #10;
	 assert (segments === 7'b011_0011) else $error("4 failed.");
	 data = 5; #10;
	 assert (segments === 7'b101_1011) else $error("5 failed.");
	 data = 6; #10;
	 assert (segments === 7'b101_1111) else $error("6 failed.");
	 data = 7; #10;
	 assert (segments === 7'b111_0000) else $error("7 failed.");
	 data = 8; #10;
	 assert (segments === 7'b111_1111) else $error("8 failed.");
	 data = 9; #10;
	 assert (segments === 7'b111_0011) else $error("9 failed.");
	 data = 10; #10;
	 assert (segments === 7'b111_0111) else $error("A failed.");
	 data = 11; #10;
	 assert (segments === 7'b001_1111) else $error("B failed.");
	 data = 12; #10;
	 assert (segments === 7'b100_1110) else $error("C failed.");
	 data = 13; #10;
	 assert (segments === 7'b011_1101) else $error("D failed.");
	 data = 14; #10;
	 assert (segments === 7'b100_1111) else $error("E failed.");
	 data = 15; #10;
	 assert (segments === 7'b100_0111) else $error("F failed.");
    
  end
endmodule
