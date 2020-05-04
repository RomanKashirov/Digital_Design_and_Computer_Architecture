module bcdadd_8(input  logic [7:0] a, b, 
               input  logic       cin,
               output logic [7:0] s, 
               output logic       cout);
 logic c0;
 
 bcdadd_4 bcd0(a[3:0], b[3:0], cin, s[3:0], c0);
 bcdadd_4 bcd1(a[7:4], b[7:4], c0, s[7:4], cout);
endmodule
module bcdadd_4(input  logic [3:0] a, b, 
               input  logic       cin, 
               output logic [3:0] s, 
               output logic       cout);
 logic [4:0] result, sub10;
 assign result = a + b + cin;
 assign sub10 = result - 5'd10;
 
 assign cout = ~sub10[4];
 assign s = sub10[4] ? result[3:0] : sub10[3:0];
 
endmodule