`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:58 06/26/2019 
// Design Name: 
// Module Name:    PWM 
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
module PWM(
	input clk,
	input SpeedControl,
	output pwm_250,
	output pwm_220,
	output pwm_150,
	output pwm_0
    );
	 
	reg [19:0] count_for_pwmclk=0;  //pwm_clk���ۼ���
	reg pwm_clk=0;                  //pwm_clk���ź�
	
	always @(posedge clk)   //clk��50Mhz��ʱ���ź�
	begin

        if(count_for_pwmclk == 20'b0000_0000_0000_1111_1010-1)
		  begin    // 0.01ms����һ�Σ���pwm���ξ���Ϊ0.01ms 
            count_for_pwmclk <= 0;
            pwm_clk <= ~pwm_clk;   //��λȡ��
        end
        else
            count_for_pwmclk <= count_for_pwmclk + 1;
	end
	
	reg [11:0] count_pwm=0;
	reg [11:0] pwm_compare250_Ori=12'b0111_1010_1001;  //�ٶ�250PWM���Ƚ�ֵ
	reg [11:0] pwm_compare220_Ori=12'b0110_1011_1101;  //�ٶ�220PWM���Ƚ�ֵ
	reg [11:0] pwm_compare150_Ori=12'b0011_0010_0000;  //�ٶ�150PWM���Ƚ�ֵ001111101000
	reg [11:0] pwm_compare250, pwm_compare220, pwm_compare150;

	reg pwm_flag250=0;  
	reg pwm_flag220=0;
	reg pwm_flag150=0;

	always @(posedge pwm_clk)    //����pwm�ź����
	begin
	   case(SpeedControl)
		  1'b1:	  
		  begin
		    pwm_compare250 <= pwm_compare250_Ori / 2;
			 pwm_compare220 <= pwm_compare220_Ori / 2;
			 pwm_compare150 <= pwm_compare150_Ori / 2;
		  end
		  default: 
		  begin
		    pwm_compare250 <= 0;
			 pwm_compare220 <= 0;
			 pwm_compare150 <= 0;
		  end
		endcase
	
		count_pwm<=count_pwm+1;		

		if (count_pwm < pwm_compare250 && SpeedControl != 2'b00)   //�ٶ�250PWM��
			pwm_flag250<=1;
			else
			pwm_flag250<=0;

		if (count_pwm < pwm_compare220 && SpeedControl != 2'b00)   //�ٶ�220PWM��
			pwm_flag220<=1;
			else
			pwm_flag220<=0;
		
		if (count_pwm < pwm_compare150 && SpeedControl != 2'b00)   //�ٶ�150PWM��
			pwm_flag150<=1;
			else
			pwm_flag150<=0;

		if (count_pwm == 12'b0111_1101_0000-1)  //ÿ0.01ms��һ�Σ���2000�μ�Ϊ20ms������
			count_pwm<=0;

	end

assign pwm_250=pwm_flag250;   //pwm_flag��Ϊ��Ӧ������ڵļĴ���
assign pwm_220=pwm_flag220;
assign pwm_150=pwm_flag150;
assign pwm_0=0;


endmodule

