module trafficFSM(input  logic clk, reset, ta, tb,
                  output logic [1:0] la, lb);
  typedef enum logic [1:0] {S0, S1, S2, S3} 
    statetype;
  statetype  state, nextstate;
  parameter green  = 2'b00;
  parameter yellow = 2'b01;
  parameter red    = 2'b10;
  // State Register
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else       state <= nextstate;
  // Next State Logic
  always_comb
    case (state)
      S0: if (ta) nextstate = S0;
          else    nextstate = S1;
      S1:         nextstate = S2;
      S2: if (tb) nextstate = S2;
          else    nextstate = S3;
      S3:         nextstate = S0;
    endcase
  // Output Logic
  always_comb
    case (state)
      S0: {la, lb} = {green, red};
      S1: {la, lb} = {yellow, red};
      S2: {la, lb} = {red, green};
      S3: {la, lb} = {red, yellow};
    endcase
endmodule
