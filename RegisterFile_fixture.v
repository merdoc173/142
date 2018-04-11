/***************************************************************
 * File: RegisterFile
 *
 * *************************************************************/
`include "RegisterFile.v"

module RegisterFile_fixture; 

reg clk, rst;
reg [1:0] write_enable;
reg [3 : 0] op1_address, op2_address, write_address1, write_address2;
reg [15 : 0] write_data1, write_data2;
wire [15 : 0] op1_out, op2_out;

RegisterFile rf(
.CLK(clk), .RST(rst), .READ_ENABLE(1'b1),
.WRITE_ENABLE(write_enable), .OP1_ADDRESS(op1_address), .OP2_ADDRESS(op2_address), .WRITE_ADDRESS1(write_address1), .WRITE_ADDRESS2(write_address2),
.WRITE_DATA1(write_data1), .WRITE_DATA2(write_data2),
 .OP1_OUT(op1_out), .OP2_OUT(op2_out)
);


initial $vcdpluson;

initial $monitor($time, "");

initial clk = 1'b0;

always #5 clk = ~ clk;

initial $monitor($time, " rst %h, op1_address %h, op1_out %h",rst, op1_address, op1_out);

always@(posedge clk, negedge rst)
begin
	if(rst)
	begin

	end

	if(!rst)
	begin
		op1_address= op1_address + 4'h1;
	end  
end

initial
begin
	rst = 1'b1; op1_address = 16'h0000; 
#10	rst = 1'b0; 
	
/******************************* READ DATA FROM REG *******************************/
#150 write_enable=2'b00; 


/******************************* Write Data to REG* ****************************/
	rst = 1'b1; op1_address = 16'h0000;
#10 	rst = 1'b0;
$display("Write register1");
#10 write_enable=2'b01; write_address1=4'ha; write_data1=16'hffff;

#150 write_enable=2'b00;

/******************************* Write Data to REG* ****************************/
	rst = 1'b1; op1_address = 16'h0000;
#10 	rst = 1'b0;
$display("Write register 1 and 2");
#10 write_enable=2'b11; write_address1=4'hb; write_address2= 4'h0; write_data1=16'hffff; write_data2=16'habcd;

#150 write_enable=2'b00;
	
#10 $finish;
end 
endmodule 
