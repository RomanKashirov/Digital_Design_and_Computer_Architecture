module subtractor #(parameter n = 8)
                   (input logic [n - 1:0] a, b,
                    output logic [n - 1:0] y);
    assign y = a - b;
endmodule