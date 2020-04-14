module ex4_45(input  logic       clk, c, 
              input  logic [1:0] a, b,
              output logic [1:0] s);
  logic  [1:0] areg, breg;
  logic        creg;
  logic [1:0]  sum;
  logic        cout;
  always_ff @(posedge clk)
    {areg, breg, creg, s} <= {a, b, c, sum};
    
  fulladder fulladd1(areg[0], breg[0], creg, 
                     sum[0], cout);
  fulladder fulladd2(areg[1], breg[1], cout, 
                     sum[1], );
endmodule