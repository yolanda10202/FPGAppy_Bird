`timescale 1ns / 1ps

module pipe #(
		X_SIZE=80,      // half square width (for ease of co-ordinate calculations)
		Y_HOLE=120,		// hole in the pipe
		IX=480,         // initial horizontal position of square centre
		IY=240,         // initial vertical position of square centre
		D_WIDTH=640,    // width of display
		D_HEIGHT=480,   // height of display
		SCROLL_SPEED = 7 // how fast the pipe scrolls left
   )
   (
		input wire i_clk,         // base clock
		input wire i_rst,         // reset: returns animation to starting position
		output wire [11:0] p1_x1,  // square left edge: 12-bit value: 0-4095
		output wire [11:0] p1_x2,  // square right edge
		output wire [11:0] p1_y1,  // square top edge
		output wire [11:0] p1_y2,   // square bottom edge
		output reg point_add // point is added when pipe resets
   );
	reg [3:0] pipe_counter;// = 0;

   reg [11:0] p1_x;// = IX;   // horizontal position of square centre
   reg [11:0] p1_y;// = IY;   // vertical position of square centre
	
	reg [5:0] scroll_speed;// = SCROLL_SPEED;

   assign p1_x1 = (p1_x < X_SIZE) ? 0 : p1_x - X_SIZE;  // left: centre minus half horizontal size
   assign p1_x2 = p1_x + X_SIZE;  // right
   assign p1_y1 = p1_y - Y_HOLE;  // top
   assign p1_y2 = p1_y + Y_HOLE;  // bottom

   always @ (posedge i_clk) begin
		if (i_rst)  // on reset return to starting position
			begin
				p1_x = IX;
            p1_y = IY;
				scroll_speed = SCROLL_SPEED;
				pipe_counter = 0;
			end
		else begin
			if(p1_x <= scroll_speed) begin
				case (pipe_counter)
					0: p1_y = 220;
					1: p1_y = 130;
					2: p1_y = 310;
					3: p1_y = 290;
					4: p1_y = 160;
					5: p1_y = 370;
					6: p1_y = 120;
					7: p1_y = 390;
					8: p1_y = 275;
					9: p1_y = 225;
					10: p1_y = 100;
					11: p1_y = 130;
					12: p1_y = 190;
					13: p1_y = 340;
					14: p1_y = 280;
					15: p1_y = 90;
				endcase
				pipe_counter = pipe_counter + 1;
				p1_x = 680;
				point_add = 1;
				scroll_speed = scroll_speed + 1;
			end
			else begin
				p1_x = p1_x - scroll_speed;
				point_add = 0;
			end
		end
    end
endmodule
