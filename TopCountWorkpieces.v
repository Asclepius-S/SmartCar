`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:40 06/26/2019 
// Design Name: 
// Module Name:    TopCountWorkpieces 
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
module TopCountWorkpieces(
		input clk,nCR,detector,
		output [3:0] Light,
		output [6:0] seg
    );
		wire CLK_Light;
		wire fall;
		wire [15:0] det_counter;

		Divider50MHz U0(.CLK_50M(clk),.nCLR(nCR),.CLK_1HzOut(CLK_Light));
		defparam U0.N=26, U0.CLK_Freq = 50000000, U0.OUT_Freq = 2400;
		
		EdgeDetect E0(	.clk(CLK_Light),.nCR(nCR),.button(detector),.fall(fall));
		
		Test T0(.detector(fall),.nCR(nCR),.det_counter(det_counter[15:0]));
		
		SEG_57lut U1(.CLK(CLK_Light),.det_counter(det_counter[15:0]),.dig(seg[6:0]),.light(Light[3:0]));

endmodule
