`include "ID_EX_BUFFER.v"

module ID_EX_BUFFER_fixture;

parameter WIDTH=16, HEIGHT=2;

reg clk, rst, read_enable, write_enable;

reg [WIDTH-1:0] write_back, memory, execution, proram_counter, reister_val1, op1_address, op2_address, value1, value2, func_code; 

wire [WIDTH-1:0] write_back_out, memory_out, execution_out, program_counter_out, register_val1_out, op1_address_out, op2_address_out, value1_out, value2_out, func_code_out;

IF_ID_BUFFER if_id
(
.CLK(clk), .RST(rst), .READ_ENABLE(read_enable), .WRITE_ENABLE(write_enable), .WRITE_BACK(write_back), 
.MEMORY(memory), 
.EXECUTION(execution), 
.PROGRAM_COUNTER(program_counter), 
.REGISTER_VAL1(register_val1), 
.OP1_ADDRESS(op1_address), 
.OP2_ADDRESS(op2_address), 
.VALUE1(value1), 
.VALUE2(value2), 
.FUNC_CODE(func_code),
.WRITE_BACK_OUT(write_back_out), 
.MEMORY_OUT(memory_out), 
.EXECUTION_OUT(execution_out), 
.PROGRAM_COUNTER_OUT(program_counter_out), 
.REGISTER_VAL1_OUT(register_val1_out), 
.OP1_ADDRESS_OUT(op1_address_out), 
.OP2_ADDRESS_OUT(op2_address_out), 
.VALUE1_OUT(value1_out), 
.VALUE2_OUT(value2_out), 
.FUNC_CODE_OUT(func_code_out) 
);

initial $vcdpluson;

initial 
$monitor($time, " rst %h, read_enable %h, write_enable %h, program_counter_out %h, instruction_out %h", rst, read_enable, write_enable);


initial clk = 1'b0;

always #5 clk = ~clk;

initial 
begin
	rst = 1'b1;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1; 
	write_back = 16'h0000;
	memory = 16'h0000;
	execution = 16'h0000;
	program_counter = 16'h0000;
	register_val1 = 16'h0000;
	op1_address = 16'h0000;
	op2_address = 16'h0000;
	value1 = 16'h0000;
	value2 = 16'h0000;
	func_code = 16'h000;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1; 

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b0;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;

#10 $finish;

end 
endmodule 
