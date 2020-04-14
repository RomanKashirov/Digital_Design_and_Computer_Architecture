 module ex4_50(input  logic a, b, c,
                  output logic y);
         logic tmp;
         always @(a, b, c)
         begin
           tmp = a & b;
           y = tmp & c;
         end
      endmodule

