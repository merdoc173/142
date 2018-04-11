module ZeroExtend#(parameter INSIZE = 4, OUTSIZE = 16)
	(input [INSIZE - 1:0] IN, output reg[OUTSIZE - 1:0] OUT);

always@(*)
	OUT = {IN};

endmodule
