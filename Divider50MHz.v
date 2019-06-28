`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:01 06/26/2019 
// Design Name: 
// Module Name:    Divider50MHz 
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
module Divider50MHz(CLK_50M,nCLR,CLK_1HzOut);     //1HZ
     parameter N = 26;
     parameter CLK_Freq = 100000000;
     parameter OUT_Freq = 1;
     input CLK_50M,nCLR;
     output reg CLK_1HzOut;
     reg [N-1:0] Cout_DIV;
	  
     always@(posedge CLK_50M or negedge nCLR)
       begin
       	if(!nCLR) begin
       		CLK_1HzOut <= 0;
       		Cout_DIV <= 0;
       	end
       	else begin
       		if(Cout_DIV < (CLK_Freq/(2*OUT_Freq)-1))
       			Cout_DIV <= Cout_DIV + 1'b1;
       		else begin
       			Cout_DIV <= 0;
       			CLK_1HzOut <= ~CLK_1HzOut;
       		end
       		end
       	end
endmodule

