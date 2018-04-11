`include "EightToOneMux.v"
module EightToOneMux_fixture;

parameter SIZE = 16;

reg [2 : 0] SEL;
reg [ SIZE - 1 : 0 ] A, B, C, D, E, F, G, H;
wire [ SIZE -1 : 0 ] OUT;

EightToOneMux etom(.SEL(SEL), .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .H(H), .OUT(OUT) );


initial $vcdpluson;

initial $monitor("SEL %h A %h B %h C %h D %h E %h F %h G %h H %h OUT %h", SEL, A, B, C, D, E, F, G, H, OUT );

initial 
begin

	A = 16'h0001;
	B = 16'h0002;
	C = 16'h0003;
	D = 16'h0004;
	E = 16'h0005;
	F = 16'h0006;
	G = 16'h0007;
	H = 16'h0008;
	SEL = 3'b000;

#10 SEL = 3'b000;
#10 SEL = 3'b001;
#10 SEL = 3'b010;
#10 SEL = 3'b011;
#10 SEL = 3'b100;
#10 SEL = 3'b101;
#10 SEL = 3'b110;
#10 SEL = 3'b111;
#10 $finish;
end 
endmodule
