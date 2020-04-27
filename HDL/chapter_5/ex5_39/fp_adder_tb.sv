
module fp_adder_tb();
  logic [31:0] a;
  logic [31:0] b;
  logic [31:0] y;
	
  fp_adder dut(a, b, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
    a = 32'h40400000; b = 32'h41700000; #100;
	 a = 32'h40400000; b = 32'h41700000; #100;
	 a = 32'h40400000; b = 32'h41700000; #100;
	 
	 
	 
	 
	 end
endmodule