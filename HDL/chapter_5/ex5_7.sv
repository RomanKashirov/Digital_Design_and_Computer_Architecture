module ex5_7(input  logic [7:0] in,
                output logic [2:0] out);
  always_comb
    if (in >= 8'd128) out = 3'd7;
	 else if (in >= 8'd64) out = 3'd6;
	 else if (in >= 8'd32) out = 3'd5;
	else if (in >= 8'd16) out = 3'd4;
	else if (in >= 8'd8) out = 3'd3;
	else if (in >= 8'd4) out = 3'd2;
	else if (in >= 8'd2) out = 3'd1;
	else out = 3'd0;	
endmodule