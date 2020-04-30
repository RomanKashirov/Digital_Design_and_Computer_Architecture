
module prefixadd_tb();
  logic [3:0] a;
  logic [3:0] b;
  logic [3:0] y;
	
  prefixadd dut(a, b, y);
  // активировать входы пошагово, 
  // с интервалом
  initial begin
  
    a = 4'd15; b = 4'd0; #100;
	 a = 4'd5; b = 4'd3; #100;
	 a = 4'd6; b = 4'd1; #100;
	 a = 4'd2; b = 4'd2; #100;
	 a = 4'd2; b = 4'd3; #100;
	 a = 4'd1; b = 4'd13; #100;
	 a = 4'd4; b = 4'd3; #100;
	 
	 
	 
//	 assert (y === 32'h4527DD2F) else $error("2 failed.");
	 end
	 
endmodule