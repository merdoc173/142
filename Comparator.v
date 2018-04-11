/**********************************************************
 * File: Comparator 
 * 
 *	
 *
 *
 * ********************************************************/

module Comparator
#(parameter WIDTH = 16)
(
input [WIDTH - 1: 0] OP1, OP2, 
output reg ZERO, SIGN 
);

always@(*)
	if( OP1 == OP2 )
		begin
			ZERO = 1'b1;
			SIGN = 1'b0;
		end
	else if( OP1 > OP2 )
		begin
			ZERO = 1'b0;
			SIGN = 1'b1;
		end
	else if( OP1 < OP2 ) 
		begin
			ZERO = 1'b0;
			SIGN = 1'b0;
		end
endmodule 
