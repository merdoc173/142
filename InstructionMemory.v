module InstructionMemory 
#(parameter WIDTH = 16, HEIGHT = 16)
(input CLK, RST, WRITE_ENABLE, READ_ENABLE, input [HEIGHT - 1 : 0] ADDRESS, input [WIDTH - 1 : 0] DATA_IN, output reg [WIDTH - 1 : 0] DATA_OUT);


reg [WIDTH / 2 - 1 : 0] mem [ 100 : 0];

integer i = 0;

/* Writing data to instruction memory */
/*************************************/
// This memory is written in little endian 
// therefore, order is 
//       even * i     operand 1 operand 2
//       odd  * i     instruction 
/************************************/


always@(posedge CLK, negedge RST)
if(RST)
	for( i =0; i < 100 ; i = i + 1 )
		case(i)
			0:mem[i]<=8'h2f;
			1:mem[i]<=8'h01;
			2:mem[i]<=8'h2e;
			3:mem[i]<=8'h01;
			4:mem[i]<=8'h4C;
			5:mem[i]<=8'h03;
			6:mem[i]<=8'h2d;
			7:mem[i]<=8'h03;
			8:mem[i]<=8'h61;
			9:mem[i]<=8'h05;
			10:mem[i]<=8'h52;
			11:mem[i]<=8'h01;
			12:mem[i]<=8'h0e;
			13:mem[i]<=8'h00;
			14:mem[i]<=8'h3A;
			15:mem[i]<=8'h04;
			16:mem[i]<=8'h2b;
			17:mem[i]<=8'h04;
			18:mem[i]<=8'h38;
			19:mem[i]<=8'h06;
			20:mem[i]<=8'h29;
			21:mem[i]<=8'h06;
			22:mem[i]<=8'h04;
			23:mem[i]<=8'h67;
			24:mem[i]<=8'h1f;
			25:mem[i]<=8'h0b;
			26:mem[i]<=8'h05;
			27:mem[i]<=8'h47;
			28:mem[i]<=8'h2f;
			29:mem[i]<=8'h0b;
			30:mem[i]<=8'h02;
			31:mem[i]<=8'h57;
			32:mem[i]<=8'h1f;
			33:mem[i]<=8'h02;
			34:mem[i]<=8'h1f;
			35:mem[i]<=8'h02;
			36:mem[i]<=8'h90;
			37:mem[i]<=8'h88;
			38:mem[i]<=8'h8f;
			39:mem[i]<=8'h08;
			40:mem[i]<=8'h92;
			41:mem[i]<=8'hb8;
			42:mem[i]<=8'h92;
			43:mem[i]<=8'h8a;
			44:mem[i]<=8'hcf;
			45:mem[i]<=8'h0c;
			46:mem[i]<=8'hdE;
			47:mem[i]<=8'h0D;
			48:mem[i]<=8'hdf;
			49:mem[i]<=8'h0c;
			50:mem[i]<=8'hCF;
			51:mem[i]<=8'hEB;
			
			default: mem[i]<=8'h00;
		endcase
	
	else if(WRITE_ENABLE)
	begin
		mem[ADDRESS]<=DATA_IN;
	end 

/***************************************************
 *
 *
 *			READ
 *
 *
 * ************************************************/

always@(*)
begin
	if(READ_ENABLE)
	begin
		DATA_OUT = { mem[ADDRESS + 16'h01 ],  mem[ADDRESS]};
	end 
end	
endmodule 
