`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:09 06/27/2019 
// Design Name: 
// Module Name:    AvoidGoing 
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
module AvoidGoing(
	 input clk,
    input CLK_1s,
    input nCR,

    input left,
    input right,
    input [19:0]dis,

    output reg [1:0] AvoidSignal
    );

	 reg [3:0] env;
	 wire stright;

	 parameter isBlock = 20'd200;

	 assign stright = dis[19:0] < isBlock ? 1'b1 : 1'b0;//dis less than isBlock -> 1

	 assign testLight = env;

always @(posedge CLK_1s or negedge nCR)begin
	 if(~nCR)begin
	 env <= 3'b000;
    end
	 else begin
	 env <= {stright,~left,~right};
	 end
end

always @(posedge clk or negedge nCR)begin
    if(~nCR)begin
		 AvoidSignal <= 2'b00;
    end
    else begin
    case (env)
        3'b000: begin//stright
            AvoidSignal <= 2'b00;
        end
        3'b001: begin//stright
            AvoidSignal <= 2'b00;
        end
        3'b010: begin//stright
            AvoidSignal <= 2'b00;
        end
        3'b011: begin//stright
            AvoidSignal <= 2'b00;
        end
        3'b100: begin//left
           AvoidSignal <= 2'b10;
        end
        3'b101: begin//left
            AvoidSignal <= 2'b10;
        end
        3'b110: begin//right
            AvoidSignal <= 2'b01;
        end
        3'b111: begin//back
            AvoidSignal <= 2'b11;
        end
		  default:begin
				AvoidSignal <= 2'b00;		  
		  end
    endcase
    end
end

endmodule

