module clock_div (input logic clk, reset, 
						output logic clk_out);
				  
	logic [31:0] count;

  always_ff @(posedge clk, posedge reset)
    if (reset) 
	 begin
		count <= 0;
		clk_out <= 0;
	 end
    else 
	 begin
		count = count + 1;
		if (count === 25000000) 
		begin
			clk_out <= ~clk_out;
			count <= 0;
		end
	 end
			
endmodule