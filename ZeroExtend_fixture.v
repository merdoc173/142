`include "ZeroExtend.v"

module ZeroExtend_fixture;

reg [3:0] in;
wire [15:0] out;

initial $vcdpluson;

ZeroExtend ze(.IN(in), .OUT(out));

initial $monitor("IN %h OUT %h", in ,out);

initial 
begin
	in = 4'b0000;
#10 	in = 4'b0001;
#10	in = 4'b1111;
#10	$finish;



end 
endmodule
