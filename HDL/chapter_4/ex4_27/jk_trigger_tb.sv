module jk_trigger_tb();
  logic        clk, reset;
  logic        j, k, q;
  
  jk_trigger dut(clk, reset, j, k, q);
  // генерировать такты
  always
   begin
     clk = 1; #5; clk = 0; #5;
   end
  
  always
   begin
     {j, k} = 2'b00; #13; {j, k} = 2'b01; #13;
	  {j, k} = 2'b10; #13; {j, k} = 2'b11; #13;
	  {j, k} = 2'b10; #13; {j, k} = 2'b01; #13;
	  {j, k} = 2'b11; #13; {j, k} = 2'b11; #13;
	  {j, k} = 2'b00; #13; {j, k} = 2'b01; #13;
	  {j, k} = 2'b10; #13; {j, k} = 2'b01; #13;
   end
  
  initial
    begin
      
      reset = 1; #27; reset = 0;
    end
 endmodule