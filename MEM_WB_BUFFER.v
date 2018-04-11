/*****************************************
 * File: MEM_WB_BUFFER
 *
 *
 *
 *
 * ****************************************/


module MEM_WB_BUFFER 
#(parameter WIDTH = 16, HEIGHT = 6)
(
input CLK, RST, READ_ENABLE, WRITE_ENABLE, 
input [WIDTH-1:0] WRITE_BACK, OP1_ADDRESS, ALU_RESULT_UPPER, ALU_RESULT_LOWER, MEM_DATA, 
output reg [WIDTH-1:0] WRITE_BACK_OUT, OP1_ADDRESS_OUT, ALU_RESULT_UPPER_OUT, ALU_RESULT_LOWER_OUT, MEM_DATA_OUT);

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
		buff[1] <= OP1_ADDRESS;
		buff[2] <= ALU_RESULT_UPPER;
		buff[3] <= ALU_RESULT_LOWER;
		buff[4] <= MEM_DATA;
	end 
/* Reading data from mem */
always@(*)
	if(READ_ENABLE)
		begin
			WRITE_BACK_OUT = buff[0];
			OP1_ADDRESS_OUT = buff[1];
			ALU_RESULT_UPPER_OUT = buff[2];
			ALU_RESULT_LOWER_OUT = buff[3];
			MEM_DATA_OUT = buff[4];
		end 

endmodule 
