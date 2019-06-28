`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:01 06/26/2019 
// Design Name: 
// Module Name:    SEG_57lut 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SEG_57lut(CLK, det_counter, dig, light);

	input CLK;
	input [15:0] det_counter;
	output [6:0] dig;
	output reg[3:0] light;
	reg [3:0] dis;

	always @ (posedge CLK)
	begin
		case(light)
		4'b1110:
			begin
				light <= 4'b1101;
				dis <= det_counter[7:4];						
			end
		4'b1101:
			begin
				light <= 4'b1011;
				dis <= det_counter[11:8];				
			end
		4'b1011:
			begin
				light <= 4'b0111;	
				dis <= det_counter[15:12];					
			end
		4'b0111:
			begin
				light <= 4'b1110;	
				dis <= det_counter[3:0];					
			end	
		default:
			begin
				light <= 4'b1110;
				dis <= det_counter[3:0];
			end
		endcase
	end

	SEG7_LUT u1(.dig(dis), .seg(dig));
	
endmodule
