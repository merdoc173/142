`include "MEM_WB_BUFFER.v"



module MEM_WB_BUFFER_fixture;

reg clk, rst, write_enable;
reg [15:0] write_back, op1_address, alu_result_upper, alu_result_lower, mem_data;
wire [15:0] write_back_out, op1_address_out, alu_result_upper_out, alu_result_lower_out, mem_data_out;


MEM_WB_BUFFER mem_wb(
.CLK(clk),
.RST(rst),
.READ_ENABLE(1'b1),
.WRITE_ENABLE(write_enable),

.WRITE_BACK(write_back),
.OP1_ADDRESS(op1_address),
.ALU_RESULT_UPPER(alu_result_upper),
.ALU_RESULT_LOWER(alu_result_lower),
.MEM_DATA(mem_data),


.WRITE_BACK_OUT(write_back_out),
.OP1_ADDRESS_OUT(op1_address_out),
.ALU_RESULT_UPPER_OUT(alu_result_upper_out),
.ALU_RESULT_LOWER_OUT(alu_result_lower_out),
.MEM_DATA_OUT(mem_data_out)

);

initial $vcdpluson;

initial $monitor($time, "rst %b  write_back %h, op1_address %h, alu_result_upper %h, alu_result_lower %h, mem_data %h,\n\n write_back_out %h, op1_address_out %h, alu_result_upper_out %h, alu_result_lower_out %h, mem_data_out %h \n\n", rst, write_back, op1_address, alu_result_upper, alu_result_lower, mem_data, write_back_out, op1_address_out, alu_result_upper_out, alu_result_lower_out, mem_data_out);

initial clk = 1'b0;

always #5 clk = ~clk ;




initial 
begin 
	rst = 1'b1;
#10 	rst = 1'b0;
#10 	write_enable = 1'b1; write_back = 16'h0000; op1_address = 16'h0000; 
alu_result_upper = 16'h0000; 
alu_result_lower = 16'h0000;
mem_data = 16'h0000; 

#10 	write_enable = 1'b1; write_back = 16'hffff; op1_address = 16'hffff; 
alu_result_upper = 16'hffff; 
alu_result_lower = 16'hfff;
mem_data = 16'hffff; 

#10 	write_enable = 1'b0; write_back = 16'h0000; op1_address = 16'h0000; 
alu_result_upper = 16'h0000; 
alu_result_lower = 16'h0000;
mem_data = 16'h0000; 

#10 	write_enable = 1'b1; write_back = 16'h0001; op1_address = 16'h0001; 
alu_result_upper = 16'h0001; 
alu_result_lower = 16'h0001;
mem_data = 16'h0001; 

#10 	write_enable = 1'b1; write_back = 16'h0002; op1_address = 16'h0002; 
alu_result_upper = 16'h0002; 
alu_result_lower = 16'h0002;
mem_data = 16'h0002; 

#10 	write_enable = 1'b1; write_back = 16'h0003; op1_address = 16'h0003; 
alu_result_upper = 16'h0003; 
alu_result_lower = 16'h0003;
mem_data = 16'h0003; 











#10 $finish;
end 
endmodule
