module ControlUnit
#(parameter OPSIZE = 4, BUFF = 16)
(
input[OPSIZE -1 : 0] OP_CODE, FUNC_CODE, 
/********************************************************
 *
 *
 *   0000, WB, MEM, EXE
 *   WB Signal : Not Used, alu_mem_mux_sel, Write_Enable2, Write_Enable1
 *   MEM Signal : Not Used, Not Used, MEM_READ, MEM_WRITE
 *   EXE Signal : operation code for non alu operation 
 *                otherwise 0
 *
 * ******************************************************/
output reg [BUFF - 1 : 0] WME_SIGNAL, 
/********************************************************
 *
 *
 *   Imm, Extension R0, Op1, Op2, Offset
 *
 *
 * ******************************************************/
output reg[5:0]  ID_MUX_SEL,
output reg WRONG_OP_CODE
);

always@(*)
begin
	WRONG_OP_CODE = 1'b0;
	case(OP_CODE)
	4'b0000:
	begin
		case(FUNC_CODE)
			
			4'b1111:
			begin
				$display("\n\n------------------------------ Instruction: Signed Addition------------------------------");
				ID_MUX_SEL = 6'b000000;	
				WME_SIGNAL = 16'h0100; 
			end 

			4'b1110:
			begin
				$display("\n\n------------------------------ Instruction: Signed Subtraction------------------------------");
				ID_MUX_SEL = 6'b000000;	
				WME_SIGNAL = 16'h0100; 
			end 
			
			4'b1101:
			begin
				$display("\n\n------------------------------ Instruction: Bitwise and");
				ID_MUX_SEL = 6'b000000;	
				WME_SIGNAL = 16'h0100; 
			end 

			4'b1100:
			begin
				$display("\n\n------------------------------ Instruction: Bitwise or");
				ID_MUX_SEL = 6'b000000;	
				WME_SIGNAL = 16'h0100; 
			end 

			4'b0001:
			begin
				$display("\n\n------------------------------ Instruction: Signed Multiplication");
				ID_MUX_SEL = 6'b000000;
				WME_SIGNAL = 16'h0300; 
			end

			4'b0010:
			begin
				$display("\n\n------------------------------ Instruction: Signed Division");
				ID_MUX_SEL = 6'b000000;
				WME_SIGNAL = 16'h0300; 
			end 

			4'b1010:
			begin
				$display("\n\n------------------------------ Instruction: logical Shift Left");
				ID_MUX_SEL = 6'b100010;
				WME_SIGNAL = 16'h0100; 
			end 
			4'b1011:
			begin
				$display("\n\n------------------------------ Instruction: logical Shift Right");
				ID_MUX_SEL = 6'b110010;
				WME_SIGNAL = 16'h0100; 
			end 

			4'b1000:
			begin
				$display("\n\n------------------------------ Instruction: Rotate Left");
				ID_MUX_SEL = 6'b100010;
				WME_SIGNAL = 16'h0100; 
			end 

			4'b1001:
			begin
				$display("\n\n------------------------------ Instruction: Rotate Right");			
				ID_MUX_SEL = 6'b100010;
				WME_SIGNAL = 16'h0100; 
			end 
			
			default:
			begin 
				$display("\n\n------------------------------ Instruction: Wrong Operation");	
				WRONG_OP_CODE = 1'b1;
			end
		endcase 
	end 

	4'b1000:
	begin
		$display("\n\n------------------------------ Instruction: load");
		ID_MUX_SEL = 6'b010100;	
		WME_SIGNAL = 16'h052f; 
	end 

	4'b1011:
	begin	
		$display("\n\n------------------------------ Instruction: store");
		ID_MUX_SEL = 6'b010100;	
		WME_SIGNAL = 16'h001f; 
	end 

	4'b0100:
	begin
		$display("\n\n------------------------------ Instruction: blt");
		ID_MUX_SEL = 6'b001000;	
		WME_SIGNAL = 16'h0000; 
	end 

	4'b0101:
	begin
		$display("\n\n------------------------------ Instruction: bgt");
		ID_MUX_SEL = 6'b001000;	
		WME_SIGNAL = 16'h0000; 
	end 

	4'b0110:
	begin
		$display("\n\n------------------------------ Instruction: beq");
		ID_MUX_SEL = 6'b001000;	
		WME_SIGNAL = 16'h0000; 
	end 

	4'b1100:
	begin
		$display("\n\n------------------------------ Instruction: jump");
		ID_MUX_SEL = 6'b001001;	
		WME_SIGNAL = 16'h0000; 
	end 

	4'b1111:	
	begin
		$display("\n\n------------------------------ Instruction: halt");
		ID_MUX_SEL = 6'b000000;	
		WME_SIGNAL = 16'h0000; 
	end 
	
	default:
	begin
		$display("\n\n------------------------------ Invalid Operation");
		WRONG_OP_CODE = 1'b1;
	end
	endcase
	$display("*******************************************************************************************\n\n");
end   
endmodule
