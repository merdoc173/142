module TwoToOneMux
#(parameter SIZE = 16)
( 	
input SEL,
input [ SIZE - 1 : 0 ] A, B, 
output reg [ SIZE -1 : 0 ] OUT)
;

always@(*)
begin 
	case(SEL)
		1'b0 : OUT = A;
		1'b1 : OUT = B;
	endcase
end 
endmodule
