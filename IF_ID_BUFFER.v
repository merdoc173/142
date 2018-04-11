module IF_ID_BUFFER 
#(parameter WIDTH=16,HEIGHT=2)
(
input CLK, RST, READ_ENABLE, WRITE_ENABLE,
input [WIDTH-1:0] PROGRAM_COUNTER, INSTRUCTION, 
output reg [WIDTH-1:0] PROGRAM_COUNTER_OUT, INSTRUCTION_OUT
);
reg [WIDTH-1:0] mem [HEIGHT-1:0];

integer i = 0;


/* Writing data to mem */
always@(posedge CLK, negedge RST)
	if(RST)
	begin
		for( i =0 ; i < HEIGHT; i = i + 1 )
			mem[i]<=16'h0000;
	end 
	else if(WRITE_ENABLE)
	begin 
		mem[0]<=PROGRAM_COUNTER;
		mem[1]<=INSTRUCTION;
	end 
/* Reading data from mem */
always@(*)
	if(READ_ENABLE)
		begin
			PROGRAM_COUNTER_OUT = mem[0];
			INSTRUCTION_OUT = mem[1];
		end 

endmodule 
