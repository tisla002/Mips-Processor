
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

`define WORD_SIZE 32

module cs161_datapath(
    clk ,     
    rst ,     
    instr_op ,
    funct   , 
    reg_dst , 
    branch  , 
    mem_read , 
    mem_to_reg ,
    alu_op    , 
    mem_write  ,
    alu_src  ,  
    reg_write ,    
	 
    // Debug Signals
    prog_count ,  
    instr_opcode ,  
    reg1_addr   ,  
    reg1_data  ,   
    reg2_addr  ,   
    reg2_data  ,   
    write_reg_addr ,
    write_reg_data
    );

 input wire  clk ; 
 input wire  rst ;
 
 output wire[5:0] instr_op ;
 output wire[5:0] funct  ;  
 
 input wire   reg_dst  ;
 input wire   branch   ;
 input wire   mem_read ;
 input wire   mem_to_reg ;
 input wire[1:0] alu_op  ;  
 input wire   mem_write ;
 input wire   alu_src   ; 
 input wire   reg_write  ;
 
// ----------------------------------------------
// Debug Signals
// ----------------------------------------------
  
 output wire[`WORD_SIZE-1:0]  prog_count ;
 output wire[5:0] instr_opcode   ;  
 output wire[4:0] reg1_addr     ;   
 output wire[`WORD_SIZE-1:0] reg1_data ;
 output wire[4:0] reg2_addr   ;   
 output wire[`WORD_SIZE-1:0] reg2_data ;
 output wire[4:0] write_reg_addr  ;
 output wire[`WORD_SIZE-1:0] write_reg_data ;
 

// Insert your solution below here.
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
//wire [15:0] sign_extend_input;
wire [5:0] alu_control_instr;
wire [`WORD_SIZE-1:0] read_data_output;
wire [`WORD_SIZE-1:0] mem2reg_data_output;
wire [`WORD_SIZE-1:0] write_data_input;
wire [`WORD_SIZE-1:0] read_data_1;
wire [`WORD_SIZE-1:0] read_data_2;
wire [`WORD_SIZE-1:0] instruction;
wire [`WORD_SIZE-1:0] alu_result;
wire [`WORD_SIZE-1:0] add_alu_result;
wire [`WORD_SIZE-1:0] pc_update_select;
wire [`WORD_SIZE-1:0] alusrc_mux_output;
reg [`WORD_SIZE-1:0] pc;
wire [4:0] regdst_mux_output;
wire [31:0] sign_extend_output;
wire [3:0] alu_input;
wire [`WORD_SIZE-1:0] zero;
wire [`WORD_SIZE-1:0] shift_left_2;
wire [7:0] alu_result_addr;

initial begin
	pc = 0;
end

always @(posedge clk) begin
	if(rst) begin 
		pc = 0;
	end
	else begin
		if(zero & branch)
			pc = pc + shift_left_2;
		else
			pc = pc + 4;
	end
	
end


assign alu_result_addr = alu_result[7:0];

cpumemory Instruction_Memory (
    .clk(clk),
    .rst(rst),
    .instr_read_address(pc/4),
    .instr_instruction(instruction),
	 .data_address(alu_result_addr),
    .data_mem_write(mem_write),     
    .data_write_data(read_data_2),
    .data_read_data(read_data_output)
);

assign opcode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign alu_control_instr = instruction[5:0];

mux_2_1 regdst_mux (
    .select_in(reg_dst),
    .datain1(rt),
    .datain2(rd),
    .data_out(regdst_mux_output)
);



	cpu_registers Registers (
		.clk(clk),
		.rst(rst),
		.read_register_1(rs),
		.read_register_2(rt),
	   .write_register(regdst_mux_output),//	
	   .write_data(write_data_input),
		.read_data_1(read_data_1),
		.read_data_2(read_data_2),
		.reg_write(reg_write)
	);
	
assign sign_extend_output = { {16{instruction[15]}}, instruction[15:0]};

alu_control ALU_Control (
    .alu_op(alu_op),
    .instruction_5_0(alu_control_instr),
    .alu_out(alu_input)
);

mux_2_1 alusrc_mux (
    .select_in(alu_src),
    .datain1(read_data_2),
    .datain2(sign_extend_output),
    .data_out(alusrc_mux_output)
);

alu ALU (
    .alu_control_in(alu_input),
    .channel_a_in(read_data_1),
    .channel_b_in(alusrc_mux_output),
    .zero_out(zero),
    .alu_result_out(alu_result)
);

assign shift_left_2 = sign_extend_output << 2;
assign add_alu_result = shift_left_2 + pc;
assign pc_update_select = zero & branch;

mux_2_1 mem2reg_mux (
    .select_in(mem_to_reg),
    .datain1(alu_result),
    .datain2(read_data_output),
    .data_out(write_data_input)
);

	assign prog_count = pc;
	assign instr_opcode = opcode;
	assign instr_op = opcode;
	assign funct = opcode;
	assign reg1_addr = rs;
	assign reg1_data = read_data_1;
	assign reg2_addr = rt;
	assign reg2_data = read_data_2;
	assign write_reg_addr = regdst_mux_output;
	assign write_reg_data = write_data_input;
	
endmodule


