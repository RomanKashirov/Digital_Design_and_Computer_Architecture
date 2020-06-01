module testbench();
  logic  clk;
  logic  reset;
  logic [31:0] writedata, dataadr;
  logic        memwrite;
  // определить тестируемое устройство
  top dut (clk, reset, writedata, dataadr, memwrite);
  // инициализировать тест
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end
  // генерировать такты для последовательности тестов
  always
  begin
    clk <= 1; # 5; clk <= 0; # 5;
  end
  // проверка результатов
  always @(negedge clk)
   begin
    if (memwrite) begin
       if (dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $stop;
       end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
         end
       end
    end
endmodule