`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:16:41 06/17/2019
// Design Name:   PWM
// Module Name:   F:/Xlinx/Project/DriveCar/PWM_test.v
// Project Name:  DriveCar
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PWM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PWM_test;

	// Inputs
	reg clk;
	reg [1:0] SpeedControl;

	// Outputs
	wire pwm_255, pwm_250, pwm_220, pwm_150, pwm_0;
   parameter PERIOD = 20;
	// Instantiate the Unit Under Test (UUT)
	PWM uut (
		.clk(clk), 
		.SpeedControl(SpeedControl),
		.pwm_255(pwm_255),
		.pwm_250(pwm_250),
		.pwm_220(pwm_220),
		.pwm_150(pwm_150),
		.pwm_0(pwm_0)
	);
	always begin
	        clk = 1'b0;
			  #(PERIOD/2) clk = 1'b1;
			  #(PERIOD/2);
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		SpeedControl = 2'b00;

		// Wait 100 ns for global reset to finish
		#100000000;
		SpeedControl = 2'b01;
		#100000000;
		SpeedControl = 2'b10;
		#100000000;
		SpeedControl = 2'b11;
		#100000000;
		SpeedControl = 2'b00;
		#100000000;
		SpeedControl = 2'b11;
		#100000000;
		SpeedControl = 2'b10;
		#100000000;
        
		// Add stimulus here

	end
      
endmodule
