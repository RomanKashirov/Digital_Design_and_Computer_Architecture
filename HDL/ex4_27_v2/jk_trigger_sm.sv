module jk_trigger_sm(input logic clk, reset,
            input logic j, k,
            output logic q);
  logic state, nextstate;
  parameter S0 = 1'b0;
  parameter S1 = 1'b1;
  
  always_ff @(posedge clk, posedge reset)
   if (reset) state <= S0;
   else       state <= nextstate;
  always_comb
    case (state)
      S0: if (j == 1) nextstate = S1;
          else       nextstate = S0;
      S1: if (k == 1) nextstate = S0;
          else       nextstate = S1;
      
      default:       nextstate = S0;
    endcase
  assign q = (state == S1);
endmodule
