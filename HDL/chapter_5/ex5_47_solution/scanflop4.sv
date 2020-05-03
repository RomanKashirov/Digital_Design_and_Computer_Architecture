module scanflop4(input  logic       clk, test, sin,
                 input  logic [3:0] d, 
                 output logic [3:0] q, 
                 output logic       sout);
  always_ff @(posedge clk)
    if (test)
      q <= d;
    else
      q <= {q[2:0], sin};
  assign sout = q[3];
endmodule
