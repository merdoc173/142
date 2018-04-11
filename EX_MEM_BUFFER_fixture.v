`include "EX_MEM_BUFFER.v"

module EX_MEM_BUFFER_fixture;

reg clk, rst, read_enable, write_enable;


reg [15:0] write_back, memory, register_val1, op1_address, alu_result_upper, alu_result_lower;
wire  [15:0] write_back_out, memory_out, register_val1_out, op1_address_out, alu_result_upper_out, alu_result_lower_out;



EX_MEM_BUFFER ex_me(
.CLK(clk),
.RST(rst),
.READ_ENABLE(read_enable),
.WRITE_ENABLE(write_enable),

.WRITE_BACK(write_back),
.MEMORY(memory),
.REGISTER_VAL1(register_val1),
.OP1_ADDRESS(op1_address),
.ALU_RESULT_UPPER(alu_result_upper),
.ALU_RESULT_LOWER(alu_result_lower),

.WRITE_BACK_OUT(write_back_out),
.MEMORY_OUT(memory_out),
.REGISTER_VAL1_OUT(register_val1_out),
.OP1_ADDRESS_OUT(op1_address_out),
.ALU_RESULT_UPPER_OUT(alu_result_upper_out),
.ALU_RESULT_LOWER_OUT(alu_result_lower_out)
);

initial clk = 1'b0;

initial $monitor($time, "rst = %b, read_enable %b, write_enable %b, write_back_out %h, memory_out %h, register_val1_out %h, op1_address_out %h, alu_result_upper %h, alu_result_lower %h", rst, read_enable, write_enable, write_back_out, memory_out, register_val1_out, op1_address_out, alu_result_upper_out, alu_result_lower_out);

always #5 clk = ~clk;


initial 
begin
	rst = 1'b1;
#10     rst = 1'b0;
#10 	read_enable = 1'b1; 
	write_enable = 1'b0; 
	write_back = 16'h0000;
	memory = 16'h0000;
	register_val1 = 16'h0000;
	op1_address = 16'h0000;
	alu_result_upper = 16'h0000;
	alu_result_lower = 16'h0000;

#10 	read_enable = 1'b1; 
	write_enable = 1'b1; 
	write_back = 16'h0001;
	memory = 16'h0002;
	register_val1 = 16'h0003;
	op1_address = 16'h0004;
	alu_result_upper = 16'h0005;
	alu_result_lower = 16'h0006;

#10 	read_enable = 1'b1; 
	write_enable = 1'b1; 
	write_back = 16'hffff;
	memory = 16'hffff;
	register_val1 = 16'hffff;
	op1_address = 16'hffff;
	alu_result_upper = 16'hffff;
	alu_result_lower = 16'hffff;

#10 	read_enable = 1'b1; 
	write_enable = 1'b0; 
	write_back = 16'h0000;
	memory = 16'h0000;
	register_val1 = 16'h0000;
	op1_address = 16'h0000;
	alu_result_upper = 16'h0000;
	alu_result_lower = 16'h0000;

#10 	$finish;




end 
endmodule 
