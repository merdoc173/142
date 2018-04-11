`include "Hazard.v"

module Hazard_fixture;

reg[3 : 0] if_id_op1, if_id_op2, id_ex_op1;
reg mem_write, over_flow, branch_jump_flag;
wire if_id_write, if_id_flash, id_hazard_flash, ex_flash, pc_write;

Hazard hazard(
.IF_ID_OP1(if_id_op1),
.IF_ID_OP2(if_id_op2),
.ID_EX_OP1(id_ex_op1),
.MEM_WRITE(mem_write),
.OVER_FLOW(over_flow),
.BRANCH_JUMP_FLAG(branch_jump_flag),
.IF_ID_WRITE(if_id_write),
.IF_ID_FLASH(if_id_flash),
.ID_HAZARD_FLASH(id_hazard_flash),
.EX_FLASH(ex_flash),
.PC_WRITE(pc_write)
);


initial $vcdpluson;

initial $monitor($time, " if_id_write %b, if_id_flash %b, id_hazard_flash %b, ex_flash %b, pc_write %b", if_id_write, if_id_flash, id_hazard_flash, ex_flash, pc_write);


initial 
begin
	if_id_op1 = 4'b0000; if_id_op2=4'b0000; id_ex_op1=4'b0000; 
	mem_write = 1'b0; over_flow=1'b0; branch_jump_flag=1'b0;

#10	
	if_id_op1 = 4'b0000; if_id_op2=4'b0000; id_ex_op1=4'b0000; 
	mem_write = 1'b0; over_flow=1'b0; branch_jump_flag=1'b1;

#10 
	if_id_op1 = 4'b0000; if_id_op2=4'b0000; id_ex_op1=4'b0000; 
	mem_write = 1'b0; over_flow=1'b1; branch_jump_flag=1'b0;


#10
	if_id_op1 = 4'b0001; if_id_op2=4'b0000; id_ex_op1=4'b0001; 
	mem_write = 1'b1; over_flow=1'b0; branch_jump_flag=1'b0;

#10
	if_id_op1 = 4'b0000; if_id_op2=4'b0001; id_ex_op1=4'b0001; 
	mem_write = 1'b1; over_flow=1'b0; branch_jump_flag=1'b0;

#10 	$finish;

end 
endmodule
