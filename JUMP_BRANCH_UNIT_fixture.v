`include "JUMP_BRANCH_UNIT.v"

module JUMP_BRANCH_UNIT_fixure;
reg [3:0] op_code;
reg zero, sign;
wire jbf;

JUMP_BRANCH_UNIT jbu(
.OP_CODE(op_code),
.ZERO(zero),
.SIGN(sign),
.JUMP_BRANCH_FLAG(jbf)
);

initial $vcdpluson;

initial $monitor("op_code %b, zero %b, sign %b, jbf %b",op_code, zero, sign, jbf);

initial 
begin

	op_code=4'b0000; zero=1'b0; sign=1'b0;

#10 	op_code=4'b0100; zero=1'b0; sign=1'b0;
#10 	op_code=4'b0100; zero=1'b0; sign=1'b1;
#10 	op_code=4'b0100; zero=1'b1; sign=1'b0;

#10 	op_code=4'b0101; zero=1'b0; sign=1'b0;
#10 	op_code=4'b0101; zero=1'b0; sign=1'b1;
#10 	op_code=4'b0101; zero=1'b1; sign=1'b0;

#10 	op_code=4'b0110; zero=1'b0; sign=1'b0;
#10 	op_code=4'b0110; zero=1'b0; sign=1'b1;
#10 	op_code=4'b0110; zero=1'b1; sign=1'b0;

#10 	op_code=4'b1100; zero=1'b0; sign=1'b0;
#10 	op_code=4'b1100; zero=1'b0; sign=1'b1;
#10 	op_code=4'b1100; zero=1'b1; sign=1'b0;

#10	$finish;

end 
endmodule

