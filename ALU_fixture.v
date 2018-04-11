`include "ALU.v"

module ALU_fixture;

reg [3:0] func_code;
reg [15 : 0] op1, op2;
wire overflow, invalid;
wire[15:0] value0, value1;
 

ALU alu(.FUNC_CODE(func_code), .OP1(op1), .OP2(op2), .OVERFLOW(overflow), .INVALID(invalid), .VALUE0(value0), .VALUE1(value1));

initial $vcdpluson;


initial $monitor("func_code %b, op1 %h, op2 %h, overflow %b invalid %b, value1 value0 %h %h",func_code, op1, op2, overflow, invalid, value1, value0);


initial 
begin


$display("SIGNED ADDITION");
	func_code = 4'b1111; op1 = 16'h0000; op2 = 16'h0000; 
#10	func_code = 4'b1111; op1 = 16'h0000; op2 = 16'h0001; 
#10	func_code = 4'b1111; op1 = 16'h0001; op2 = 16'h0000; 
#10	func_code = 4'b1111; op1 = 16'h0001; op2 = 16'h0001; 
#10	func_code = 4'b1111; op1 = 16'h7fff; op2 = 16'h0001; 
#10	func_code = 4'b1111; op1 = 16'h7fff; op2 = 16'h7fff; 
#10     func_code = 4'b1111; op1 = 16'h0f00; op2 = 16'h0050;


#10 $display("SIGNED SUBTRACTION");
	func_code = 4'b1110; op1 = 16'h0000; op2 = 16'h0000; 
#10	func_code = 4'b1110; op1 = 16'h0001; op2 = 16'h0000; 
#10	func_code = 4'b1110; op1 = 16'h0000; op2 = 16'h0001; 
#10	func_code = 4'b1110; op1 = 16'h0000; op2 = 16'h0000; 
#10	func_code = 4'b1110; op1 = 16'h0000; op2 = 16'h0000; 



#10 $display("SIGNED MULT");
#10     func_code = 4'b0001; op1 = 16'h0000; op2 = 16'h0000;
#10     func_code = 4'b0001; op1 = 16'h0000; op2 = 16'h0001;
#10     func_code= 4'b0001; op1 = 16'hffff; op2 = 16'h0001;
#10      func_code = 4'b0001; op1 = 16'hffff; op2 = 16'h0002;
#10     func_code = 4'b0001; op1 = 16'hffff; op2 = 16'hffff;

#10 $display("SIGNED DIV");
#10      func_code= 4'b0010; op1 = 16'h0000; op2 = 16'h0000;
#10     func_code = 4'b0010; op1 = 16'h0000; op2 = 16'h0001;
#10     func_code = 4'b0010; op1 = 16'hffff; op2 = 16'h0001;
#10     func_code = 4'b0010; op1 = 16'hffff; op2 = 16'h0002;
#10     func_code = 4'b0010; op1 = 16'hffff; op2 = 16'h0003;
#10      func_code= 4'b0010; op1 = 16'hffff; op2 = 16'hffff;

#10 $display("Rotate Left");
#10     func_code = 4'b1000; op1 = 16'h0001; op2 = 16'h0000;
#10     func_code= 4'b1000; op1 = 16'h0001; op2 = 16'h0001;
#10      func_code= 4'b1000; op1 = 16'h0010; op2 = 16'h0002;
#10      func_code= 4'b1000; op1 = 16'h0001; op2 = 16'hffff;
#10      func_code= 4'b1000; op1 = 16'h0002; op2 = 16'hffff;

#10 $display("Rotate Right");
#10     func_code = 4'b1001; op1 = 16'h1000; op2 = 16'h0000;
#10     func_code = 4'b1001; op1 = 16'h1000; op2 = 16'h0001;
#10      func_code= 4'b1001; op1 = 16'h1000; op2 = 16'h0002;
#10      func_code= 4'b1001; op1 = 16'h1000; op2 = 16'hfeff;

#10 $display("Logical Shift Right");
#10     func_code = 4'b1010; op1 = 16'h1000; op2 = 16'h0000;
#10     func_code = 4'b1010; op1 = 16'h1000; op2 = 16'h0001;
#10      func_code= 4'b1010; op1 = 16'h1000; op2 = 16'h0002;
#10      func_code= 4'b1010; op1 = 16'h1000; op2 = 16'hffff;

#10 $display("Logical Shift Left");
#10      func_code = 4'b1011; op1 = 16'h0001; op2 = 16'h0000;
#10       func_code= 4'b1011; op1 = 16'h0001; op2 = 16'h0001;
#10       func_code= 4'b1011; op1 = 16'h0001; op2 = 16'h0002;
#10       func_code= 4'b1011; op1 = 16'h0001; op2 = 16'hffff;

#10 $finish;

end 
endmodule
