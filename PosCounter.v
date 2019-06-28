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
module PosCounter(clk_1m, rst, echo, dis_count); // ���ز��ߵ�ƽ����ʱ��

	input clk_1m, rst, echo;
	output[19:0] dis_count;

	/*
	���� 1us��ʱ��
	���� ��λ�ź�
	���� echo
	��� ����õľ���
	*/

	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; // ״̬���� S0:����, S1:��ʼ������, S2:����������
	reg[1:0] curr_state, next_state;
	reg echo_reg1, echo_reg2;
	assign start = echo_reg1&~echo_reg2;  //���posedge
	assign finish = ~echo_reg1&echo_reg2; //���negedge
	reg[19:0] count, dis_reg;
	wire[19:0] dis_count; //������

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
			  echo_reg1 <= echo;          // ��ǰ
			  echo_reg2 <= echo_reg1;     // ǰһ��
			  case(curr_state)
			  S0:begin//����״̬
						 if (start==1) // ��⵽������
							  curr_state <= next_state; //S1
						 else
							  count <= 0;
					end
			  S1:begin//echo״̬
						 if (finish==1) // ��⵽�½���
							  curr_state <= next_state; //S2
						 else
							  begin
									count <= count + 1;
							  end
					end
			  S2:begin//����״̬
						 dis_reg <= count; // ����������
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

	assign dis_count = dis_reg ; // ���룬��100ȡС������

endmodule
