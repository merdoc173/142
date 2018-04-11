module Hazard
#(parameter DS = 4)
(
input [DS - 1 : 0] IF_ID_OP1, IF_ID_OP2, ID_EX_OP1, 
input MEM_WRITE, OVER_FLOW, BRANCH_JUMP_FLAG, 
output reg IF_ID_WRITE, IF_ID_FLASH, ID_HAZARD_FLASH, EX_FLASH, PC_WRITE
);
 

	/*********************************************
	 *	
	 *
	 *		Branch 
	 * PC 1, IF_ID_WRite 1, ID_HAZARD 1, 
	 * EX_Flash 0, 
	 * *******************************************/
	always@(*)
	
	
	begin
	if( BRANCH_JUMP_FLAG )
		begin	
		IF_ID_WRITE = 1'b0;
		IF_ID_FLASH = 1'b1;
		ID_HAZARD_FLASH = 1'b0;
		EX_FLASH = 1'b0;
		PC_WRITE = 1'b1;
		end 
	
	/*************************************************
	*
 	*	
 	*
 	*	         LW Hazard	
	*IF HAZARD -> WRITE DISABLE, ID HAZAARD FLASH, 
	*
 	* ***********************************************/
	else if(  MEM_WRITE && ( (ID_EX_OP1 == IF_ID_OP1) || (ID_EX_OP1 == IF_ID_OP2)) ) 	
		begin	
		IF_ID_WRITE = 1'b0;
		IF_ID_FLASH = 1'b0;
		ID_HAZARD_FLASH = 1'b1;
		EX_FLASH = 1'b0;
		PC_WRITE = 1'b1;
		end
	/*********************************************
	 *	
	 *
	 *		Overflow
	 *
	 *
	 * *******************************************/
	else if(OVER_FLOW)
		begin 
		IF_ID_WRITE = 1'b1;
		IF_ID_FLASH = 1'b1;
		ID_HAZARD_FLASH = 1'b1;
		EX_FLASH = 1'b0;
		PC_WRITE = 1'b1;
		end
	/*********************************************
	 *	
	 *
	 *		Default
	 *
	 *
	 * *******************************************/
	else 

		begin 
		IF_ID_WRITE = 1'b1;
		IF_ID_FLASH = 1'b0;
		ID_HAZARD_FLASH = 1'b0;
		EX_FLASH = 1'b0;
		PC_WRITE = 1'b1;
		end 
/*	
	$display("From Hazard Unit");
	$display(" MEM_WRITE %b", MEM_WRITE);
	$display(" OVER_FLOW %b", OVER_FLOW);
	$display(" BRANCH_JUMP_FLAG %b", BRANCH_JUMP_FLAG);
	$display(" PC_WRITE %b", PC_WRITE);
	$display(" IF_ID_WRITE %b", IF_ID_WRITE);
	$display(" IF_ID_FLASH %b", IF_ID_FLASH);
*/



//	$display("--------------------------------------------------------------------------------------------------------------------");
//	$display("-------------------------------------------------Hazard Unit-----------------------------------------------");

//	$display("IF_ID_WRITE %b, IF_ID_FLASH %b, ID_HAZARD_FLASH %b, EX_FLASH %b, PC_WRITE",IF_ID_WRITE, IF_ID_FLASH, ID_HAZARD_FLASH, EX_FLASH, PC_WRITE );

//	$display("--------------------------------------------------------------------------------------------------------------------");
 	
	end 
endmodule 
