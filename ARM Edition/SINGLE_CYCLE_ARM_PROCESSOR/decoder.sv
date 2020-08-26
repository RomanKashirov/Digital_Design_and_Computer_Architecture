// ДЕКОДЕР

module decoder(input logic  [1:0] Op,
               input logic  [5:0] Funct,
               input logic  [3:0] Rd,
               output logic [1:0] FlagW,
               output logic       PCS, RegW, MemW,
               output logic       MemtoReg, ALUSrc, NoWrite,
               output logic [1:0] ImmSrc, RegSrc,
                                  ALUControl);
  logic [9:0]  controls;
  logic        Branch, ALUOp;
  // Главный декодер
  always_comb
    casex(Op)
                 // Обработка данных непосредственная
      2'b00: if (Funct[5]) controls = 10'b0000101001;
                 // Обработка данных регистровая
             else controls = 10'b0000001001;
                 // LDR
      2'b01: if (Funct[0]) controls = 10'b0001111000;
                // STR
             else controls = 10'b1001110100;
                // B
      2'b10: controls = 10'b0110100010;
                // Не реализовано
      default: controls = 10'bx;
    endcase
  assign {RegSrc, ImmSrc, ALUSrc, MemtoReg,
     RegW, MemW, Branch, ALUOp} = controls;
  // Декодер АЛУ
  always_comb
  if (ALUOp) begin          // какая команда ОД?
     case(Funct[4:1])
         4'b0100: ALUControl = 2'b00; // ADD
         4'b0010: ALUControl = 2'b01; // SUB
         4'b0000: ALUControl = 2'b10; // AND
         4'b1100: ALUControl = 2'b11; // ORR
			4'b1010: ALUControl = 2'b01; // CMP
			4'b1000: ALUControl = 2'b10; // TST
         default: ALUControl = 2'bx; // не реализовано
     endcase
     // обновить флаги, если bit S поднят
     // (C & V только для арифм. операций)
     FlagW[1] = Funct[0];
     FlagW[0] = Funct[0] &
       (ALUControl == 2'b00 | ALUControl == 2'b01);
  end else begin
     ALUControl = 2'b00; // для не ОД-команд
     FlagW = 2'b00;      // не обновлять флаги
  end
  // Логика работы с PC
  assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
  // NoWrite
  assign NoWrite = ((Funct[4:1] == 4'b1010) | (Funct[4:1] == 4'b1000)); // CMP or TST
endmodule
