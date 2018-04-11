`include "cpu.v"

module cpu_fixture;

reg clk, rst;

cpu cpu1(.clk(clk), .rst(rst));

initial $vcdpluson;

initial clk = 1'b0;

always #5 clk = ~ clk;

initial 
begin
	rst = 1'b1;
#10 rst = 1'b0;
#300 $finish;



end 
endmodule 
