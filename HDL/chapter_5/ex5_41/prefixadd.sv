module prefixadd(input  logic [3:0] a, b, 
             output logic [3:0] s);
				 
				 logic [3:0] p, g;
				 logic [1:0] p0, p1, g0, g1;
				 
inbox inbox_0(a[0], b[0], p[0], g[0]);
inbox inbox_1(a[1], b[1], p[1], g[1]);
inbox inbox_2(a[2], b[2], p[2], g[2]);
inbox inbox_3(a[3], b[3], p[3], g[3]);

bbx bb0n1(g[0], p[0], 1'b0, 1'b0, g0[0], p0[0]);
bbx bb1n1(g[1], p[1], g0[0], p0[0], g1[0], p1[0]);
bbx bb2n1(g0[1], p0[1], g0[0], p0[0], g1[1], p1[1]);
bbx bb21(g[2], p[2], g[1], p[1], g0[1], p0[1]);				 
				 
outbox outbox_0(a[0], b[0], 1'b0, s[0]);
outbox outbox_1(a[1], b[1], g0[0], s[1]);
outbox outbox_2(a[2], b[2], g1[0], s[2]);
outbox outbox_3(a[3], b[3], g1[1], s[3]);

				 
endmodule				 
				 
				 
 module inbox(input  logic a, b, 
             output logic p, g);
				 
assign p = a | b;
assign g = a & b;
				 
				 
endmodule

module bbx(input  logic gik, pik, gkj, pkj,
             output logic gij, pij);
				 
assign pij = pik & pkj;
assign gij = gik | (gkj & pik);


				 
				 
endmodule


module outbox(input  logic a, b, g,
             output logic s);
				 
assign s = a ^ b ^ g;
				 
endmodule