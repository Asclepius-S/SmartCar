`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:39:44 06/17/2019
// Design Name:   topDesign
// Module Name:   F:/Xlinx/Project/DriveCar/DirectionTest.v
// Project Name:  DriveCar
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topDesign
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DirectionTest;

	// Inputs
	reg clk;
	reg [3:0] PathDectSignal;
	reg En_Tracing;
	reg [1:0] SpeedControl;

	// Outputs
	wire Speed_Wheel_1;
	wire Speed_Wheel_2;
	wire [1:0] Control_Wheel_1;
	wire [1:0] Control_Wheel_2;
   parameter PERIOD = 20;
	// Instantiate the Unit Under Test (UUT)
	topDesign uut (
		.clk(clk), 
		.PathDectSignal(PathDectSignal), 
		.En_Tracing(En_Tracing),
		.SpeedControl(SpeedControl),
		.Speed_Wheel_1(Speed_Wheel_1), 
		.Speed_Wheel_2(Speed_Wheel_2), 
		.Control_Wheel_1(Control_Wheel_1), 
		.Control_Wheel_2(Control_Wheel_2)
	);
	
	always begin
	        clk = 1'b0;
			  #(PERIOD/2) clk = 1'b1;
			  #(PERIOD/2);
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		En_Tracing = 1;
		SpeedControl = 2'b11;
		PathDectSignal = 4'b1000;

		// Wait 100 ns for global reset to finish
		#100000000;
      PathDectSignal = 4'b0001;  
		// Add stimulus here
		#100000000;
		PathDectSignal = 4'b1100;
		#100000000;
		En_Tracing = 0;
		PathDectSignal = 4'b0011;
		#100000000;
		PathDectSignal = 4'b1101;
		#100000000;
		PathDectSignal = 4'b1011;  
		#100000000;
		PathDectSignal = 4'b1001; 
	end
      
endmodule

