module EightToOneMux 
#(parameter SIZE = 16)
( 
input[2 : 0] SEL, 
input [ SIZE - 1 : 0 ] A, B, C, D, E, F, G, H,
output reg [ SIZE -1 : 0 ] OUT
);

always@(*)
begin 
	case(SEL)
		3'b000 : OUT = A;
		3'b001 : OUT = B;
		3'b010 : OUT = C;
		3'b011 : OUT = D;
		3'b100 : OUT = E;
		3'b101 : OUT = F;
		3'b110 : OUT = G;
		3'b111 : OUT = H;
	endcase
	//$display("Eight To One Mux Address %h", OUT);
end 
endmodule
