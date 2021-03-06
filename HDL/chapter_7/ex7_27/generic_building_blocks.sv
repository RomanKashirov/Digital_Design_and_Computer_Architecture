//Multicycle
//REGISTER FILE
module regfile(input logic clk,
					input logic we3,
					input logic [4:0] ra1, ra2, wa3,
					input logic [31:0] wd3,
					output logic [31:0] rd1, rd2);
					
logic [31:0] rf[31:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clk
// register 0 hardwired to 0
// note: for pipelined processor, write third port
// on falling edge of clk
	always_ff @(posedge clk)
	if (we3) rf[wa3] <= wd3;
	assign rd1=(ra1 != 0) ? rf[ra1] : 0;
	assign rd2=(ra2 != 0) ? rf[ra2] : 0;
endmodule

//ADDER
module adder(input logic [31:0] a, b,
				output logic [31:0] y);
	assign y=a +b;
endmodule

//LEFT SHIFT (MULTIPLY BY 4)
module sl2(input logic [31:0] a,
				output logic [31:0] y);
// shift left by 2
	assign y={a[29:0], 2'b00};
endmodule

//SIGN EXTENSION
module signext(input logic [15:0] a,
					output logic [31:0] y);
	assign y={{16{a[15]}}, a};
endmodule


//ZERO EXTENSION
module zeroext(input logic [15:0] a,
					output logic [31:0] y);
	assign y={16'b0, a};
endmodule

//SIGN EXTENSION 8 to 32
module signext7(input logic [7:0] a,
					output logic [31:0] y);
	assign y={{24{a[7]}}, a};
endmodule




//UN SIGN EXTENSION 8 to 32
module unsignext7(input logic [7:0] a,
					output logic [31:0] y);
	assign y={24'b0, a};
endmodule



//RESETTABLE FLIP-FLOP
module flopr #(parameter WIDTH=8)
					(input logic clk, reset,
	input logic [WIDTH-1:0] d,
	output logic [WIDTH-1:0] q);
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else q <= d;
endmodule

//FLIP-FLOP with ENABLE
module flopen #(parameter WIDTH=8)
					(input logic clk, reset, en,
	input logic [WIDTH-1:0] d,
	output logic [WIDTH-1:0] q);
	always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else if (en) q <= d;
endmodule


// 2:1 MULTIPLEXER
module mux2 #(parameter WIDTH=8)
				(input logic [WIDTH-1:0] d0, d1,
	input logic s,
	output logic [WIDTH-1:0] y);
	assign y=s ? d1 : d0;
endmodule

// 4:1 MULTIPLEXER

module mux4 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2, d3,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);
				  
	always_comb
    case(s)
      2'b00: y <= d0; 
      2'b01: y <= d1; 
      2'b10: y <= d2; 
      2'b11: y <= d3; 
    endcase
  
endmodule



// 3:1 MULTIPLEXER

// mux3 needed for LUI
module mux3 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);
  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule



// 5:1 MULTIPLEXER

module mux5_32 (input  logic [31:0] d0, d1, d2, d3, d4,
              input  logic [2:0]       s, 
              output logic [31:0] y);
				  
	always_comb
    case(s)
      3'b000: y <= d0; 
      3'b001: y <= d1; 
      3'b010: y <= d2; 
      3'b011: y <= d3; 
		3'b100: y <= d4;
		default: y <= 32'bx;
    endcase
  
endmodule



