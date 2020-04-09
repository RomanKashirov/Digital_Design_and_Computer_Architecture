module ex4_43(input  logic clk, reset, a,
              output logic q);
  typedef enum logic [1:0] {S0, S1, S2} 
    statetype;
  statetype  state, nextstate;
  // State Register
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else       state <= nextstate;
  // Next State Logic
  always_comb
    case (state)
      S0: if   (a) nextstate = S1;
          else     nextstate = S0;
      S1: if   (a) nextstate = S2;
          else     nextstate = S0;
      S2: if   (a) nextstate = S2;
          else     nextstate = S0;
      default:   nextstate = S0;
    endcase
  // Output Logic
  assign q = state[1];
endmodule
