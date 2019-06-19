`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:20 06/17/2019 
// Design Name: 
// Module Name:    DirectionChange 
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
module DirectionChange(
         input clk,
	 input En_Tracing,
         input [3:0] PathDectSignal,
	 input pwm_255,
	 input pwm_250,
	 input pwm_220,
	 input pwm_150,
	 input pwm_0,
	 output reg [3:0] Led_Direction,
	 output reg Speed_Wheel_1,
	 output reg Speed_Wheel_2,
	 output reg [1:0] Control_Wheel_1,
	 output reg [1:0] Control_Wheel_2
    );
	 
	 always @(clk)
	 begin
	 
	 if(En_Tracing == 1)
	 begin
	 
           if( (PathDectSignal[3] == 0 || PathDectSignal[2] == 0) && PathDectSignal[0] == 0)//处理右锐角和右直角的转动
	   begin   
	     //IFDelay <= 4'b0001;                                                                      
	     Led_Direction <= 4'b0011;                                                             
		  Speed_Wheel_1 <= pwm_250;                                                      
		  Speed_Wheel_2 <= pwm_250;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b10;       
		  //delay(80);                                             
	   end 
	 
	   else if( PathDectSignal[3] == 0 && (PathDectSignal[1] == 0 || PathDectSignal[0] == 0) )//处理左锐角和左直角的转动
	   begin     
	     //IFDelay <= 4'b1000;                                                                    
	     Led_Direction <= 4'b1100;                                                             
		  Speed_Wheel_1 <= pwm_250;                                                      
		  Speed_Wheel_2 <= pwm_250;                                                      
		  Control_Wheel_1 <= 2'b10;                                                    
		  Control_Wheel_2 <= 2'b01;       
		  //delay(80);                                             
	   end
	 
	   else if( PathDectSignal[3] == 0 )//最左边检测到
	   begin      
	     //IFDelay <= 4'b0100;                                                                   
	     Led_Direction <= 4'b1000;                                                             
		  Speed_Wheel_1 <= pwm_150;                                                      
		  Speed_Wheel_2 <= pwm_150;                                                      
		  Control_Wheel_1 <= 2'b10;                                                    
		  Control_Wheel_2 <= 2'b01;       
		  //delay(2);                                             
	   end 
	 
	   else if( PathDectSignal[0] == 0 )//最右边检测到
	   begin    
	     //IFDelay <= 4'b0010;                                                                     
	     Led_Direction <= 4'b0001;                                                             
		  Speed_Wheel_1 <= pwm_150;                                                      
		  Speed_Wheel_2 <= pwm_150;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b10;       
		  //delay(2);                                             
	   end 
	 
	   else if( PathDectSignal[2] == 0 && PathDectSignal[1] ==1 )//处理左小弯
	   begin                                                                         
	     Led_Direction <= 4'b0100;                                                             
		  Speed_Wheel_1 <= pwm_0;                                                      
		  Speed_Wheel_2 <= pwm_220;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b01;                                                    
	   end      
	 
	   else if( PathDectSignal[2] == 1 && PathDectSignal[1] ==0 )//处理右小弯
	   begin                                                                         
	     Led_Direction <= 4'b0010;                                                             
		  Speed_Wheel_1 <= pwm_220;                                                      
		  Speed_Wheel_2 <= pwm_0;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b01;                                                    
	   end 
	 
	   else if( PathDectSignal[2] == 0 && PathDectSignal[1] ==0 )//处理直线
	   begin                                                                         
	     Led_Direction <= 4'b0110;                                                             
		  Speed_Wheel_1 <= pwm_255;                                                      
		  Speed_Wheel_2 <= pwm_255;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b01;                                                   
	   end
	 
	   else
	   begin//偏离轨道
	     Led_Direction <= 4'b1111;
	     Speed_Wheel_1 <= pwm_150;                                                      
		  Speed_Wheel_2 <= pwm_150;                                                      
		  Control_Wheel_1 <= 2'b01;                                                    
		  Control_Wheel_2 <= 2'b01; 
	   end
    	
	 end
	 
	 else
	 begin
	    Speed_Wheel_1 <= pwm_255;                                                      
		 Speed_Wheel_2 <= pwm_255;
		 Control_Wheel_1 <= 2'b01;                                                    
		 Control_Wheel_2 <= 2'b01;
	 end
	 
	 end
	 
	 
endmodule
