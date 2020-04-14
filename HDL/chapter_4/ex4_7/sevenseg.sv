module sevenseg(input  logic [3:0] data,
                output logic [6:0] segments);
  always_comb
    case(data)
     //                     abc_defg
	  0:       segments = 7'b111_1110;
	  1:       segments = 7'b011_0000;
	  2:       segments = 7'b110_1101;
	  3:       segments = 7'b111_1001;
	  4:       segments = 7'b011_0011;
	  5:       segments = 7'b101_1011;
	  6:       segments = 7'b101_1111;
	  7:       segments = 7'b111_0000;
	  8:       segments = 7'b111_1111;
	  9:       segments = 7'b111_0011;
	  10:			segments = 7'b111_0111; // A	  
	  11:			segments = 7'b001_1111; // B
	  12:			segments = 7'b100_1110; // C
	  13:			segments = 7'b011_1101; // D
	  14:			segments = 7'b100_1111; // E
	  15:	  		segments = 7'b100_0111; // F
	  default: segments = 7'b000_0000;
   endcase
endmodule