`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:37 06/26/2019 
// Design Name: 
// Module Name:    TopTracing 
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
module TopTracing(
	 input clk,
	 input SpeedControl,
	 input En_Tracing,
	 input [2:0] PathDectSignal,
	 input nCR_Avoid,
	 input [1:0] AvoidSignal,
	 output [3:0] Led_Direction,
	 output Speed_Wheel_1,Speed_Wheel_2,
	 output [1:0] Control_Wheel_1,
	 output [1:0] Control_Wheel_2
    );
	 
	 PWM Trace0(clk, SpeedControl, pwm_250, pwm_220, pwm_150, pwm_0);
	 TraceRoute Trace1(clk, En_Tracing, nCR_Avoid, AvoidSignal, PathDectSignal, pwm_250, pwm_220, pwm_150, pwm_0, Led_Direction,
	                    Speed_Wheel_1, Speed_Wheel_2, Control_Wheel_1, Control_Wheel_2);


endmodule
