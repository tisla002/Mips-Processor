`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:38:46 02/07/2019
// Design Name:   control_unit
// Module Name:   C:/Users/takbi/Documents/cs161-working/Lab3/control_unit_testbench.v
// Project Name:  Lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_unit_testbench;

	// Inputs
	reg clk;
	reg [5:0] instr_op;

	// Outputs
	wire reg_dst;
	wire branch;
	wire mem_read;
	wire mem_to_reg;
	wire [1:0] alu_op;
	wire mem_write;
	wire alu_src;
	wire reg_write;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.clk(clk), 
		.instr_op(instr_op), 
		.reg_dst(reg_dst), 
		.branch(branch), 
		.mem_read(mem_read), 
		.mem_to_reg(mem_to_reg), 
		.alu_op(alu_op), 
		.mem_write(mem_write), 
		.alu_src(alu_src), 
		.reg_write(reg_write)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		
		instr_op = 6'b100011; //lw
		#100;
		      
		instr_op = 6'b000000; //r-format
		#100;
		
		
		
		instr_op = 6'b101011; //sw
		#100;
		
		instr_op = 6'b000100; //beq
		#100;
		
		instr_op = 6'b001000; //imm
		#100;

		
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

