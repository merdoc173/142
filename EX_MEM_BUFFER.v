module EX_MEM_BUFFER 
#(parameter WIDTH = 16, HEIGHT = 6)
(
input CLK, RST, READ_ENABLE, WRITE_ENABLE, 
input [WIDTH-1:0] WRITE_BACK, MEMORY, REGISTER_VAL1, OP1_ADDRESS, ALU_RESULT_UPPER, ALU_RESULT_LOWER, 
output reg [WIDTH-1:0] WRITE_BACK_OUT, MEMORY_OUT, REGISTER_VAL1_OUT, OP1_ADDRESS_OUT, ALU_RESULT_UPPER_OUT, ALU_RESULT_LOWER_OUT
);

reg [WIDTH-1:0] buff [HEIGHT-1:0];

integer i = 0;

/*********************************************
 *
 *
 *		Write
 *
 *
 * ***************************************** */
always@(posedge CLK, negedge RST)
	if(RST)
		for( i =0 ; i < HEIGHT; i = i + 1 )
			buff[i]<=16'h0000;
	else if(WRITE_ENABLE)
	begin 
		buff[0] <= WRITE_BACK;
		buff[1] <= MEMORY;
		buff[2] <= REGISTER_VAL1;
		buff[3] <= OP1_ADDRESS;
		buff[4] <= ALU_RESULT_UPPER;
		buff[5] <= ALU_RESULT_LOWER;
	end 
/*************************************************
 *
 *
 *		READ
 *
 *
 * ************************************************/
always@(*)
	if(READ_ENABLE)
		begin
			WRITE_BACK_OUT = buff[0];
			MEMORY_OUT = buff[1];
			REGISTER_VAL1_OUT = buff[2];
			OP1_ADDRESS_OUT = buff[3];
			ALU_RESULT_UPPER_OUT = buff[4];
			ALU_RESULT_LOWER_OUT = buff[5];
		end 

endmodule 
