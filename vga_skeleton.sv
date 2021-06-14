`timescale 1ns / 1ps

module vga_skeleton(
		input wire i_clk,           // VGA clock
		input wire i_rst,           // reset: restarts frame
		output wire o_hs,           // horizontal sync
		output wire o_vs,           // vertical sync
		output wire [9:0] o_x,      // current pixel x position
		output wire [9:0] o_y       // current pixel y position
	);

   // VGA timings https://timetoexplore.net/blog/video-timings-vga-720p-1080p
	// TODO: Determine Synchronization Paramaters
	localparam HS_STA = 655;    // horizontal sync start position
   localparam HS_END = 751;    // horizontal sync end position
   localparam HA_END = 639;    // horizontal active pixel end position
   localparam VS_STA = 489;    // vertical sync start position
   localparam VS_END = 491;    // vertical sync end position
   localparam VA_END = 479;    // vertical active pixel end position
   localparam LINE   = 799;    // complete line (pixels) 
   localparam SCREEN = 524;    // complete screen (lines)

   reg [9:0] h_count;  // line position
   reg [9:0] v_count;  // screen position

   //TODO: Determine conditions for HSync and VSync to be High/Low
   assign o_hs = ~(h_count >= HS_STA && h_count < HS_END);
   assign o_vs = ~(v_count >= VS_STA && v_count < VS_END);

   //TODO: Determine correct values for current x and y pixel
   //Keep pixels bound within the active pixels
   assign o_x = h_count;
   assign o_y = v_count;
	
   always @ (posedge i_clk) begin
		//TODO: What should counts be on reset
		if (i_rst)  // reset to start of frame
      begin
			h_count <= 0;
         v_count <= 0;
      end
      else begin
			//TODO: update counters when we hit the end of a horizontal line
			if (h_count == LINE)  // end of line
			begin
				h_count <= 0;
				v_count <= v_count + 1;
         end
         else 
			begin
			//TODO: update counters when we're not not at the end of the line
            h_count <= h_count + 1;
			end 
			//TODO: update counters when we hit the end of the screen (vertical lines)
         if (v_count == SCREEN)  // end of screen
			begin
            v_count <= 0;
			end
		end
	end
endmodule 