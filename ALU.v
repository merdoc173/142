/********************************************************************************
 * This unit has following instrucitons.
 * 
 * 	        	opcode   op1   	op2	func code
 *  Signed Add   	0000  	 reg	reg 	1111
 *  Signed Sub		0000     reg    reg     1110
 *  Bitwise OR      0000     reg    reg     1100	 
 *  Bitwise And 	0000     reg    reg     1101
 *  Signed Mult 	0000     reg    reg     0001
 *  Signed Div 		0000	 reg 	reg 	0010
 *  Logical Shift R	0000 	 reg	imm	1010
 *  Logical Shift L	0000	 reg 	imm	1011
 *  Rotate Left		0000	 reg 	imm	1000
 *  Rotate Right	0000	 reg 	imm	1001
 *
 ********************************************************************************/


module ALU 
#(parameter DSIZE = 32, FSIZE = 4) 
(
input[FSIZE-1:0] FUNC_CODE, input [ DSIZE / 2 - 1 : 0 ] OP1, OP2, 
output reg OVERFLOW, INVALID,  
output reg signed [ DSIZE / 2 - 1 : 0 ] VALUE0, VALUE1
);


reg [ DSIZE / 2 - 1 : 0] RESULT_LOWER, RESULT_UPPER;

always@(*)
begin
	case(FUNC_CODE)
		//4'b0000:			
		
		// signed multi  
		4'b0001: 	
		{RESULT_UPPER, RESULT_LOWER} = OP1 * OP2;
		
		4'b0010: // Signed Div 	
		begin
			if( (OP1 == 0) && (OP2 == 0) )
				begin
				INVALID = 1'b1;						
				end 	
 			else 
				begin
				INVALID = 1'b0;
				RESULT_LOWER = OP1 / OP2; 
				RESULT_UPPER = OP1 % OP2;
				end 
		end 
		/*	
		4'b0011:	



		4'b0100:	

		4'b0101:	

		4'b0110:	

		4'b0111:	
		*/

		/***********************
		 *
		 *
		 *       Rotate Left
		 *
		 *
		 * *********************/

		4'b1000:  //Rotate Left 
		begin
			RESULT_LOWER = { OP1, OP1 } << OP2 % 4'hf; 
			RESULT_UPPER = 16'h0000;
		end 
		4'b1001:  //Rotate Right 	
		begin
		RESULT_LOWER = { OP1, OP1 } >> OP2 % 4'hf;
		RESULT_UPPER = 16'h0000;
		end 
		4'b1011:  //Logical Shift R 	
		begin
		RESULT_LOWER = OP1 >> OP2;		
		RESULT_UPPER = 16'h0000;

		end 
		4'b1010: //Logical Shift L 		
		begin
		RESULT_LOWER = OP1 << OP2;
		RESULT_UPPER = 16'h0000;

		end 
		4'b1100: // Bitwise Or 	
		begin
		RESULT_LOWER = OP1 | OP2;		
		RESULT_UPPER = 16'h0000;


		end 
		4'b1101: /* Bitwise And */	
		begin	
		RESULT_LOWER = OP1 & OP2;
		RESULT_UPPER = 16'h0000;

		end 
		4'b1110: /* Signed Sub */	
		begin
		{RESULT_UPPER, RESULT_LOWER} = OP1 - OP2; 	
		
		if(!OP1[15] && OP2[15])
			OVERFLOW = RESULT_LOWER[15];
		else if(OP1[15] && !OP2[15])	
			OVERFLOW = RESULT_LOWER[15];
		else if(!OP1[15] && !OP2[15] && (OP2 > OP1))	
			OVERFLOW = !RESULT_LOWER[15];
		else if (!OP1[15] && !OP2[15] && (OP1 >= OP2)) 
			OVERFLOW = RESULT_LOWER[15];
		end 
		4'b1111: /* Signed Add */ 
		begin
		{RESULT_UPPER, RESULT_LOWER} = OP1 + OP2; 
		//$display("OP1 %h OP2 %h", OP1, OP2);
		//$display("result %h", {RESULT_UPPER, RESULT_LOWER});	
		if(!OP1[15] && !OP2[15])
			OVERFLOW = RESULT_LOWER[15];
		else if(OP1[15] && OP2[15])	
			OVERFLOW = !RESULT_LOWER[15];
		end
		
		
		default:
		$display("ERROR IN ALU");
	endcase

	{VALUE1, VALUE0} = {RESULT_UPPER, RESULT_LOWER};
end

endmodule
