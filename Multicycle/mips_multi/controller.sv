module controller(input logic clk, reset, 
						input logic [5:0] op, funct,  
						input logic zero, 
						
						output logic pc_en, i_or_d, mem_write, ir_write, 
						output logic reg_dst, mem_to_reg, 
						output logic reg_write, alusrc_A, 
						output logic [1:0] alusrc_B,  
						output logic [2:0] alu_control,
						output logic [1:0] pc_src);
  
  logic [1:0] alu_op;
  logic branch, pc_write;
  
  maindec md(clk, reset, op, mem_to_reg, reg_dst, i_or_d, pc_src, alusrc_B, alusrc_A, ir_write, mem_write, pc_write, branch, reg_write, alu_op);
  
  aludec ad(funct, alu_op, alu_control);
  
  assign pc_en = (branch & zero) | (pc_write);
endmodule