`timescale 1ns / 1ps
/*
 *
 *	Scoreboard Module
 *	--------------------
 *	Counts points up to 4 digits
 *
 */
module scoreboard( // Outputs
				points_5, points_4, points_3, points_2, points_1, points_0,
				// Inputs
				rst, clk, point_add, bird_die);
	input rst;
	input clk;
	input point_add;
	input bird_die;
	reg [1:0] point_add_reg;
	
	reg [19:0] points;
	
	output [3:0] points_5 = (points / 100000) % 10;
	output [3:0] points_4 = (points / 10000) % 10;
	output [3:0] points_3 = (points / 1000) % 10;
	output [3:0] points_2 = (points / 100) % 10;
	output [3:0] points_1 = (points / 10) % 10;
	output [3:0] points_0 = points % 10;
	

	always @ (posedge clk) begin
		if(rst | bird_die) begin
			points = 0;
		end
		point_add_reg = {point_add_reg[0], point_add};
		if(point_add_reg[1] == 0 && point_add_reg[0] == 1) begin
			points = points + 1;
		end
	end
	
endmodule