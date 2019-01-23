module maindec( input logic clk, reset,
					 input logic [5:0] op,
                
					 output logic mem_to_reg, reg_dst, i_or_d,
					 output logic [1:0] pc_src,
					 output logic [1:0] alusrc_B,
					 output logic alusrc_A,
					 
					 output logic ir_write, mem_write, pc_write, 
					 output logic branch, reg_write,
					 output logic [1:0] alu_op);

  //logic [8:0] controls;
  //assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump} = controls;
  
	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;
	parameter S5 = 4'b0101;
	parameter S6 = 4'b0110;
	parameter S7 = 4'b0111;
	parameter S8 = 4'b1000;
	parameter S9 = 4'b1001;
	parameter S10 = 4'b1010;
	parameter S11 = 4'b1011;
	
	parameter LW = 6'b100011;
	parameter SW = 6'b101011;
	parameter R = 6'b000000;
	parameter BEQ = 6'b000100;
	parameter ADDI = 6'b001000;
	parameter J = 6'b000010;

	
	always_ff @(posedge clk, posedge reset)
	
		if(reset) state <= S0;
		else state <= nextstate;
		
	always_comb
	case(state)
		S0: 
			begin
				assign i_or_d = 1'b0;
				assign alusrc_A = 1'b0;
				assign alusrc_B = 2'b01;
				assign alu_op = 2'b00;
				assign pc_src = 2'b00;
				assign ir_write = 1'b1;
				assign pc_write = 1'b1;
				nextstate = S1;
			end
		S1: 
			begin
				assign alusrc_A = 1'b0;
				assign alusrc_B = 2'b11;
				assign alu_op = 2'b00;
				if(op == LW || op == SW) nextstate = S2;
				else if(op == R) nextstate = S6;
				else if(op == BEQ) nextstate = S8;
				else if(op == ADDI) nextstate = S9;
				else if(op == J) nextstate = S11;
				else nextstate = S0;
			end
		S2: 
			begin
				assign alusrc_A = 1'b1;
				assign alusrc_B = 2'b10;
				assign alu_op = 2'b00;
				if(op == SW ) nextstate = S5;
				else if(op = LW) nextstate = S3;
				else nextstate = S0;
			end
		S3: 
			begin
				assign i_or_d = 1'b1;
				nextstate = S4;
			end
		S4: 
			begin
				assign reg_dst = 1'b0;
				assign mem_to_reg = 1'b1;
				assign reg_write = 1'b1;
				nextstate = S0;
			end
		S5: 
			begin
				assign i_or_d = 1'b1;
				assign mem_write = 1'b1;
				nextstate = S0;
			end
		S6: 
			begin
				assign alusrc_A = 1'b1;
				assign alusrc_B = 2'b00;
				assign alu_op = 2'b10;
				nextstate = S7;
			end
		S7: 
			begin
			
			end
		S8: 
			begin
			
			end
		S9: 
			begin
			
			end
		S10: 
			begin
			
			end
		S11: 
			begin
			
			end
		default: 
			begin
				nextstate = S0;
			end
			
	endcase
  
endmodule
