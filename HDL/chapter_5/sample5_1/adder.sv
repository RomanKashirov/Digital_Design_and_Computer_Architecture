module adder   #(parameter n = 8) (input logic [n-1:0]  a, b,
               input logic          cin,
               output logic [n-1:0] s,
               output logic         cout);
   assign {cout, s} = a + b + cin;
endmodule