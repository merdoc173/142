/***************************************************************
 * File: RegisterFile
 *
 *
 * *************************************************************/
module RegisterFile 
#(parameter WIDTH = 16, HEIGHT = 16)
(
input CLK, RST, READ_ENABLE,
input [1 : 0] WRITE_ENABLE, 
input [HEIGHT / 4 - 1:0] OP1_ADDRESS, OP2_ADDRESS, WRITE_ADDRESS1, WRITE_ADDRESS2, 
input [WIDTH - 1 : 0] WRITE_DATA1, WRITE_DATA2,
output reg [WIDTH - 1 : 0] OP1_OUT, OP2_OUT
);

reg [WIDTH-1:0] mem [HEIGHT-1:0];

integer i = 0;

/*******************************************
 *
 *
 *		Write
 *
 *  
 ***************************************** */
always@(posedge CLK, negedge RST)
if(RST)
	begin
	for( i =0 ; i < HEIGHT; i = i + 1 ) 
		case(i)
			0:mem[i]<=16'h0000;
			1:mem[i]<=16'h0F00;
			2:mem[i]<=16'h0050;
			3:mem[i]<=16'hFF0F;
			4:mem[i]<=16'hF0FF;
			5:mem[i]<=16'h0040;
			6:mem[i]<=16'h0024;
			7:mem[i]<=16'h00FF;
			8:mem[i]<=16'hAAAA;
			9:mem[i]<=16'h0000;
			10:mem[i]<=16'h0000;
			11:mem[i]<=16'h0000;
			12:mem[i]<=16'hFFFF;
			13:mem[i]<=16'h0002;
			14:mem[i]<=16'h0000;
			15:mem[i]<=16'h0000;
		endcase
	end 
	else if(WRITE_ENABLE[0] && !WRITE_ENABLE[1])
		mem[WRITE_ADDRESS1] <= WRITE_DATA1;
	// this is only for multiplication and division 
	else if(WRITE_ENABLE[0] && WRITE_ENABLE[1])
		begin 
			mem[WRITE_ADDRESS1] <= WRITE_DATA1;
			mem[WRITE_ADDRESS2] <= WRITE_DATA2; 
		end 



/****************************************************
 *
 *
 *		            READ
 *
 *
 * **************************************************/

always@(*)
if(READ_ENABLE)
begin 
	OP1_OUT = mem[OP1_ADDRESS];
	OP2_OUT = mem[OP2_ADDRESS];
end 
endmodule 
