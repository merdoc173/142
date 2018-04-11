module FourToOneMux 
#(parameter SIZE = 16)
( 
input[1 : 0] SEL, 
input [ SIZE - 1 : 0 ] A, B, C, D, 
output reg [ SIZE -1 : 0 ] OUT
);

always@(*)
begin 
	case(SEL)
		2'b00 : OUT = A;
		2'b01 : OUT = B;
		2'b10 : OUT = C;
		2'b11 : OUT = D; 
	endcase
end 
endmodule
