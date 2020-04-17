
module shifter_L2_tb();
  logic [31:0] a;
  logic [31:0] y;
	
  shifter_L2 dut(a, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
    a = 32'd1;  #10;
	 assert (y === 32'd4) else $error("1 failed.");
	 
	 a = 32'd15; #10;
	 assert (y === 32'd60) else $error("15 failed.");
	 
	 a = 32'd100;  #10;
	 assert (y === 32'd400) else $error("100 failed.");
	 
	 end
endmodule