`timescale 1ns / 1ps

module fpgappy_bird_skeleton(
		input wire in_clk,           // board clock: 50 MHz on Max10 Lite
		input wire btnRst,           // reset button
		input wire btnFlap,          // flap button
		output wire Hsync,           // horizontal sync output
		output wire Vsync,       	  // vertical sync output
		output wire [3:0] vgaRed,    // 4-bit VGA red output
		output wire [3:0] vgaGreen,  // 4-bit VGA green output
		output wire [3:0] vgaBlue,   // 4-bit VGA blue output
		output [7:0] seg_5,	        // Segments to light up
		output [7:0] seg_4,
		output [7:0] seg_3,
		output [7:0] seg_2,
		output [7:0] seg_1,
		output [7:0] seg_0
	);
	
	//25 MHz
	wire VGA_clk;
	
	//25 Hz
	wire phys_clk;
	
	//TODO: Make 25 MHz clock for VGA to function
	clk_div #(.count_from(0), .count_to(1))
				VGA_clk_div (.in(in_clk), .out(VGA_clk));
	//TODO: Make 25 Hz clock for physics to run at
	clk_div #(.count_from(0), .count_to(2000000))
				phys_clk_div (.in(in_clk), .out(phys_clk));
	
	// Display coords
	wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
   wire [9:0] y;  // current pixel y position:  9-bit value: 0-511
	
	// Points
	wire [3:0] points_5;
	wire [3:0] points_4;
	wire [3:0] points_3;
	wire [3:0] points_2;
	wire [3:0] points_1;
	wire [3:0] points_0;
	wire point_add;
	
	// Game Logic
	wire bird_die;
	wire out_of_bounds;
	
	// Game hitboxes and bounds
	wire bird_bounds;
	wire [11:0] bird_x1, bird_x2, bird_y1, bird_y2;
	wire floor_bounds;
	wire [11:0] floor_x1, floor_x2, floor_y1, floor_y2;
	wire sky_bounds;
	wire pipe_bounds;
	wire [11:0] pipe_x1, pipe_x2, pipe_y1, pipe_y2;

   //TODO: Instantiate VGA Design Module
	vga_skeleton myVGA (
		.i_clk(VGA_clk),
		.i_rst(~btnRst),
		.o_hs(Hsync),
		.o_vs(Vsync),
		.o_x(x),
		.o_y(y)
	);
	
	scoreboard _scoreboard (
		.points_5(points_5),
		.points_4(points_4),
		.points_3(points_3),
		.points_2(points_2),
		.points_1(points_1),
		.points_0(points_0),
		.rst(~btnRst),
		.clk(in_clk),
		.point_add(point_add),
		.bird_die(bird_die)
	);
	
	//TODO: Instantiate Seven Segment Design
	//Seven Segment design takes in the point values (look at declared wires)
	//as input and output the proper binary values for the seven segment display
	//for each digit
	seg_design mySeg(points_0, points_1, points_2, points_3, points_4, points_5, 
						  seg_0, seg_1, seg_2, seg_3, seg_4, seg_5);
	
	// Draw Floor
   rectangle #(.IX(320), .IY(465), .X_SIZE(320), .Y_SIZE(15)) _floor (
      .i_clk(in_clk), 
      .i_rst(~btnRst),
      .o_x1(floor_x1),
      .o_x2(floor_x2),
      .o_y1(floor_y1),
		.o_y2(floor_y2)
   );
	
	// Player-controlled Bird
	bird #(.H_SIZE(20), .IX(160), .IY(120), .GRAV(1)) _bird (
      .i_clk(phys_clk), 
      .i_rst(~btnRst | bird_die),
		.flap(~btnFlap),
      .o_x1(bird_x1),
      .o_x2(bird_x2),
      .o_y1(bird_y1),
      .o_y2(bird_y2),
		.out_of_bounds(out_of_bounds)
	);    
	
	
	// Infinitely generated pipes
	pipe #(.X_SIZE(40), .Y_HOLE(80), .IX(680), .IY(240)) _pipe (
		.i_clk(phys_clk), 
      .i_rst(~btnRst | bird_die),
      .p1_x1(pipe_x1),
      .p1_x2(pipe_x2),
		.p1_y1(pipe_y1),
		.p1_y2(pipe_y2),
		.point_add(point_add)
	);
	
	// Check what pixel color(s) should be drawn
	assign bird_bounds = ((x > bird_x1) && (y > bird_y1) && (x < bird_x2) && (y < bird_y2)) ? 1 : 0;
	assign floor_bounds = ((x > floor_x1) && (y > floor_y1) && (x < floor_x2) && (y < floor_y2)) ? 1 : 0;
	assign pipe_bounds = ((x > pipe_x1) && (x < pipe_x2) && ((y < pipe_y1) || (y > pipe_y2))) ? 1 : 0;
	assign sky_bounds = (~bird_bounds && ~floor_bounds) ? 1 : 0;
	
	//TODO: Assign Colors Properly
	//When x,y pixel is a bird area, it should be red, else it should be black
	//When x,y pixel is a pipe or floor, it should be green, else it should be black
	//When x,y pixel is part of the sky, it should be blue, else it should be black
	//Hint: Look above
	assign vgaRed = (bird_bounds) ? 15 : 0;
	assign vgaGreen = (floor_bounds || pipe_bounds) ? 15 : 0;
	assign vgaBlue = (sky_bounds) ? 15 : 0;


	// Bird dies if it collides with a pipe or goes out of bounds
	assign bird_die = ((bird_x2 > pipe_x1) && (bird_x2 < pipe_x2) && (bird_y1 < pipe_y1)) || 
							((bird_x1 > pipe_x1) && (bird_x2 < pipe_x2) && (bird_y1 < pipe_y1)) ||
							((bird_x1 < pipe_x2) && (bird_x2 > pipe_x2) && (bird_y1 < pipe_y1)) ||
							((bird_x2 > pipe_x1) && (bird_x2 < pipe_x2) && (bird_y2 > pipe_y2)) || 
							((bird_x1 > pipe_x1) && (bird_x2 < pipe_x2) && (bird_y2 > pipe_y2)) ||
							((bird_x1 < pipe_x2) && (bird_x2 > pipe_x2) && (bird_y2 > pipe_y2)) ||
							out_of_bounds;
       
endmodule
