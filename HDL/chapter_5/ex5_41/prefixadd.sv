module prefixadd(input  logic [31:0] a, b, 
             output logic [31:0] s);
				 
				 
				 
				 
				 
				 
				 
  logic [7:0]  expa, expb, exp_pre, exp, shamt;
  logic        alessb;
  logic [23:0] manta, mantb, shmant;
  logic [22:0] fract;
  assign {expa, manta} = {a[30:23], 1'b1, a[22:0]};
  assign {expb, mantb} = {b[30:23], 1'b1, b[22:0]};
  assign s             = {1'b0, exp, fract};
  expcomp   expcomp1(expa, expb, alessb, exp_pre, 
                     shamt);
  shiftmant shiftmant1(alessb, manta, mantb,
                       shamt, shmant);
  addmant   addmant1(alessb, manta, mantb,
                     shmant, exp_pre, fract, exp);
endmodule

module expcomp(input  logic [7:0] expa, expb, 
               output logic       alessb, 
               output logic [7:0] exp, shamt);
  logic [7:0] aminusb, bminusa;
  assign aminusb = expa - expb;
  assign bminusa = expb - expa;
  assign alessb  = aminusb[7];
  always_comb
    if (alessb) begin
      exp = expb;
      shamt = bminusa;
    end
    else begin
      exp = expa;
      shamt = aminusb;
    end 
endmodule

module shiftmant(input  logic alessb, 
                 input  logic [23:0] manta, mantb,
                 input  logic [7:0] shamt, 
                 output 