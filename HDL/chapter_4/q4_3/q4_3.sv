module q4_3 (input logic [15:0] data,
					output logic result);


assign result = | (data[15:0] & 16'hC820);

endmodule