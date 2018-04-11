`include "DataMemory.v"


module DataMemory_fixutre;

reg clk, rst, write_enable;
reg[15 : 0] address, data_in;
wire[15 : 0] data_out;


DataMemory dm(
.CLK(clk),
.RST(rst),
.WRITE_ENABLE(write_enable),
.READ_ENABLE(1'b1),
.ADDRESS(address),
.DATA_IN(data_in),
.DATA_OUT(data_out)
);



initial $vcdpluson;


initial clk = 1'b0;

always #5 clk = ~ clk;

initial $monitor($time, " rst %b, datain %h dataout %h", rst, data_in, data_out);


initial 
begin 
	rst = 1'b1;



#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0000; data_in = 16'hffff;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0000; data_in = 16'hffff;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0000; data_in = 16'hffff;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0000; data_in = 16'hffff;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0000; data_in = 16'hffff;


#10 $display("write");
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0000; data_in = 16'h0001;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0002; data_in = 16'h0002;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0004; data_in = 16'h0003;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0006; data_in = 16'h0004;
#10 rst = 1'b0; write_enable = 1'b1; address = 16'h0008; data_in = 16'h0005;

#10 $display("read");
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0000; data_in = 16'h0000;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0002; data_in = 16'h0000;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0004; data_in = 16'h0000;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0006; data_in = 16'h0000;
#10 rst = 1'b0; write_enable = 1'b0; address = 16'h0008; data_in = 16'h0000;

#10 $finish;
end 


endmodule
