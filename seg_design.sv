//DAV Lab6 FPGAppy Birb
`timescale 1 ns/1 ns

module seg_design(point0, point1, point2, point3, point4, point5,
						out1, out2, out3, out4, out5, out6);
	input [3:0] point0, point1, point2, point3, point4, point5;
	output reg [7:0] out1, out2, out3, out4, out5, out6;
	
	always @(point0) begin
		case (point0)
			0: out1 =8'b11000000;
			1: out1 = 8'b11111001;
         2: out1 = 8'b10100100;
         3: out1 = 8'b10110000;
         4: out1 = 8'b10011001;
         5: out1 = 8'b10010010;
         6: out1 = 8'b10000010;
         7: out1 = 8'b11111000;
         8: out1 = 8'b10000000;
         9: out1 = 8'b10010000;
			default: out1 = 8'b11111111;
		endcase
	end
	
	always @(point1) begin
		case (point1)
			0: out2 = 8'b11000000;
			1: out2 = 8'b11111001;
         2: out2 = 8'b10100100;
         3: out2 = 8'b10110000;
         4: out2 = 8'b10011001;
         5: out2 = 8'b10010010;
         6: out2 = 8'b10000010;
         7: out2 = 8'b11111000;
         8: out2 = 8'b10000000;
         9: out2 = 8'b10010000;
			default: out2 = 8'b11111111;
		endcase
	end
	
	always @(point2) begin
		case (point2)
			0: out3 = 8'b11000000;
			1: out3 = 8'b11111001;
         2: out3 = 8'b10100100;
         3: out3 = 8'b10110000;
         4: out3 = 8'b10011001;
         5: out3 = 8'b10010010;
         6: out3 = 8'b10000010;
         7: out3 = 8'b11111000;
         8: out3 = 8'b10000000;
         9: out3 = 8'b10010000;
			default: out3 = 8'b11111111;
		endcase
	end
	
	always @(point3) begin
		case (point3)
			0: out4 = 8'b11000000;
			1: out4 = 8'b11111001;
         2: out4 = 8'b10100100;
         3: out4 = 8'b10110000;
         4: out4 = 8'b10011001;
         5: out4 = 8'b10010010;
         6: out4 = 8'b10000010;
         7: out4 = 8'b11111000;
         8: out4 = 8'b10000000;
         9: out4 = 8'b10010000;
			default: out4 = 8'b11111111;
		endcase
	end
	
	always @(point4) begin
		case (point4)
			0: out5 = 8'b11000000;
			1: out5 = 8'b11111001;
         2: out5 = 8'b10100100;
         3: out5 = 8'b10110000;
         4: out5 = 8'b10011001;
         5: out5 = 8'b10010010;
         6: out5 = 8'b10000010;
         7: out5 = 8'b11111000;
         8: out5 = 8'b10000000;
         9: out5 = 8'b10010000;
			default: out5 = 8'b11111111;
		endcase
	end
	
	always @(point5) begin
		case (point5)
			0: out6 = 8'b11000000;
			1: out6 = 8'b11111001;
         2: out6 = 8'b10100100;
         3: out6 = 8'b10110000;
         4: out6 = 8'b10011001;
         5: out6 = 8'b10010010;
         6: out6 = 8'b10000010;
         7: out6 = 8'b11111000;
         8: out6 = 8'b10000000;
         9: out6 = 8'b10010000;
			default: out6 = 8'b11111111;
		endcase
	end

endmodule 