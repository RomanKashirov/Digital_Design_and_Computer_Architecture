module bcdadder_8(input  logic cin,
                 input  logic [7:0] a, b, 
                 output logic [7:0] s, 
                 output logic cout);
					  logic cout_low;
					  
  bcdadder_4 low(a[3:0], b[3:0], cin, s[3:0], cout_low), 
  high(a[7:4], b[7:4], cout_low, s[7:4], cout);
  
  
endmodule


module bcdadder_4(input  logic [3:0] a, b,
						input  logic cin, 
                  output logic [3:0] s, 
                  output logic cout);
					   
						logic [4:0] sum;
						logic [4:0] sub;
						
						assign sum = a + b + cin;
						assign sub = sum - 5'd10;
						assign cout = ~sub[4];
						
						assign s = sub[4] ? sum[3:0] : sub[3:0];
 
endmodule
