`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:34 06/27/2019 
// Design Name: 
// Module Name:    PosCounter 
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
module PosCounter(clk_1m, rst, echo, dis_count); // 检测回波高电平持续时间

	input clk_1m, rst, echo;
	output[19:0] dis_count;

	/*
	输入 1us的时钟
	输入 复位信号
	输入 echo
	输出 计算好的距离
	*/

	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; // 状态定义 S0:闲置, S1:开始测距计数, S2:结束测距计数
	reg[1:0] curr_state, next_state;
	reg echo_reg1, echo_reg2;
	assign start = echo_reg1&~echo_reg2;  //检测posedge
	assign finish = ~echo_reg1&echo_reg2; //检测negedge
	reg[19:0] count, dis_reg;
	wire[19:0] dis_count; //测距计数

	always@(posedge clk_1m, negedge rst)
	begin
		 if(~rst)
		 begin
			  echo_reg1 <= 0;
			  echo_reg2 <= 0;
			  count <= 0;
			  dis_reg <= 0;
			  curr_state <= S0;
		 end
		 else
		 begin
			  echo_reg1 <= echo;          // 当前
			  echo_reg2 <= echo_reg1;     // 前一个
			  case(curr_state)
			  S0:begin//闲置状态
						 if (start==1) // 检测到上升沿
							  curr_state <= next_state; //S1
						 else
							  count <= 0;
					end
			  S1:begin//echo状态
						 if (finish==1) // 检测到下降沿
							  curr_state <= next_state; //S2
						 else
							  begin
									count <= count + 1;
							  end
					end
			  S2:begin//结束状态
						 dis_reg <= count; // 缓存计数结果
						 count <= 0;
						 curr_state <= next_state; //S0
					end
			  endcase
		 end
	end

	always@(curr_state)
	begin
		 case(curr_state)
		 S0:next_state <= S1;
		 S1:next_state <= S2;
		 S2:next_state <= S0;
		 default: next_state <= S0;
		 endcase
	end

	assign dis_count = dis_reg ; // 距离，乘100取小数部分

endmodule
