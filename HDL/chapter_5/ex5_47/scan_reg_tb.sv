

module scan_reg_tb();
	logic clk, test, sin, sout;
	logic [31:0]D;
  
  logic [31:0]q;
  
  // задание (определение) тестируемого 
  // устройства
  scan_reg dut(clk, test, sin, D, sout, q);
  
  assign sin = 1;
   
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
	
	always
   begin
			D = 4'd15; #31;
			D = 4'd7; #31;
			D = 4'd3; #31;
			D = 4'd4; #31;	
			D = 4'd0; #31;
   end
	
	always
   begin
			test = 0; #110;
			test = 1; #1000;	
   end
	
	
	
  
  
   
  
  
endmodule
