`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:54:43 01/11/2019 
// Design Name: 
// Module Name:    my_alu 
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

module my_alu #(parameter NUMBITS = 32) (
    input clk,
    input reset,
    input [NUMBITS-1:0] A,
    input [NUMBITS-1:0] B,
    input [2:0] opcode,
    output reg [NUMBITS-1:0] result,
    output reg carryout,
    output reg overflow,
    output reg zero 
    );
	 
	 reg sA;
	 reg sB;
	 reg sSum;
	 	 	 
    localparam unsignedadd  = 3'b000;
	 localparam add 			 = 3'b001;
	 localparam unsignedsub  = 3'b010;
	 localparam sub 			 = 3'b011;
	 localparam ands 			 = 3'b100;
	 localparam ors 			 = 3'b101;
	 localparam xors 			 = 3'b110;
	 localparam divide 		 = 3'b111;
		
	 always @(posedge clk) 
	 begin
		case (opcode)
	   	unsignedadd: begin //unsigned add
			
			result = A + B;
			
			sA = A[NUMBITS-1];
			sB = B[NUMBITS-1];
			
			sSum = result[NUMBITS-1];
					
			if ( (sA == 1 && sB == 1) || ( sA == 1 && sB == 0 && sSum == 0) || (sB == 1 && sA == 0 && sSum == 0) )
				carryout = 1'b1;
			else
				carryout = 1'b0;
			
			zero = result == 0 ? 1 : 0;
			overflow = 0;
		end
			
		add: begin//signed add
			result = A + B;
			
			sA = A[NUMBITS-1];
			sB = B[NUMBITS-1];
			
			sSum = result[NUMBITS-1];
			
			overflow = sA != sB ? 0 : sB == sSum ? 0 : 1;

			if ( (sA == 1 && sB == 1) || ( sA == 1 && sB == 0 && sSum == 0) || (sB == 1 && sA == 0 && sSum == 0) )
				carryout = 1'b1;
			else
				carryout = 1'b0;
			
			zero = result == 0 ? 1 : 0;
			
		end
			
		unsignedsub: begin//unsigned sub
			result = A - B;
			
			sA = A[NUMBITS-1];
			sB = B[NUMBITS-1];
			
			sSum = result[NUMBITS-1];

			if ( B > A )
				carryout = 1'b1;
			else
				carryout = 1'b0;
			
			zero = result == 0 ? 1 : 0;
			overflow = 1'b0;
			
		end
			
		sub: begin//signed sub
			result = A - B; 			

			sA = A[NUMBITS-1];
			sB = B[NUMBITS-1];
			
			sSum = result[NUMBITS-1];
			
			overflow = sA == sB ? 0 : sB == sSum ? 1:0;
			carryout = 1'b0;		
			zero = result == 0 ? 1 : 0;
		end
			
		ands: begin//bitwise and
			result = A & B;
			
			overflow = 1'b0;
			carryout = 1'b0;
			zero = result == 0 ? 1 : 0;
		end
			
		ors: begin//bitwise or
			result = A | B;
			
			overflow = 1'b0;
			carryout = 1'b0;
			zero = result == 0 ? 1 : 0;
		end
			
		xors: begin//bitwise xor
			result = A ^ B;
			
			overflow = 1'b0;
			carryout = 1'b0;
			zero = result == 0 ? 1 : 0;
		end
			
		divide: begin//divide a by 2
			result = A >> 1;
			
			overflow = 1'b0;
			carryout = 1'b0;
			zero = result == 0 ? 1 : 0;
		end
		
			default: begin
				 result = 1'b0;
				 carryout = 1'b0;
				 overflow = 1'b0;
				 zero = 1'b1;
			end
		endcase
	 end


endmodule