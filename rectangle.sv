`timescale 1ns / 1ps

module rectangle #(
		X_SIZE=320,     // half rect width (for ease of co-ordinate calculations)
		Y_SIZE=15,		// half rect height
		IX=320,         // initial horizontal position of square centre
		IY=240,         // initial vertical position of square centre
		D_WIDTH=640,    // width of display
		D_HEIGHT=480    // height of display
	)
   (
		input wire i_clk,         // base clock
		input wire i_rst,         // reset: returns animation to starting position
		output wire [11:0] o_x1,  // square left edge: 12-bit value: 0-4095
		output wire [11:0] o_x2,  // square right edge
		output wire [11:0] o_y1,  // square top edge
		output wire [11:0] o_y2   // square bottom edge
	);

   reg [11:0] x;// = IX;   // horizontal position of square centre
   reg [11:0] y;// = IY;   // vertical position of square centre

   assign o_x1 = x - X_SIZE;  // left: centre minus half horizontal size
   assign o_x2 = x + X_SIZE;  // right
   assign o_y1 = y - Y_SIZE;  // top
   assign o_y2 = y + Y_SIZE;  // bottom

   always @ (posedge i_clk) begin
		if (i_rst)  // on reset return to starting position
			begin
				x <= IX;
            y <= IY;
			end
	end
endmodule