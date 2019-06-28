`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:47 06/27/2019 
// Design Name: 
// Module Name:    TrigSignal 
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
module TrigSignal(clk_1m, rst, trig); //产生10us的触发信号
input clk_1m, rst;
output trig;

reg trig;
reg[19:0] count;
// 模1 000 000计数器
always@(posedge clk_1m, negedge rst)
begin
	if (~rst)
	begin
		count <= 0;
		trig <= 0;
	end
	else
	begin
		if(count>6000)
			count<=0;
		else
		begin
			if (2 == count)
				begin
					trig <= 0;
					count <= count + 1;
				end
			else 
				begin
					if (6000 == count)
						begin
							trig <= 1;
							count <= 0;
						end
					else
						count <= count + 1;
			end
		end//count ==1000000
	end//reset
end//always
endmodule

