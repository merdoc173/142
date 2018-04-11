
`include "SignExtend.v"

module SignExtend_fixture;

reg[3 : 0] in;
wire[15 : 0] out;

SignExtend se(.IN(in), .OUT(out));

initial $vcdpluson;

initial $monitor("in %h, out %h", in, out);

initial
begin
	in=4'h0; 
#10 	in=4'hf;
#10	in=4'h6;
#10	in=4'h9;
end 

endmodule 
