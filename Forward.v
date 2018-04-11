module Forward#(parameter WIDTH = 4)
(
input[WIDTH - 1:0] OP1, OP2, EXE_MEM_OP1, MEM_WB_OP1, 
input EXE_MEM_WB, MEM_WB_WB,
output reg[1:0] FM1, FM2
);



always@(*)
	begin	
	//op1 is using value from exe_mem	
	if( (OP1 == EXE_MEM_OP1) && (EXE_MEM_OP1 != 0 ) && EXE_MEM_WB )
		FM1 = 2'b01;
	//op1 is using value from memory writeback
	else if( (OP1 == MEM_WB_OP1) && (MEM_WB_OP1 != 0 ) && MEM_WB_WB )
		FM1 = 2'b10;
	else
		FM1 = 2'b00;
	//op2 is using value from exe_mem
	if( (OP2 == EXE_MEM_OP1) && (EXE_MEM_OP1 != 0 ) && EXE_MEM_WB )
		FM2 = 2'b01;	
	//op2 is using value from memory writeback
	else if( (OP2 == MEM_WB_OP1) && (MEM_WB_OP1 != 0 ) && MEM_WB_WB )
		FM2 = 2'b10;
	else 
		FM2 = 2'b00;
	end
endmodule 
