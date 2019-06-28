`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:52 06/26/2019 
// Design Name: 
// Module Name:    Test 
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
module Test(input detector,
				input nCR,
				output reg [15:0] det_counter); 
		
			
		always@(negedge detector or negedge nCR)
		begin
		begin
			if(~nCR)
				begin
					det_counter <= 0;
				end
			else 
			begin
				if(det_counter[3:0] == 4'b1001)
				begin 
					if(det_counter[7:4] == 4'b1001)
					begin
						if(det_counter[11:8] == 4'b1001)
						begin
							if(det_counter[15:12] == 4'b1001)
							begin
								det_counter <= 0;
							end
							else
							begin
								det_counter[11:0] <= 0;
								det_counter[15:12] <= det_counter[15:12] + 1;
							end
						end
						else
						begin
							det_counter[7:0] <= 0;
							det_counter[11:8] <= det_counter[11:8] + 1;
						end
					end
					else
					begin
						det_counter[3:0] <= 0;
						det_counter[7:4] <= det_counter[7:4] + 1;
					end
				end
				else
				begin
					det_counter[3:0] <= det_counter[3:0] + 1;
				end
			end
		end
		end
endmodule
