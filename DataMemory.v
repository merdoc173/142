module DataMemory #(parameter WIDTH = 16, HEIGHT = 16)(input CLK, RST, WRITE_ENABLE, READ_ENABLE, input [HEIGHT - 1 : 0] ADDRESS, input [WIDTH - 1 : 0] DATA_IN, output reg [WIDTH - 1 : 0] DATA_OUT);


reg [WIDTH / 2 - 1 : 0] mem [ 100 : 0];

integer i = 0;

/* Writing data to instruction memory */
/*************************************/
// This memory is written in little endian 
// therefore, order is 
//       even * i     operand 1 operand 2
//       odd  * i     instruction 
/************************************/


always@(posedge CLK, negedge RST)
if(RST)
	for( i =0; i < 100 ; i = i + 2)
	begin	
		if(i==0)
		begin
			mem[i] = 8'h99;
			mem[i+16'h0001] = 8'hab;
		end
		else
		begin 	
			mem[i] <= 8'h00;
			mem[i+1] <= 8'h00;
		end 	
	end 
	else if(WRITE_ENABLE)
	begin
		mem[ADDRESS] <= DATA_IN[WIDTH / 2 - 1 : 0];
		mem[ADDRESS + 16'h01] <= DATA_IN[WIDTH - 1 : WIDTH / 2];
	end 
/* Reading data from mem */

always@(*)
if(READ_ENABLE)
	DATA_OUT = {  mem[ADDRESS], mem[ADDRESS + 16'h01 ]};


endmodule 
