`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:32 06/26/2019 
// Design Name: 
// Module Name:    TopDesign 
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
module TopDesign(
	 input clk,
	 input [2:0] PathDectSignal,
	 input En_Tracing,
	 input SpeedControl,
	 input nCR,
	 input detector,
	 input another,
	 input nCR_Avoid,
	 input Echo_Signal,
	 output [3:0] Led_Direction,
	 output Speed_Wheel_1,Speed_Wheel_2,
	 output [1:0] Control_Wheel_1,
	 output [1:0] Control_Wheel_2,
	 output [3:0] Light,
	 output [6:0] seg,
	 output Trig_Signal
    );
	 
	 wire [1:0] AvoidSignal;
	 TopTracing Top0(clk,SpeedControl,En_Tracing,PathDectSignal,nCR_Avoid,AvoidSignal,Led_Direction,Speed_Wheel_1,Speed_Wheel_2,Control_Wheel_1,Control_Wheel_2);
	 TopCountWorkpieces Top1(clk,nCR,detector,Light,seg);
	 TopAvoidObstacle Top2(clk,nCR_Avoid,detector,another,Echo_Signal,Trig_Signal,AvoidSignal);

endmodule