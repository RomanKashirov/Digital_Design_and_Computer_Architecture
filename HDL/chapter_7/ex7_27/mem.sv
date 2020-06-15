 // Multicycle
 module mem(input  logic        clk, we,
              input  logic [31:0] a, wd,
              output logic [31:0] rd);
      logic [31:0] RAM[63:0];
   initial
   //   begin
       $readmemh("D:/Git/Digital_Design_and_Computer_Architecture/HDL/chapter_7/ex7_27/memfile_1.dat", RAM);
  //    end
     assign rd = RAM[a[31:2]]; // пословно выровнено
     always @(posedge clk)
       if (we)
        RAM[a[31:2]] <= wd;
endmodule
