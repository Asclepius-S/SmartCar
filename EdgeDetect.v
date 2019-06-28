`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:04 06/26/2019 
// Design Name: 
// Module Name:    EdgeDetect 
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
module EdgeDetect(
	input clk,
	input nCR,
	input button,
	output reg fall
);
	localparam delay_param = 8'd24;
	reg[7:0] samp;//移位寄存器采集button键值
	//移位寄存器采集button信息
	always@(posedge clk or negedge nCR)
	begin
	if(!nCR)
	samp <= 0;
	else if(samp == delay_param)
	samp <= 0;
	else 
	samp <= samp +1;
	end
	
	wire	delay_10ms =(samp==delay_param)?1'b1:1'b0;
	reg  key_state;
	
	//产生下降沿信息
	always@(posedge clk or negedge nCR)
	begin
		if(!nCR)
			fall<=1'b1;
		else if(delay_10ms)
		begin
			 case(key_state)
				1'b1:
				begin
					if(button!=1'b1)
					begin
						fall <= 1;
					end
					key_state = button;
				end
				1'b0:
				begin
					if(button!=1'b0)
					begin
						fall <= 0;
					end
					key_state = button;
				end
			endcase
		end
	end
	
endmodule	

