module testbench();
  logic  clk;
  logic  reset;
  logic [31:0] writedata, dataadr, instr;
  logic        memwrite;
  logic [31:0] readdata;
  logic [31:0] instrD;
  logic stallD;
  logic [31:0] PCPlus4F;
  logic MemWriteD;
  logic [31:0] rdBD;
  logic [4:0] WriteRegW; // test
	logic RegWriteW; // test
	logic [31:0] ResultW, SrcAE, SrcBE; // test
	logic [31:0] JampAdrrD;
  // определить тестируемое устройство
  top dut (clk, reset, writedata, dataadr, instr, readdata, memwrite, instrD, stallD, PCPlus4F, MemWriteD,
				rdBD, WriteRegW, RegWriteW, ResultW, SrcAE, SrcBE, JampAdrrD);
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
       if (dataadr === 84 & writedata === 4859) begin
          $display("Simulation succeeded");
          $stop;
      end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
         end
       end
    end
endmodule