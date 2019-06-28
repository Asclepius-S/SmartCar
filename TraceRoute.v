`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:16 06/26/2019 
// Design Name: 
// Module Name:    TraceRoute 
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
module TraceRoute(
    input clk,
	 input En_Tracing,
	 input nCR_Avoid,
	 input [1:0] AvoidSignal,
    input [2:0] PathDectSignal,
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
	 
	 
	 parameter Compare = 25000000;
	 reg [24:0] Count_clk = 0;
	 reg clk_1Hz = 1;
	 always @(posedge clk)   //clk是50Mhz的时钟信号
	 begin
	    if(Count_clk < Compare -1) 
	    begin       
		    Count_clk <= Count_clk + 1;
	    end
	    else 
	    begin
		    clk_1Hz <= ~clk_1Hz;
		    Count_clk <= 0;
   	 end
	 end
	 
	 reg stop = 0;
	 reg [7:0] count_for_noRoute = 0;	 //0101_1111_0101_1110_0001_0000_0000 1_1101_1100_1101_0110_0101_0000_0000
	 parameter TwoSeconds = 4;
	 
	 always @(posedge clk_1Hz)
	 begin
	   if(En_Tracing == 1)
		begin
	     if(PathDectSignal == 3'b101)
		  begin
			  if(count_for_noRoute <= 5) count_for_noRoute <= count_for_noRoute + 1;
			  else
			  begin
			 	  stop <= 1;
			  end
		  end
		  else count_for_noRoute <= 0;
      end
		else if(En_Tracing == 0) 
		begin
			stop <= 0;
			count_for_noRoute <= 0;
		end
	 end


	 
	 always @(posedge clk)
	 begin
	   if(nCR_Avoid == 0)
		begin
		if(En_Tracing == 1 && stop == 0)
		begin
			if(PathDectSignal == 3'b111)
			begin
				Led_Direction <= 4'b0110;
				Speed_Wheel_1 <= pwm_150;                                                      
				Speed_Wheel_2 <= pwm_150;                                                      
				Control_Wheel_1 <= 2'b01;                                                    
				Control_Wheel_2 <= 2'b01; 
				//count_for_noRoute <= 0;
				//count_for_noRoute <= 0;
			end
			else if(PathDectSignal == 3'b001)//left
			begin
				Led_Direction <= 4'b0100;
			   Speed_Wheel_1 <= pwm_220;                                                      
				Speed_Wheel_2 <= pwm_0;                                                      
				Control_Wheel_1 <= 2'b01;                                                    
				Control_Wheel_2 <= 2'b01;
				//count_for_noRoute <= 0;
				//count_for_noRoute <= 0;
			end
			else if(PathDectSignal == 3'b100)//right
			begin
				Led_Direction <= 4'b0010;
			   Speed_Wheel_1 <= pwm_0;                                                      
				Speed_Wheel_2 <= pwm_220;                                                      
				Control_Wheel_1 <= 2'b01;                                                    
				Control_Wheel_2 <= 2'b01; 
				//count_for_noRoute <= 0;
				//count_for_noRoute <= 0;
			end
			else if( PathDectSignal == 3'b011)//最左边检测到
			begin      
				//IFDelay <= 4'b0100;                                                                   
				Led_Direction <= 4'b1000;                                                             
				Speed_Wheel_1 <= pwm_250;                                                      
				Speed_Wheel_2 <= pwm_250;                                                      
				Control_Wheel_1 <= 2'b01;                                                    
				Control_Wheel_2 <= 2'b10;
				//count_for_noRoute <= 0;
				//delay(2);                                             
			end 
			else if( PathDectSignal == 3'b110)//最左边检测到
			begin      
				//IFDelay <= 4'b0100;                                                                   
				Led_Direction <= 4'b0001;                                                             
				Speed_Wheel_1 <= pwm_250;                                                      
				Speed_Wheel_2 <= pwm_250;                                                      
				Control_Wheel_1 <= 2'b10;                                                    
				Control_Wheel_2 <= 2'b01;
				//count_for_noRoute <= 0;
				//delay(2);                                             
			end 
			
			/*else if(PathDectSignal == 3'b101)
			begin
			   if(count_for_noRoute < TwoSeconds)
				begin
					Led_Direction <= 4'b1111;
					count_for_noRoute <= count_for_noRoute + 1; 
					Speed_Wheel_1 <= pwm_150;                                                      
					Speed_Wheel_2 <= pwm_150;                                                      
				   Control_Wheel_1 <= 2'b01;                                                    
					Control_Wheel_2 <= 2'b01; 
				end
				else
				begin
					Led_Direction <= 4'b0000;
					Speed_Wheel_1 <= pwm_0;                                                      
					Speed_Wheel_2 <= pwm_0;                                                      
				   Control_Wheel_1 <= 2'b00;                                                    
					Control_Wheel_2 <= 2'b00; 
					stop <= 1;
					//count_for_noRoute <= 0;
				end
			end*/
			else
			begin
				Speed_Wheel_1 <= pwm_150;                                                      
				Speed_Wheel_2 <= pwm_150;                                                      
			   Control_Wheel_1 <= 2'b01;                                                    
				Control_Wheel_2 <= 2'b01; 
			end
	   end
	   
	   else if(En_Tracing == 0 && stop == 0)
	   begin
	 	   Led_Direction <= 4'b1001;         
	      Speed_Wheel_1 <= pwm_150;                                                      
		   Speed_Wheel_2 <= pwm_150;                                                      
		   Control_Wheel_1 <= 2'b01;                                                    
		   Control_Wheel_2 <= 2'b01;   
			//count_for_noRoute <= 0;
			//stop <= 0;
	   end
		else
		begin
		   Led_Direction <= 4'b0000;         
	      Speed_Wheel_1 <= pwm_0;                                                      
		   Speed_Wheel_2 <= pwm_0;                                                      
		   Control_Wheel_1 <= 2'b00;                                                    
		   Control_Wheel_2 <= 2'b00;  
		end
		end
		else
		begin
			case(AvoidSignal)
			2'b00:
			begin
				Led_Direction <= 4'b1110;
				Speed_Wheel_1 <= pwm_220;                                                      
		      Speed_Wheel_2 <= pwm_220;                                                      
		      Control_Wheel_1 <= 2'b01;                                                    
		      Control_Wheel_2 <= 2'b01;
			end
			2'b10:
			begin
				Led_Direction <= 4'b1100;
				Speed_Wheel_1 <= pwm_220;                                                      
		      Speed_Wheel_2 <= pwm_220;                                                      
		      Control_Wheel_1 <= 2'b01;                                                    
		      Control_Wheel_2 <= 2'b10;
			end
			2'b01:
			begin
				Led_Direction <= 4'b0011;
				Speed_Wheel_1 <= pwm_220;                                                      
		      Speed_Wheel_2 <= pwm_220;                                                      
		      Control_Wheel_1 <= 2'b10;                                                    
		      Control_Wheel_2 <= 2'b01;
			end
			2'b11:
			begin
				Led_Direction <= 4'b1010;
				Speed_Wheel_1 <= pwm_220;                                                      
		      Speed_Wheel_2 <= pwm_220;                                                      
		      Control_Wheel_1 <= 2'b10;                                                    
		      Control_Wheel_2 <= 2'b10;
			end
			endcase
		
		
		end
    end
	 
	 
endmodule


