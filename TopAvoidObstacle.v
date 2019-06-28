`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:11 06/27/2019 
// Design Name: 
// Module Name:    TopAvoidObstacle 
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
module TopAvoidObstacle(
	input clk,
	input nCR_Avoid,
	input left,//左检测器
	input right,//右检测器
	input Echo_Signal,
	output Trig_Signal,
	output [1:0] AvoidSignal
    );
	 
	wire clk_1m;
	wire clk_seg;
	wire [19:0] dis; // 回波高电平持续时间us 
	wire CLK_1s;
	
	Divider50MHzAvoid A0(.CLK_50M(clk),.nCLR(nCR_Avoid),.CLK_1HzOut(clk_1m));//chaoshengbo
		defparam A0.N=26, A0.CLK_Freq = 50000000, A0.OUT_Freq = 100000;
	Divider50MHzAvoid A1(.CLK_50M(clk),.nCLR(nCR_Avoid),.CLK_1HzOut(clk_seg));//chaoshengbo
		defparam A1.N=26, A1.CLK_Freq = 50000000, A1.OUT_Freq = 2400;
	Divider50MHzAvoid A2(.CLK_50M(clk),.nCLR(nCR_Avoid),.CLK_1HzOut(CLK_1s));//chaoshengbo
		defparam A2.N=26, A2.CLK_Freq = 50000000, A2.OUT_Freq = 1;
	TrigSignal TS(.clk_1m(clk_1m), .rst(nCR_Avoid), .trig(Trig_Signal));//right
	
	PosCounter PC(.clk_1m(clk_1m), .rst(nCR_Avoid), .echo(Echo_Signal), .dis_count(dis)); 
	
	AvoidGoing AG( .clk(clk),
					.CLK_1s(CLK_1s),
					.nCR(nCR_Avoid),
					.left(left),
					.right(right),
					.dis(dis),
					.AvoidSignal(AvoidSignal));
		
	//SEG_57lut SEG(.CLK(clk_seg), .det_counter(dis[15:0]), .dig(seg[6:0]), .light(light[3:0]));

endmodule
