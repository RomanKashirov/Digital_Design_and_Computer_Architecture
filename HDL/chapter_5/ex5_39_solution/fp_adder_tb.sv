
module fp_adder_tb();
  logic [31:0] a;
  logic [31:0] b;
  logic [31:0] y;
	
  fpadd dut(a, b, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
  
    a = 32'h42080000; b = 32'h40490E56; #100;
	 assert (y === 32'h421490E5) else $error("1 failed.");
	 
	 a = 32'h451D1B68; b = 32'h432C1C6A; #100;
//	 assert (y === 32'h4527DD2F) else $error("2 failed.");
	 end
	 
endmodule