`include "ALUControl.v"

module ALUControl_fixture;

reg [3:0] func_code, execution;
wire [3:0] alu_func_code;

ALUControl alucon(.FUNC_CODE(func_code),.EXECUTION(execution),.ALU_FUNC_CODE(alu_func_code));

initial $vcdpluson;

initial $monitor("func code %h, execution %h, alu func code %h", func_code, execution, alu_func_code);

initial 
begin 

$display("A Operation");
	func_code = 4'h0; execution = 4'h0;
#10	func_code = 4'hf; execution = 4'h0;
#10	func_code = 4'he; execution = 4'h0;
#10	func_code = 4'h6; execution = 4'h0;
#10	func_code = 4'hd; execution = 4'h0;
#10	func_code = 4'h0; execution = 4'he;
$display("B C D Operation");
#10	func_code = 4'hf; execution = 4'he;
#10	func_code = 4'he; execution = 4'hf;
#10	func_code = 4'h6; execution = 4'hf;
#10	func_code = 4'hd; execution = 4'hf;
end 
endmodule
