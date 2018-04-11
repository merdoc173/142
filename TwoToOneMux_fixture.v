`include "TwoToOneMux.v"
module TwoToOneMux_fixture;

parameter SIZE = 16;

reg SEL;
reg [ SIZE - 1 : 0 ] A, B; 
wire [ SIZE -1 : 0 ] OUT;

TwoToOneMux ttom(.SEL(SEL), .A(A), .B(B), .OUT(OUT));

initial $vcdpluson;

initial $monitor("SEL %h, A %h, B %h, OUT %h", SEL, A, B, OUT);


initial 
begin
	A = 16'h0001;
	B = 16'h0002;
	SEL = 1'b0;
#10 SEL = 1'b1;
#10 $finish;

end 

endmodule
