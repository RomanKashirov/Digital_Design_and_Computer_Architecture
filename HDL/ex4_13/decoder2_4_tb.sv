module decoder2_4_tb();

  logic [1:0] in_tb;
  logic [3:0] out_tb;
  
  decoder2_4 dut(in_tb, out_tb);
  
  
  
  initial begin
    in_tb = 2'b00; #10;
    assert (out_tb === 4'b0001) else $error("00 failed.");
	 
	 in_tb = 2'b01; #10;
    assert (out_tb === 4'b0010) else $error("01 failed.");
	 
	 in_tb = 2'b10; #10;
    assert (out_tb === 4'b0100) else $error("10 failed.");
	 
	 in_tb = 2'b11; #10;
    assert (out_tb === 4'b1000) else $error("11 failed.");
  end

endmodule