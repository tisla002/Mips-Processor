`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:06:32 02/01/2019 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit  (
    input wire   [5:0] instr_op, 
    output reg  reg_dst,   
    output reg  branch,     
    output reg  mem_read,  
    output reg  mem_to_reg,
    output reg  [1:0] alu_op,        
    output reg  mem_write, 
    output reg  alu_src,    
    output reg  reg_write
 );
 
localparam Rformat =6'b000000;
localparam lw =6'b100011;
localparam sw =6'b101011;
localparam beq =6'b000100;
localparam imm = 6'b001000;

always @(*) begin
	////////////////
		case (instr_op)
		Rformat: begin
		
			assign reg_dst = 1;
			assign alu_src = 0;
			assign mem_to_reg = 0;
			assign reg_write = 1;
			assign mem_read = 0;
			assign mem_write = 0;
			assign branch = 0;
			assign alu_op = 2; 		
			
		end
		endcase
		/////////////////
		/////////////////
		case (instr_op)
		lw: begin
			
			assign reg_dst = 0;
			assign alu_src = 1;
			assign mem_to_reg = 1;
			assign reg_write = 1;
			assign mem_read = 1;
			assign mem_write = 0;
			assign branch = 0;
			assign alu_op = 0;
		
		end
		endcase
		/////////////////
		/////////////////
		case (instr_op)
		sw: begin
			
			assign reg_dst = 0;
			assign alu_src = 1;
			assign mem_to_reg = 0;
			assign reg_write = 0;
			assign mem_read = 0;
			assign mem_write = 1;
			assign branch = 0;
			assign alu_op = 0;
		
		end
		endcase
		/////////////////
		/////////////////
		case (instr_op)
		beq: begin
		
			assign reg_dst = 0;
			assign alu_src = 0;
			assign mem_to_reg = 0;
			assign reg_write = 0;
			assign mem_read = 0;
			assign mem_write = 0;
			assign branch = 1;
			assign alu_op = 2;
			
		end
		endcase
		/////////////////
		/////////////////
		case (instr_op)
		imm: begin
			
			assign reg_dst = 0;
			assign alu_src = 1;
			assign mem_to_reg = 0;
			assign reg_write = 1;
			assign mem_read = 0;
			assign mem_write = 0;
			assign branch = 0;
			assign alu_op = 0;
 		
		end
		endcase
		////////////////
	
end



endmodule
