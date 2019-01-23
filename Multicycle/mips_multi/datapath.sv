module datapath(input logic clk, reset,
					 input logic pc_en, i_or_d, mem_write, ir_write, 
                input logic reg_dst, mem_to_reg, 
					 input logic reg_write, alusrc_A, 
					 input logic [1:0] alusrc_B,  
					 input logic [2:0] alu_control,
                input logic [1:0] pc_src,
                
					 output logic [31:0] pc,
                output logic [31:0] instr,
					 output logic zero);
					 
  logic [4:0] write_reg;
  logic [31:0] pc_next;
  logic [31:0] signimm, signimmsh;
  logic [31:0] rd1, rd2;
  logic [31:0] wd3, data;
  logic [31:0] pc_jump;
  
  flopr #(32) pcreg(clk, reset, pc_en, pc_next, pc);
  mux2 #(32) mux_addr(pc, alu_out, i_or_d, adr);
  dmem dmem(clk, mem_write, adr, B, read_data);
  flopr #(32) inst_reg(clk, reset, ir_write, read_data, instr);
  flopr #(32) data_reg(clk, reset, 1, read_data, data);
  mux2 #(5) wrmux(instr[20:16], instr[15:11], reg_dst, write_reg);
  mux2 #(32) wd3mux(alu_out, data, mem_to_reg, wd3);
  regfile rf(clk, reg_write, instr[25:21], instr[20:16], write_reg, wd3, rd1, rd2);
  flopr #(32) A_reg(clk, reset, 1, rd1, A);
  flopr #(32) B_reg(clk, reset, 1, rd2, B);
  mux2 #(32) pc_or_A_mux(pc, A, alusrc_A, src_A);
  signext se(instr[15:0], signimm);
  sl2 immsh(signimm, signimmsh);
  mux4 #(32) src_B_mux(B, 4, signimm, signimmsh, alusrc_B, src_B);
  alu32 alu(src_A, src_B, alu_control, alu_result, zero);
  flopr #(32) alu_reg(clk, reset, 1, alu_result, alu_out);
  assign pc_jump = {{pc[31:28]},{inst[25:0]},{2'b00}};
  mux4 #(32) mux_pc_src(alu_result, alu_out, pc_jump, 0, pc_src, pc_next);
  
  
  
endmodule
