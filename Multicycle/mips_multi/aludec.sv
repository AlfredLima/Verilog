module aludec(input logic [5:0] funct,
              input logic [1:0] alu_op,
              output logic [2:0] alu_control);
  always_comb
    case(alu_op)
      2'b00: alu_control <= 3'b010; // add (for lw/sw/addi)
      2'b01: alu_control <= 3'b110; // sub (for beq)
      default: case(funct) // R-type instructions
        6'b100000: alu_control <= 3'b010; // add
        6'b100010: alu_control <= 3'b110; // sub
        6'b100100: alu_control <= 3'b000; // and
        6'b100101: alu_control <= 3'b001; // or
        6'b101010: alu_control <= 3'b111; // slt
        default: alu_control <= 3'bxxx; // ???
        endcase
    endcase
endmodule
