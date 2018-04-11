`include "FourToOneMux.v"


module FourToOneMux_fixture;

reg[1:0] sel;
reg [15:0]
a = 16'h0001, 
b = 16'h0002, 
c = 16'h0003, 
d = 16'h0004;
wire [15:0] out;

FourToOneMux ftom(.SEL(sel), .A(a), .B(b), .C(c), .D(d), .OUT(out));

initial $vcdpluson;

initial $monitor("sel %b a %h b %h c %h d %h out %h", sel, a, b, c, d, out);

initial 
begin 
	sel = 2'b00;
#10 	sel = 2'b01;
#10 	sel = 2'b10;
#10 	sel = 2'b11;
#10 	$finish;
end 
endmodule 
