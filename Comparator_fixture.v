`include "Comparator.v"

module Comparator_fixture;

reg [15 : 0] op1, op2;
wire zero, sign;

Comparator com(.OP1(op1), .OP2(op2), .ZERO(zero), .SIGN(sign));

initial $vcdpluson;

initial $monitor("op1 %h, op2 %h, zero %h, sign %h", op1, op2, zero, sign);

initial 
begin 
	op1 = 16'h0000; op2 = 16'h0000;
#10 	op1 = 16'h0001; op2 = 16'h0000;
#10	op1 = 16'h0000; op2 = 16'h0001;
#10 	$finish;


end 

endmodule
