module signext4_8(input  logic [3:0] a, 
                  output logic [7:0] y);
  assign y = { {4{a[3]}}, a};
endmodule
