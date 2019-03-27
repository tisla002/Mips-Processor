`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:10:21 02/01/2019
// Design Name:   alu_control
// Module Name:   C:/Users/takbi/Documents/cs161-working/Lab3/alu_control_testbench.v
// Project Name:  Lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_control_testbench;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] alu_op;
	reg [5:0] instruction_5_0;

	// Outputs
	wire [3:0] alu_out;

	// Instantiate the Unit Under Test (UUT)
	alu_control uut (
		.clk(clk), 
		.reset(reset), 
		.alu_op(alu_op), 
		.instruction_5_0(instruction_5_0), 
		.alu_out(alu_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0; reset = 0;
		
		alu_op = 0;
		instruction_5_0 = 0;
		#100;
		
		alu_op = 2'b00;
		instruction_5_0 = 6'b010101;
		#100; //add(0010)
        
		alu_op = 2'b01;
		instruction_5_0 = 6'b010101;
		#100; //sub
		
		alu_op = 2'b00;
		instruction_5_0 = 6'b010101;
		#100; //add

		alu_op = 2'b10;
		instruction_5_0 = 6'b100010;
		#100; //sub
		
		alu_op = 2'b10;
		instruction_5_0 = 6'b100100;
		#100; //and
		
		alu_op = 2'b10;
		instruction_5_0 = 6'b100101;
		#100; //or
		
		alu_op = 2'b10;
		instruction_5_0 = 6'b100111;
		#100; //nor
		
		alu_op = 2'b10;
		instruction_5_0 = 6'b101010;
		#100; //slt
		
		alu_op = 2'b10;
		instruction_5_0 = 6'b101111;
		#100; //not
		
		
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

