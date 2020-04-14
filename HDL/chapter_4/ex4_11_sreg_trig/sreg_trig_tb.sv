module sreg_trig_tb();

  logic clk_tb, reset_tb, q0_tb, q1_tb, q2_tb, q3_tb;
  
  sreg_trig dut(clk_tb, reset_tb, q0_tb, q1_tb, q2_tb, q3_tb);
  
  
  
  initial
    begin
      reset_tb = 1; #60; reset_tb = 0;
    end

  
  
  // генерировать такты
  always
   begin
     clk_tb = 0; #50; clk_tb = 1; #50;
   end
endmodule