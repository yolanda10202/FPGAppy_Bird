// DAV Lab 6
`timescale 1 ns/1 ns

// clock divider design
//To Do: Apply Count Parameters
module clk_div #(parameter count_from, parameter count_to) (in, out);
	input in;
	output reg out = 0;
	//To Do: Create 32 Bit Counter Variable
	reg [31:0] counter = count_from;
	
	//To Do: Put correct signals in trigger sensitivity list
	always @ (posedge in) begin
		if (counter == count_to/2) begin
			//To Do: Change variables/outputs under correct conditions
			counter <= 0;
			out = ~out;
		end
		else begin
			//To Do: Create default case
			counter <= counter + 1;
		end
	end
	
endmodule 