module just_project_tb();

  logic clk_tb, reset_tb, q_tb;
  
  just_project freq_dev(clk_tb, reset_tb, q_tb);
  
  
  
  initial
    begin
      reset_tb = 1; #270; reset_tb = 0;
    end

  
  
  // генерировать такты
  always
   begin
     clk_tb = 0; #50; clk_tb = 1; #50;
   end
endmodule