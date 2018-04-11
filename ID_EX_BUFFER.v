module ID_EX_BUFFER
#(parameter WIDTH = 16, HEIGHT = 10)
(
input CLK, RST, READ_ENABLE, WRITE_ENABLE,
input [WIDTH-1:0] WRITE_BACK, MEMORY, EXECUTION, PROGRAM_COUNTER, REGISTER_VAL1, OP1_ADDRESS, OP2_ADDRESS, VALUE1, VALUE2, FUNC_CODE, 
output reg [WIDTH-1:0] WRITE_BACK_OUT, MEMORY_OUT, EXECUTION_OUT, PROGRAM_COUNTER_OUT, REGISTER_VAL1_OUT, OP1_ADDRESS_OUT, OP2_ADDRESS_OUT, VALUE1_OUT, VALUE2_OUT, FUNC_CODE_OUT);

reg [WIDTH-1:0] buff [HEIGHT-1:0];

integer i = 0;


/* Writing data to mem */
always@(posedge CLK, negedge RST)
	if(RST)
		for( i =0 ; i < HEIGHT; i = i + 1 )
			buff[i]<=16'h0000;
	else if(WRITE_ENABLE)
	begin 
		buff[0] <= WRITE_BACK;
		buff[1] <= MEMORY;
		buff[2] <= EXECUTION;
		buff[3] <= PROGRAM_COUNTER;
		buff[4] <= REGISTER_VAL1;
		buff[5] <= OP1_ADDRESS;
		buff[6] <= OP2_ADDRESS;
		buff[7] <= VALUE1;
		buff[8] <= VALUE2;
		buff[9] <= FUNC_CODE;
	end 
/* Reading data from mem */
always@(*)
	if(READ_ENABLE)
		begin
			WRITE_BACK_OUT = buff[0];
			MEMORY_OUT = buff[1];
			EXECUTION_OUT = buff[2];
			PROGRAM_COUNTER_OUT = buff[3];
			REGISTER_VAL1_OUT = buff[4];
			OP1_ADDRESS_OUT = buff[5];
			OP2_ADDRESS_OUT = buff[6];
			VALUE1_OUT = buff[7];
			VALUE2_OUT = buff[8];
			FUNC_CODE_OUT = buff[9];
		end 

endmodule 
