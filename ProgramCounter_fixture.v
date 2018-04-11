`include "ProgramCounter.v"

/*************************************
 *
 *
 *	Program Counter Fixture
 *
 *
 ************************************/


module ProgramCounter_fixture;
parameter WIDTH = 16;

reg clk, rst, write_enable, read_enable, address;
reg [WIDTH - 1 : 0] data_in; 
wire[WIDTH - 1 : 0] data_out;

ProgramCounter pc( .CLK(clk), .RST(rst), .WRITE_ENABLE(write_enable), .READ_ENABLE(read_enable), .ADDRESS(address), .DATA_IN(data_in), .DATA_OUT(data_out));

initial $vcdpluson;

initial $monitor($time, " rst = %h write_enable = %h, read_enable = %h address = %h, data_in %h, data_out", rst, write_enable, read_enable, address, data_in, data_out);

initial clk = 1'b0;

always #5 clk = ~ clk;

initial 
begin 
	/**********************************************************
 	*			RESET
 	* ********************************************************/

	rst = 1'b1; write_enable = 1'b0; read_enable = 1'b0; address=1'b0; data_in = 16'h0000;

	#10 rst = 1'b0; write_enable = 1'b1; read_enable = 1'b1; address=1'b0; data_in = 16'h0000;

	#10 rst = 1'b0; write_enable = 1'b1; read_enable = 1'b1; address=1'b0; data_in = 16'h0002;

	#10 rst = 1'b0; write_enable = 1'b1; read_enable = 1'b1; address=1'b0; data_in = 16'h0004;
	#10 $finish;

end 

endmodule 
