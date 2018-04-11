/*************************************************
 *
 * File:Program_Counter.v
 * Objective:A module for storage device
 * 
 ************************************************/


module ProgramCounter 
/***************************************
 *
 *
 *	PARAMETER DEFINITION
 *
 *
***************************************/
#(parameter WIDTH = 16, HEIGHT = 1)
(
input CLK, RST, WRITE_ENABLE, READ_ENABLE,
input [HEIGHT - 1 : 0] ADDRESS, 
input [WIDTH - 1 : 0] DATA_IN,
output reg [WIDTH - 1 : 0] DATA_OUT
);

reg [WIDTH - 1 : 0] MEMORY [HEIGHT - 1 : 0];

integer NUM = 0;

/* **************************************
 *
 *
 * 		WRITE
 *
 *  
 * *************************************/

always@(posedge CLK, negedge RST)
if(RST)
begin	
	for( NUM = 0 ; NUM < HEIGHT; NUM = NUM + 1 )
	begin
		MEMORY[ NUM ] <= 8'h0;
	end 
end 
else if(WRITE_ENABLE)
begin 
	MEMORY[ ADDRESS ] <= DATA_IN;
//	$display("From Program Counter Write");
//	$display("WRITE_ENABLE %b", WRITE_ENABLE);
//	$display("DATA_IN %h", DATA_IN);
//	$display("MEMORY %h", MEMORY[ ADDRESS ]);
//	$display("DATA_OUT %h", DATA_OUT);
	
end 


/* **************************************
 *
 *
 * 		READ
 *
 *  
 * *************************************/

always@(*)
	if(READ_ENABLE)
		begin
			DATA_OUT = MEMORY [ADDRESS];
//			$display("From Program Counter READ");
//			$display("WRITE_ENABLE %b", WRITE_ENABLE);
//			$display("DATA_IN %h", DATA_IN);
//			$display("MEMORY %h", MEMORY[ ADDRESS ]);
//			$display("DATA_OUT %h", DATA_OUT);
		end 
endmodule 
