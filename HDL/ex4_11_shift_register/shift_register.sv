module shift_register(input  logic clk,
                    input  logic reset,
                    output logic q0, q1, q2, q3);
  typedef enum logic [1:0] {S0, S1, S2, S3} 
statetype;

  statetype state, nextstate;
  // регистр состояния
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else       state <= nextstate;
  // логика следующего состояния
  always_comb
    case (state)
      S0:      nextstate = S1;
      S1:      nextstate = S2;
      S2:      nextstate = S3;
		S3:      nextstate = S0;
      default: nextstate = S0;
    endcase
  // выходная логика
  assign q0 = (state == S0);
  assign q1 = (state == S1);
  assign q2 = (state == S2);
  assign q3 = (state == S3);
endmodule