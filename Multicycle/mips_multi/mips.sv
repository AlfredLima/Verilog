module mips(input logic clk, reset, output logic [31:0] pc,
            input logic [31:0] instr,
            output logic memwrite,
            output logic [31:0] adr, B);
            
  logic mem_to_reg, alusrc, reg_dst, reg_write, zero;
  logic [1:0] pc_src;
  logic [2:0] alu_control;
  
  controller c(instr[31:26], instr[5:0], zero, mem_to_reg, memwrite,
    pc_src, alusrc, reg_dst, reg_write, alu_control);
  
  datapath dp(clk, reset, pc_en, i_or_d, mem_write, ir_write, reg_dst, mem_to_reg, reg_write, alusrc_A, alusrc_B, alu_control, pc_src, 
		pc, instr, zero);
	 
	 
	 
	 

endmodule