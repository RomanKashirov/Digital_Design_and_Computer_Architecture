module controller(input  logic         clk, reset, 
                  input  logic [31:12] InstrD, 
                  input  logic [3:0]   ALUFlagsE, 
                  output logic [1:0]   RegSrcD, ImmSrcD,  
                  output logic         ALUSrcE, BranchTakenE, 
                  output logic [1:0]   ALUControlE, 
                  output logic         MemWriteM, 
                  output logic         MemtoRegW, PCSrcW, RegWriteW, 
                  // hazard interface 
                  output logic         RegWriteM, MemtoRegE, 
                  output logic         PCWrPendingF, 
                  input  logic         FlushE); 
 
  logic [9:0] controlsD; 
  logic       CondExE, ALUOpD; 
  logic [1:0] ALUControlD; 
  logic       ALUSrcD;
  logic       MemtoRegD, MemtoRegM; 
  logic       RegWriteD, RegWriteE, RegWriteGatedE, PCSrcGatedE; 
  logic       MemWriteD, MemWriteE, MemWriteGatedE; 
  logic       BranchD, BranchE; 
  logic [1:0] FlagWriteD, FlagWriteE; 
  logic       PCSrcD, PCSrcE, PCSrcM; 
  logic [3:0] FlagsE, FlagsNextE, CondE; 
 
  // Decode stage 
   
  always_comb 
    casex(InstrD[27:26]) 
      2'b00: if (InstrD[25]) controlsD = 10'b0000101001; // DP imm 
             else            controlsD = 10'b0000001001; // DP reg 
      2'b01: if (InstrD[20]) controlsD = 10'b0001111000; // LDR 
             else            controlsD = 10'b1001110100; // STR 
      2'b10:                 controlsD = 10'b0110100010; // B 
      default:               controlsD = 10'bx;          // unimplemented
 
    endcase 
 
  assign {RegSrcD, ImmSrcD, ALUSrcD, MemtoRegD,  
          RegWriteD, MemWriteD, BranchD, ALUOpD} = controlsD;  
           
  always_comb 
    if (ALUOpD) begin                 // which Data-processing Instr? 
      case(InstrD[24:21])  
        4'b0100: ALUControlD = 2'b00; // ADD 
        4'b0010: ALUControlD = 2'b01; // SUB 
        4'b0000: ALUControlD = 2'b10; // AND 
        4'b1100: ALUControlD = 2'b11; // ORR 
        default: ALUControlD = 2'bx;  // unimplemented 
      endcase 
      FlagWriteD[1] = InstrD[20];   // update N and Z Flags if S bit is set 

      FlagWriteD[0] = InstrD[20] & (ALUControlD == 2'b00 | ALUControlD == 2'b01); 
      end else begin 
      ALUControlD     = 2'b00;        // perform addition for non-dataprocessing instr 
      FlagWriteD      = 2'b00;        // don't update Flags 
     end 
 
		assign PCSrcD       = (((InstrD[15:12] == 4'b1111) & RegWriteD) | BranchD); 
     
  // Execute stage 
  floprc #(7) flushedregsE(clk, reset, FlushE, {FlagWriteD, BranchD, MemWriteD, RegWriteD, 
	PCSrcD, MemtoRegD}, {FlagWriteE, BranchE, MemWriteE, RegWriteE, PCSrcE, MemtoRegE}); 
  flopr #(3)  regsE(clk, reset, {ALUSrcD, ALUControlD}, {ALUSrcE, ALUControlE}); 
                     
  flopr  #(4) condregE(clk, reset, InstrD[31:28], CondE); 
  flopr  #(4) flagsreg(clk, reset, FlagsNextE, FlagsE); 
 
  // write and Branch controls are conditional 
  conditional Cond(CondE, FlagsE, ALUFlagsE, FlagWriteE, CondExE, FlagsNextE); 
  assign BranchTakenE    = BranchE & CondExE; 
  assign RegWriteGatedE  = RegWriteE & CondExE; 
  assign MemWriteGatedE  = MemWriteE & CondExE; 
  assign PCSrcGatedE     = PCSrcE & CondExE; 
   
  // Memory stage 
  flopr #(4) regsM(clk, reset, 
                   {MemWriteGatedE, MemtoRegE, RegWriteGatedE, PCSrcGatedE}, 
                   {MemWriteM, MemtoRegM, RegWriteM, PCSrcM}); 
   
  // Writeback stage 
  flopr #(3) regsW(clk, reset, 
                   {MemtoRegM, RegWriteM, PCSrcM}, 
                   {MemtoRegW, RegWriteW, PCSrcW}); 
   
  // Hazard Prediction 
  assign PCWrPendingF = PCSrcD | PCSrcE | PCSrcM; 
 
endmodule 

module conditional(input  logic [3:0] Cond, 
                   input  logic [3:0] Flags, 
                   input  logic [3:0] ALUFlags, 
                   input  logic [1:0] FlagsWrite, 
                   output logic       CondEx, 
                   output logic [3:0] FlagsNext); 
   
  logic neg, zero, carry, overflow, ge; 
   
  assign {neg, zero, carry, overflow} = Flags; 
  assign ge = (neg == overflow); 
                   
  always_comb 
    case(Cond) 
      4'b0000: CondEx = zero;             // EQ 
      4'b0001: CondEx = ~zero;            // NE 
      4'b0010: CondEx = carry;            // CS 
      4'b0011: CondEx = ~carry;           // CC 
      4'b0100: CondEx = neg;              // MI 
      4'b0101: CondEx = ~neg;             // PL 
      4'b0110: CondEx = overflow;         // VS 
      4'b0111: CondEx = ~overflow;        // VC 
      4'b1000: CondEx = carry & ~zero;    // HI 
      4'b1001: CondEx = ~(carry & ~zero); // LS 
      4'b1010: CondEx = ge;               // GE 
		4'b1011: CondEx = ~ge;              // LT 
      4'b1100: CondEx = ~zero & ge;       // GT 
      4'b1101: CondEx = ~(~zero & ge);    // LE 
      4'b1110: CondEx = 1'b1;             // Always 
      default: CondEx = 1'bx;             // undefined 
    endcase 
     
  assign FlagsNext[3:2] = (FlagsWrite[1] & CondEx) ? ALUFlags[3:2] : 
Flags[3:2]; 
  assign FlagsNext[1:0] = (FlagsWrite[0] & CondEx) ? ALUFlags[1:0] : 
Flags[1:0]; 
endmodule 


