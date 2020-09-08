// Generic Building Blocks

// REGISTER FILE

module regfile(input logic clk,
input logic we3,
input logic [3:0] ra1, ra2, wa3,
input logic [31:0] wd3, r15,
output logic [31:0] rd1, rd2);
logic [31:0] rf[14:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 15 reads PC+8 instead
always_ff @(negedge clk)
if (we3) rf[wa3] <= wd3;
assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1];
assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2];
endmodule


// ADDER

module adder #(parameter WIDTH=8)
(input logic [WIDTH-1:0] a, b,
output logic [WIDTH-1:0] y);
assign y = a + b;
endmodule


// IMMEDIATE EXTENSION

module extend(input logic [23:0] Instr,
input logic [1:0] ImmSrc,
output logic [31:0] ExtImm);
always_comb
case(ImmSrc)
// 8-bit unsigned immediate
2'b00: ExtImm = {24'b0, Instr[7:0]};
// 12-bit unsigned immediate
2'b01: ExtImm = {20'b0, Instr[11:0]};
// 24-bit two's complement shifted branch
2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
default: ExtImm = 32'bx; // undefined
endcase
endmodule


// RESETTABLE FLIP-FLOP

module flopr #(parameter WIDTH = 8)
(input logic clk, reset,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q);
always_ff @(posedge clk, posedge reset)
if (reset) q <= 0;
else q <= d;
endmodule


// RESETTABLE FLIP-FLOP WITH ENABLE

module flopenr #(parameter WIDTH = 8)
(input logic clk, reset, en,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q);
always_ff @(posedge clk, posedge reset)
if (reset) q <= 0;
else if (en) q <= d;
endmodule


// 2:1 MULTIPLEXER

module mux2 #(parameter WIDTH = 8)
(input logic [WIDTH-1:0] d0, d1,
input logic s,
output logic [WIDTH-1:0] y);
assign y = s ? d1 : d0;
endmodule


// SHIFTER

module shifter (input logic [31:0] a,
					input logic [4:0] s,
					input logic [1:0] t,
					output logic [31:0] y);
					
	always_comb
	case(t)
		2'b00: y = a << s; 												// Logical Shift Left 
		2'b01: y = a >> s; 												// Logical Shift Right
		2'b10: y = (a >> s) | (32'hFFFFFFFF << (32 - s));		// Arithmetic Shift Right 
		2'b11: y = (a >> s) | (a << (32 - s)); 					// Rotate Right
	default: y = 32'bx; 
	endcase
endmodule




