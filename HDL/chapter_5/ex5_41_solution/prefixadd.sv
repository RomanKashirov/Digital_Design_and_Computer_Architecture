module prefixadd(input  logic [31:0] a, b, 
                 input  logic        cin,
                 output logic [31:0] s, 
                 output logic        cout);
  logic [30:0] p, g;
  // p and g prefixes for rows 1 - 5
  logic [15:0] p1, p2, p3, p4, p5;
  logic [15:0] g1, g2, g3, g4, g5;
  pandg row0(a, b, p, g);
  bbox row1({p[30],p[28],p[26],p[24],p[22],
                 p[20],p[18],p[16],p[14],p[12],
                 p[10],p[8],p[6],p[4],p[2],p[0]},
                {p[29],p[27],p[25],p[23],p[21],
                 p[19],p[17],p[15],p[13],p[11],
                 p[9],p[7],p[5],p[3],p[1],1'b0},
                {g[30],g[28],g[26],g[24],g[22],
                 g[20],g[18],g[16],g[14],g[12],
                 g[10],g[8],g[6],g[4],g[2],g[0]},
                {g[29],g[27],g[25],g[23],g[21],
                 g[19],g[17],g[15],g[13],g[11],
                 g[9],g[7],g[5],g[3],g[1],cin},
                 p1, g1);
					  
					  
					   bbox row2({p1[15],p[29],p1[13],p[25],p1[11],
                 p[21],p1[9],p[17],p1[7],p[13],
                 p1[5],p[9],p1[3],p[5],p1[1],p[1]},
                  {{2{p1[14]}},{2{p1[12]}},{2{p1[10]}},
                 {2{p1[8]}},{2{p1[6]}},{2{p1[4]}},
                 {2{p1[2]}},{2{p1[0]}}},
                {g1[15],g[29],g1[13],g[25],g1[11],
                 g[21],g1[9],g[17],g1[7],g[13],
                 g1[5],g[9],g1[3],g[5],g1[1],g[1]},
                {{2{g1[14]}},{2{g1[12]}},{2{g1[10]}},
                 {2{g1[8]}},{2{g1[6]}},{2{g1[4]}},
                 {2{g1[2]}},{2{g1[0]}}},
                 p2, g2);
  bbox row3({p2[15],p2[14],p1[14],p[27],p2[11],
                 p2[10],p1[10],p[19],p2[7],p2[6],
                 p1[6],p[11],p2[3],p2[2],p1[2],p[3]},
                 {{4{p2[13]}},{4{p2[9]}},{4{p2[5]}}, 
                 {4{p2[1]}}},
                 {g2[15],g2[14],g1[14],g[27],g2[11],
                 g2[10],g1[10],g[19],g2[7],g2[6],
                 g1[6],g[11],g2[3],g2[2],g1[2],g[3]},
                 {{4{g2[13]}},{4{g2[9]}},{4{g2[5]}},
                 {4{g2[1]}}},
                 p3, g3);

					  
					   bbox row4({p3[15:12],p2[13:12],
                 p1[12],p[23],p3[7:4],
                 p2[5:4],p1[4],p[7]},
                 {{8{p3[11]}},{8{p3[3]}}},
                 {g3[15:12],g2[13:12],
                 g1[12],g[23],g3[7:4],
                 g2[5:4],g1[4],g[7]},
                 {{8{g3[11]}},{8{g3[3]}}},
                 p4, g4);
  bbox row5({p4[15:8],p3[11:8],p2[9:8],
                 p1[8],p[15]},
                 {{16{p4[7]}}},
                 {g4[15:8],g3[11:8],g2[9:8],
                 g1[8],g[15]},
                 {{16{g4[7]}}},
                 p5,g5);
  sum row6({g5,g4[7:0],g3[3:0],g2[1:0],g1[0],cin},
           a, b, s);
  // generate cout
  assign cout = (a[31] & b[31]) | 
                (g5[15] & (a[31] | b[31]));
endmodule
module pandg(input  logic [30:0] a, b, 
             output logic [30:0] p, g);
  assign p = a | b;
  assign g = a & b;
endmodule
module bbox(input  logic [15:0] pleft, pright, 
                             gleft, gright,
                output logic [15:0] pnext, gnext);
  assign pnext = pleft & pright;
  assign gnext = pleft & gright | gleft;
endmodule
module sum(input  logic [31:0] g, a, b, 
           output logic [31:0] s);
  assign s = a ^ b ^ g;
endmodule
