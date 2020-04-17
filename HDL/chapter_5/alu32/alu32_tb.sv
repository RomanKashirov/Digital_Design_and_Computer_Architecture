module alu32_tb();
  logic [31:0] a;
  logic [31:0] b;
	logic [2:0]f;
	logic overflow;
	logic zero;
	logic [31:0] y;
	
  alu32 dut(a, b, f, overflow, zero, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
    a = 32'd1; b = 32'd2; f = 3'b010; #10;
	 assert (y === 32'd3 &  overflow === 0 & zero === 0) else $error("1+2 failed.");
	 
	 a = 32'd150000; b = 32'd5555; f = 3'b010; #10;
	 assert (y === 32'd155555 &  overflow === 0 & zero === 0) else $error("150k+5k failed.");
	 
	 a = 32'd128; b = 32'd128; f = 3'b110; #10;
	 assert (y === 32'd0 &  overflow === 0 & zero === 1) else $error("128-128 failed.");
	 
	 a = 32'd1073741824; b = 32'd1073741824; f = 3'b010; #10;
	 assert (y === 32'h80000000 &  overflow === 1 & zero === 0) else $error("overflow failed.");
	 
	 a = 32'd1; b = 32'd2; f = 3'b110; #10;
	 assert (y === 32'hFFFFFFFF &  overflow === 0 & zero === 0) else $error("1-2 failed.");
    
  end
endmodule