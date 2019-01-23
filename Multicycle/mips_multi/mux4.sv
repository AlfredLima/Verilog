module mux4 #(parameter WIDTH = 8)
            (input logic [WIDTH-1:0] d0, d1, d2, d3,
              input logic [1:0] s,
              output logic [WIDTH-1:0] y);
  logic [WIDTH-1:0] r1, r2;
  
  mux2 #(WIDTH) m1(d0, d1, s[0],r1);
  mux2 #(WIDTH) m2(d2, d3, s[0],r2);
  mux2 #(WIDTH) m3(r1, r2, s[1],y);

endmodule
