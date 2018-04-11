`include "InstructionMemory.v"

module InstructionMemory_fixture;

reg clk, rst, write_enable, read_enable;
reg [15 : 0] address;
reg [15 : 0] data_in;
wire [15 : 0] data_out;
InstructionMemory im(.CLK(clk), .RST(rst), .WRITE_ENABLE(write_enable), .READ_ENABLE(read_enable), .ADDRESS(address), .DATA_IN(data_in), .DATA_OUT(data_out));

initial $vcdpluson;

initial clk = 1'b0;

always #5 clk = ~clk;

initial address = 16'h0000;

initial $monitor($time, " rst = %h, write_enable = %h, read_enable = %h, data_out %h", rst, write_enable, read_enable, data_out);
always@(posedge clk)
begin

	address = address + 16'h0002;

end 


initial
begin
	rst = 1'b1;
	
#10	rst = 1'b0; write_enable = 1'b0; read_enable = 1'b1; data_in = 16'h0000;
#400 ;
#10	$finish; 


end 
endmodule
