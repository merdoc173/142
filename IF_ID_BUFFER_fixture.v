`include "IF_ID_BUFFER.v"

module IF_ID_BUFFER_fixture;

parameter WIDTH=16, HEIGHT=2;

reg clk, rst, read_enable, write_enable;
reg [WIDTH-1:0] program_counter, instruction; 
wire [WIDTH-1:0] program_counter_out, instruction_out;

IF_ID_BUFFER IF_ID
(
.CLK(clk), 
.RST(rst), 
.READ_ENABLE(read_enable), 
.WRITE_ENABLE(write_enable), 
.PROGRAM_COUNTER(program_counter), .INSTRUCTION(instruction),
.PROGRAM_COUNTER_OUT(program_counter_out), .INSTRUCTION_OUT(instruction_out) 
);

initial $vcdpluson;

initial 
$monitor($time, " rst %h, read_enable %h, write_enable %h, program_counter_out %h, instruction_out %h", rst, read_enable, write_enable, program_counter_out, instruction_out);

initial clk = 1'b0;

always #5 clk = ~clk;

initial 
begin
	rst = 1'b1;

#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1; 
	program_counter = 16'h0002; instruction = 16'hFFFF;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;
 	program_counter = 16'h0004; instruction = 16'hFFF2;
#10 	rst = 1'b1; read_enable = 1'b1; write_enable = 1'b1; 
	program_counter = 16'h0006; instruction = 16'hFFF3;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b0;
 	program_counter = 16'h0008; instruction = 16'hFFF4;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b1;
	 program_counter = 16'h000A; instruction = 16'hFFF5;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b0;
 	program_counter = 16'h0000; instruction = 16'h0000;
#10 	rst = 1'b0; read_enable = 1'b1; write_enable = 1'b0;
	 program_counter = 16'h000A; instruction = 16'hFFF5;
#10 $finish;

end 
endmodule 
