module JUMP_BRANCH_UNIT
#(parameter OPSIZE = 4)
(
input [OPSIZE - 1 : 0] OP_CODE,
input ZERO, SIGN,
output reg JUMP_BRANCH_FLAG
);


/* This program has error. 
 *
 */
always@(*)
	case(OP_CODE)
	//BLT
	4'b0100:
	begin 
	if(SIGN ==  1'b0 && ZERO == 1'b0)
		JUMP_BRANCH_FLAG = 1'b1;
	else 
		JUMP_BRANCH_FLAG = 1'b0;

	end 
	//BGT	
	4'b0101:
	if(SIGN == 1'b1 && ZERO == 1'b0)
		JUMP_BRANCH_FLAG = 1'b1;
	else 
		JUMP_BRANCH_FLAG = 1'b0;

	//BEQ
	4'b0110:
	if(ZERO == 1'b1 && SIGN == 1'b0)
		JUMP_BRANCH_FLAG = 1'b1;
	else 
		JUMP_BRANCH_FLAG = 1'b0;

	//JUMP
	4'b1100:
		JUMP_BRANCH_FLAG = 1'b1;
	
	default:
		JUMP_BRANCH_FLAG = 1'b0;
	endcase

endmodule 
