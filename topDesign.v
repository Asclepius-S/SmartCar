`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:51 06/17/2019 
// Design Name: 
// Module Name:    topDesign 
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
module topDesign(
	 input clk,
	 input [1:0] SpeedControl,
	 input En_Tracing,
	 input [3:0] PathDectSignal,
	 output [3:0] Led_Direction,
	 output [1:0] Led_Speed,
	 output Speed_Wheel_1,
	 output Speed_Wheel_2,
	 output [1:0] Control_Wheel_1,
	 output [1:0] Control_Wheel_2
    );
	 //wire pwm_100, pwm_75, pwm_50, pwm_25, pwm_0;
	 PWM U0(clk, SpeedControl, pwm_255, pwm_250, pwm_220, pwm_150, pwm_0, Led_Speed);
	 DirectionChange U1(clk, En_Tracing, PathDectSignal, pwm_255, pwm_250, pwm_220, pwm_150, pwm_0, Led_Direction,
	                    Speed_Wheel_1, Speed_Wheel_2, Control_Wheel_1, Control_Wheel_2);


endmodule
