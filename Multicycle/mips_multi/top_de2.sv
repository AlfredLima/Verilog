module top_de2(input logic CLOCK_50, KEY[0],
				output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
  logic [31:0] pc, instr, readdata;
  logic clk;
  clock_div clock_div(CLOCK_50, ~KEY[0], clk);
  sevensegmentsdecoder sevensegmentsdecoder0(pc[3:0], HEX0);
  sevensegmentsdecoder sevensegmentsdecoder1(pc[7:4], HEX1);
  sevensegmentsdecoder sevensegmentsdecoder2(pc[11:8], HEX2);
  sevensegmentsdecoder sevensegmentsdecoder3(pc[15:12], HEX3);
  sevensegmentsdecoder sevensegmentsdecoder4(pc[19:16], HEX4);
  sevensegmentsdecoder sevensegmentsdecoder5(pc[23:20], HEX5);
  sevensegmentsdecoder sevensegmentsdecoder6(pc[27:24], HEX6);
  sevensegmentsdecoder sevensegmentsdecoder7(pc[31:28], HEX7);

  
  // instantiate processor and memories
  mips mips(clk, ~KEY[0], pc, instr, memwrite, adr, B, readdata);
  
endmodule
