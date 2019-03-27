`timescale 1ns / 1ps

module cs161_processor(
    clk ,
    rst ,   
	 // Debug signals 
    prog_count     , 
    instr_opcode   ,
    reg1_addr      ,
    reg1_data      ,
    reg2_addr      ,
    reg2_data      ,
    write_reg_addr ,
    write_reg_data  
    );

input wire clk ;
input wire rst ;
    
// Debug Signals

input wire[31:0] prog_count     ; 
input wire[5:0]  instr_opcode   ;
input wire[4:0]  reg1_addr      ;
input wire[31:0] reg1_data      ;
input wire[4:0]  reg2_addr      ;
input wire[31:0] reg2_data      ;
input wire[4:0]  write_reg_addr ;
input wire[31:0] write_reg_data ; //havee to changggggggggggggggggeeeeeeeeeee thisssssssss
//input wire[3:0] write_reg_data ; 

// Insert your solution below here.

wire reg_dst;
wire branch;    
wire mem_read;  
wire mem_to_reg;
wire [1:0]  alu_op;
wire mem_write;  
wire alu_src; 
wire reg_write;

wire funct;

//wire [31:0] pc;
wire [5:0] opcode;

//assign prog_count = pc;
//assign instr_opcode = opcode;

	cs161_datapath cx1 (
		.clk(clk),
		.rst(rst),
		.instr_op(instr_opcode),
		.funct(funct),
		.branch(branch),
		.mem_read(mem_read),
		.mem_to_reg(mem_to_reg),
		.alu_op(alu_out),
		.mem_write(mem_write),
		.alu_src(alu_src),
		.reg_write(reg_write),	
		.prog_count(prog_count),
		.instr_opcode(opcode),
		.reg_dst(reg_dst),
		.reg1_addr(reg1_addr),
		.reg1_data(reg1_data),
		.reg2_addr(reg2_addr),
		.reg2_data(reg2_data),
		.write_reg_addr(write_reg_addr),
		.write_reg_data(write_reg_data)
	);

	control_unit cx2 (
		//.clk(clk),
		//.rst(rst),
		.instr_op(opcode),
		.reg_dst(reg_dst),
		.branch(branch),    
		.mem_read(mem_read), 
		.mem_to_reg(mem_to_reg),
		.alu_op(alu_op),
		.mem_write(mem_write),  
		.alu_src(alu_src),
		.reg_write(reg_write)
	);	
	
	//control_unit cx3 (
	//);
	
	 
endmodule
