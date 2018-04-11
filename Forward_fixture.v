`include "Forward.v"

module Forward_fixture;

reg[ 3: 0 ] op1, op2, exe_mem_op1, mem_wb_op1;
reg exe_mem_wb, mem_wb_wb;
wire [1 : 0] fm1, fm2;


Forward forward(
.OP1(op1),
.OP2(op2),
.EXE_MEM_OP1(exe_mem_op1),
.MEM_WB_OP1(mem_wb_op1),
.EXE_MEM_WB(exe_mem_wb),
.MEM_WB_WB(mem_wb_wb),
.FM1(fm1),
.FM2(fm2)
);

initial $vcdpluson;

initial $monitor("op1 %h, op2 %h \n exe_mem_op1 %h, mem_wb_op1 %h, \n exe_mem_wb %b, mem_wb_wb %b, \nfm1 %b, fm2 %b\n ",op1, op2, exe_mem_op1, mem_wb_op1, exe_mem_wb, mem_wb_wb, fm1, fm2);

initial 
begin 
	op1=4'b0001; op2=4'b0000; exe_mem_op1=4'b0001; mem_wb_op1=4'b1111; exe_mem_wb=1'b1; mem_wb_wb=1'b0;


#10 op1=4'b0000; op2=4'b0001; exe_mem_op1=4'b0001; mem_wb_op1=4'b1111; exe_mem_wb=1'b1; mem_wb_wb=1'b0;
#10 op1=4'b0001; op2=4'b0000; exe_mem_op1=4'b0000; mem_wb_op1=4'b0001; exe_mem_wb=1'b0; mem_wb_wb=1'b1;
#10 op1=4'b0000; op2=4'b0001; exe_mem_op1=4'b0000; mem_wb_op1=4'b0001; exe_mem_wb=1'b1; mem_wb_wb=1'b1;
#10 op1=4'b0000; op2=4'b0000; exe_mem_op1=4'b0000; mem_wb_op1=4'b1111; exe_mem_wb=1'b1; mem_wb_wb=1'b1;
end 
endmodule
