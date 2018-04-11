module ALUControl
#(parameter WIDTH = 4)
(
input [WIDTH - 1 : 0] FUNC_CODE, EXECUTION, 
output reg [WIDTH - 1 : 0] ALU_FUNC_CODE
);

	always@(*)
	begin
		if(EXECUTION == 4'b0000)	
			ALU_FUNC_CODE = FUNC_CODE;
		else
			ALU_FUNC_CODE = EXECUTION;
	end
endmodule 
