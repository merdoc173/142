`include "ProgramCounter.v"
`include "InstructionMemory.v"
`include "EightToOneMux.v"
`include "TwoToOneMux.v"
`include "IF_ID_BUFFER.v"
`include "ControlUnit.v"
`include "SignExtend.v"
`include "ZeroExtend.v"
`include "RegisterFile.v";
`include "Comparator.v"
`include "ID_EX_BUFFER.v"
`include "FourToOneMux.v"
`include "ALUControl.v"
`include "ALU.v"
`include "EX_MEM_BUFFER.v"
`include "DataMemory.v"
`include "MEM_WB_BUFFER.v"
`include "Forward.v"
`include "JUMP_BRANCH_UNIT.v"
`include "Hazard.v"






module cpu(input clk, rst);
/****************************************************************************************
 *
 *
 *				Wire Reg Declaration 
 *
 *
 * **************************************************************************************/


//Program Counter 
wire[15 : 0] pc_address;
reg [15 : 0] pc_new_address;

//InstructionMemory
wire[15 : 0] im_instruction;

//Address_MUX 
wire[15 : 0] address_mux_out;

//Halt_Mux
wire[15 : 0] halt_mux_out;

//IF_ID_BUFFER
wire[15 : 0] if_id_pc, if_id_instruction;

//ID MUX's Signal 
wire [3 : 0] r0_mux_out, imm_mux_out;
wire [15 : 0] ext_mux_out, op1_mux_out, op2_mux_out, offset_mux_out, wme_mux_out;


//Control Unit 
wire [15 : 0] control_wme_signal;
wire [5 : 0] control_id_mux_sel;
wire wrong_op_code;  

//Register File
wire [15 : 0] rf_op1_out, rf_op2_out;

//Comparator 
wire compare_zero, compare_sign;

//Jump Branch Flag
wire jump_branch_flag;

//Imm Extension
wire [15 : 0] imm_sign_ext_out, imm_zero_ext_out;

//Offset Extension
wire [15 : 0] offset8_sign_ext_out, offset12_sign_ext_out;

//Shift 
reg [15 : 0] shift_offset8_out, shift_offset12_out; 

//Adder offset
reg [15 : 0] new_address_offset_adder_out;

//register file 

//ID_EX
wire [15:0] id_ex_write_back, id_ex_memory, id_ex_execution, id_ex_program_counter, id_ex_register_val1, id_ex_op1_address, id_ex_op2_address, id_ex_value1, id_ex_value2, id_ex_func_code;

//Execution
//op1_data_mux
wire [15:0] op1_data_mux_out, op2_data_mux_out;


//alucontrol
wire [3:0] alu_control_func;


//ALU
wire alu_overflow, alu_invalid;
wire [15 : 0] alu_value0, alu_value1;


//EXE WB MEM mux 
wire [15 : 0] exe_wb_mux_out, exe_mem_mux_out;

//EX_MEM_BUFFER
wire [15 : 0] ex_mem_write_back, ex_mem_memory, ex_mem_register_val1, ex_mem_op1_address, ex_mem_result_upper, ex_mem_result_lower; 

//Memory
wire [15 : 0] dm_data;

//MEM_WB
wire [15 : 0] mem_wb_write_back, mem_wb_op1_address, mem_wb_result_upper, mem_wb_result_lower, mem_wb_dm_data;


//alu_mem_mux_out
wire [31 : 0] alu_mem_mux_out;

//forward
wire [1:0] forward_mux_sel1, forward_mux_sel2;


wire hazard_if_id_write,
 hazard_if_id_flash, 
 hazard_id_hazard_flash,
 hazard_ex_flash,
 hazard_pc_write;

//Test wire declaration 
wire pc_we_t = 1'b1;
wire[15 : 0] address_mux_test = 16'h0000;

wire[2:0] address_mux_sel_t = 3'b000;

wire halt_mux_sel = 1'b0;

//wire hazard_if_id_write_t = 1'b1;

wire wme_mux_sel_test = 1'b0;

wire[1:0] op1_data_mux_sel_t = 2'b00, op2_data_mux_sel_t = 2'b00;
wire[15:0] 
op_data_mux_b_t = 16'h0000,
op_data_mux_c_t = 16'h0000,
op_data_mux_d_t = 16'h0000;


wire exe_wb_mux_sel_t = 1'b0, exe_mem_mux_sel_t = 1'b0;



/*****************************************************************************************
 *
 *
 *				         OUTPUT Difinition
 *
 *
 *****************************************************************************************/

always@(posedge clk)
begin
	$display("------------------------------ Fetch ---------------------------------------\n\n");
	$display(" address %h, next address %h Instruction %h \n\n", pc_address, pc_new_address, im_instruction);

	$display("eight to one mux select %b", {2'b00, jump_branch_flag});
	$display("eight to one mux address %h, ", address_mux_out);

	$display("------------------------------ Decode --------------------------------------\n\n");
	
	$display(" Program Counter %h", if_id_pc );
	
	$display(" Control Signal id_mux_sel %b, control_wme_signal %b, R0 %h, Imm %h\n\n", control_id_mux_sel, control_wme_signal, r0_mux_out, imm_mux_out);
	$display(" IMM_MUX %b ", imm_mux_out);
	$display(" ext_MUX %h ", ext_mux_out);
	$display(" r0_MUX %b ", r0_mux_out);
	$display(" op1_MUX %h ", op1_mux_out);
	$display(" op2_MUX %h ", op2_mux_out);
	$display(" Offset_MUX %h ", offset_mux_out);
	$display(" WME MUX %h", wme_mux_out);
	
	$display("\n");
	$display(" Register File Output Value");
	$display(" Write Enable %b",mem_wb_write_back[1:0]);
	$display(" wa2, wa1 %b, %b", 4'b0000, mem_wb_op1_address[3:0]);
	$display(" wd2, wd1 %h, %h", alu_mem_mux_out[31:16], alu_mem_mux_out[15:0]);
	$display(" op1 %h, op2 %h ", rf_op1_out, rf_op2_out);
	
	$display("\n");
	$display(" new address for jump branch signals, %h", new_address_offset_adder_out);

	$display(" Comparator ");
	$display(" Zero %h Sign %h", compare_zero, compare_sign);	
	$display(" JumpBranchFlag %b ", jump_branch_flag);


	$display(" Hazard Unit");
	$display(" if_id_write %b", hazard_if_id_write);
	$display(" if_id_flash %b", hazard_if_id_flash);
	$display(" id_hazard_flash %b", hazard_id_hazard_flash);
	$display(" hazard_ex_flash %b", hazard_ex_flash);
	$display(" hazard_pc_write %b", hazard_pc_write);


	$display("------------------------------ Execute --------------------------------------\n\n");
	
	$display(" ID/EX BUFFER");
	$display(" Write Back %h", id_ex_write_back);
	$display(" Memory %h", id_ex_memory);
	$display(" Execution %h", id_ex_execution);
	$display(" Program_Counter %h", id_ex_program_counter);
	$display(" Register Value1 %h", id_ex_register_val1);
	$display(" Op1_address_out %h", id_ex_op1_address);
	$display(" Op2_address_out %h", id_ex_op2_address);
	$display(" value1 %h", id_ex_value1);
	$display(" value2 %h", id_ex_value2);
	$display(" func code %h", id_ex_func_code);
	$display("\n");
		
	$display(" Forwarding ");
	$display(" op1 %h", id_ex_op1_address[3:0]);
	$display(" op2 %h", id_ex_op2_address[3:0]);
	$display(" exe mem op1 %h", ex_mem_op1_address[3:0]);
	$display(" mem wb op1 %h", mem_wb_op1_address[3:0]);
	$display(" ex mem op1 %h",ex_mem_result_lower );
	$display(" ex mem wb %b", ex_mem_write_back[0] );
	$display(" mem wb op1 %h", mem_wb_result_lower );	
	$display(" mem wb wb %b", mem_wb_write_back[0]);
	$display(" op1 select %b", forward_mux_sel1);
	$display(" op2 select %b", forward_mux_sel2);

	$display("\n");	

	$display(" op_mux_out ");
	$display(" op1_mux_out %h", id_ex_value1);
	$display(" op2_mux_out %h", id_ex_value2);
	
	$display("\n");
	$display(" ALUControl");
	$display(" Function Code %b", alu_control_func);
	
	$display(" ALU");
	$display(" alu_control_func %h op1 %h op2 %h value 1 value 0 %h %h overflow %b invalid %b", alu_control_func, op1_data_mux_out, op2_data_mux_out, alu_value1, alu_value0, alu_overflow, alu_invalid);
	$display(" Function Code %b", alu_control_func);
	$display(" op1 %h, op2 %h", op1_data_mux_out, op2_data_mux_out);
	$display(" value1 value 0 %h, %h", alu_value1, alu_value0);
	$display(" overflow %b, invalid %b", alu_overflow, alu_invalid);
	

	
	$display("\n");
	$display("------------------------------ Memory  --------------------------------------\n\n");
	
	$display(" EX/MEM BUFFER");
	$display(" WB %b", ex_mem_write_back);
	$display(" MEM %b", ex_mem_memory);
	$display(" register value1 %h ", ex_mem_register_val1);
	$display(" op1_address %h", ex_mem_op1_address);
	$display(" result upper %h", ex_mem_result_upper);
	$display(" result lower %h", ex_mem_result_lower);

	
	$display("\n");
	$display("DataMemory");

	$display(" Memory Write %b", ex_mem_memory[0]);
	$display(" Memory Read %b", ex_mem_memory[1]);
	$display(" Address %h", ex_mem_result_lower);
	$display(" data in %h", id_ex_register_val1);
	$display(" data out %h", dm_data);

	$display("------------------------------ Write Back  --------------------------------------\n\n");
	
	$display(" MEM/EXE BUFFER");
	$display(" WB %b", mem_wb_write_back);
	$display(" op1_address %h", mem_wb_op1_address);
	$display(" result upper %h", mem_wb_result_upper);
	$display(" result lower %h", mem_wb_result_lower);
	$display(" mem_data_out ", mem_wb_dm_data);
	

	$display(" alu_mem_mux_out %h", alu_mem_mux_out);
	
end 




/****************************************************************************************
 *
 *
 *				Module Instranciation 
 *
 *
 * **************************************************************************************/


/***************************************************************************************
 *
 *
 * 				Instruction Fetch Stage 
 *
 *
 * ************************************************************************************/

//Program Counter
ProgramCounter pc(.CLK(clk), .RST(rst), .WRITE_ENABLE(hazard_pc_write), .READ_ENABLE(1'b1), .ADDRESS(1'b0), .DATA_IN(halt_mux_out), .DATA_OUT(pc_address));

//Instruction Memory
InstructionMemory im(.CLK(clk), .RST(rst), .WRITE_ENABLE(1'b0), .READ_ENABLE(1'b1), .ADDRESS(pc_address), .DATA_IN(16'h0000), .DATA_OUT(im_instruction));

//Address_Mux
//address_mux_sel_t
//EightToOneMux addres_mux(.SEL(address_mux_sel_t), 
EightToOneMux addres_mux(.SEL({2'b00, jump_branch_flag}), 
.A(pc_new_address), 
.B(new_address_offset_adder_out), 
.C(address_mux_test), 
.D(address_mux_test), 
.E(address_mux_test), 
.F(address_mux_test), 
.G(address_mux_test), 
.H(address_mux_test), 
.OUT(address_mux_out));

//TwoToOneMux
TwoToOneMux halt_mux(.SEL(halt_mux_sel), .A(address_mux_out), .B(pc_address), .OUT(halt_mux_out));

//Address Adder
always@(*)
begin	
	begin
		pc_new_address = pc_address + 16'h0002;
	end 
end 

//IF_ID_BUFFER
IF_ID_BUFFER if_id(
.CLK(clk),
.RST(rst || hazard_if_id_flash),
.READ_ENABLE(1'b1),
.WRITE_ENABLE(hazard_if_id_write),
.PROGRAM_COUNTER(pc_new_address),
.INSTRUCTION(im_instruction),
.PROGRAM_COUNTER_OUT(if_id_pc),
.INSTRUCTION_OUT(if_id_instruction)
);

/***************************************************************************************
 *
 *
 * 				Instruction Decode Stage 
 *
 *
 * ************************************************************************************/
ControlUnit control( 
.OP_CODE(if_id_instruction[15 : 12]),
.FUNC_CODE(if_id_instruction[3 : 0]), 
.WME_SIGNAL(control_wme_signal), 
.ID_MUX_SEL(control_id_mux_sel), 
.WRONG_OP_CODE(wrong_op_code)
);

JUMP_BRANCH_UNIT jump_branch_unit(
.OP_CODE(if_id_instruction[15 : 12]),
.ZERO(compare_zero),
.SIGN(compare_sign),
.JUMP_BRANCH_FLAG(jump_branch_flag)
);

Hazard hazard(
.IF_ID_OP1(if_id_instruction[11:8]),
.IF_ID_OP2(r0_mux_out),
.ID_EX_OP1(id_ex_op1_address[3:0]),
.MEM_WRITE(id_ex_memory[1]),
.OVER_FLOW(alu_overflow),
.BRANCH_JUMP_FLAG(jump_branch_flag),
.IF_ID_WRITE(hazard_if_id_write),
.IF_ID_FLASH(hazard_if_id_flash),
.ID_HAZARD_FLASH(hazard_id_hazard_flash),
.EX_FLASH(hazard_ex_flash),
.PC_WRITE(hazard_pc_write)
);


TwoToOneMux #(.SIZE(4))r0_mux(.SEL(control_id_mux_sel[3]), .A(if_id_instruction[7:4]), .B(4'h0), .OUT(r0_mux_out));


RegisterFile rf(
.CLK(clk), 
.RST(rst), 
.READ_ENABLE(1'b1), 
.WRITE_ENABLE(mem_wb_write_back[1 : 0]),
.OP1_ADDRESS(if_id_instruction[11 : 8]),
.OP2_ADDRESS(r0_mux_out),
.WRITE_ADDRESS1(mem_wb_op1_address[3:0]),
.WRITE_ADDRESS2(4'b0000), 
.WRITE_DATA1(alu_mem_mux_out[15 : 0]),
.WRITE_DATA2(alu_mem_mux_out[31 : 16]), 
.OP1_OUT(rf_op1_out),
.OP2_OUT(rf_op2_out)
);

Comparator compare(.OP1(rf_op1_out), .OP2(rf_op2_out), .ZERO(compare_zero), .SIGN(compare_sign));


TwoToOneMux #(.SIZE(16)) op1_mux ( .SEL(control_id_mux_sel[2]), .A(rf_op1_out), .B(ext_mux_out), .OUT(op1_mux_out)); 
TwoToOneMux #(.SIZE(16)) op2_mux ( .SEL(control_id_mux_sel[1]), .A(rf_op2_out), .B(ext_mux_out), .OUT(op2_mux_out)); 



TwoToOneMux #(.SIZE(4))imm_mux(.SEL(control_id_mux_sel[5]), .A(if_id_instruction[3:0]), .B(if_id_instruction[7:4]), .OUT(imm_mux_out));


SignExtend imm_sign_ext(.IN(imm_mux_out), .OUT(imm_sign_ext_out));
ZeroExtend imm_zero_ext(.IN(imm_mux_out), .OUT(imm_zero_ext_out));

TwoToOneMux #(.SIZE(16))ext_mux(.SEL(control_id_mux_sel[4]), .A(imm_zero_ext_out), .B(imm_sign_ext_out), .OUT(ext_mux_out));



SignExtend #(.INSIZE(8), .OUTSIZE(16))offset8_sign_ext(.IN(if_id_instruction[7 : 0]), .OUT(offset8_sign_ext_out));
SignExtend #(.INSIZE(12), .OUTSIZE(16))offset12_sign_ext(.IN(if_id_instruction[11 : 0]), .OUT(offset12_sign_ext_out));

//Shift
always@(*)
begin
	shift_offset8_out = offset8_sign_ext_out << 1;
end 

always@(*)
begin
	shift_offset12_out = offset12_sign_ext_out << 1;
end
 
TwoToOneMux #(.SIZE(16))offset_mux(.SEL(control_id_mux_sel[0]), .A(shift_offset8_out), .B(shift_offset12_out), .OUT(offset_mux_out));


//ADDER for new address
always@(*)
begin 
	new_address_offset_adder_out = if_id_pc + offset_mux_out;
end 

//wme_mux_sel_test
TwoToOneMux #(.SIZE(16))wme_mux(.SEL(hazard_id_hazard_flash), .A(control_wme_signal), .B(16'h0000), .OUT(wme_mux_out));

//ID_EX_BUFFER
ID_EX_BUFFER id_ex(
.CLK(clk),
.RST(1'b0),
.READ_ENABLE(1'b1),
.WRITE_ENABLE(1'b1),

.WRITE_BACK({12'h000, wme_mux_out[11:8]}),
.MEMORY({12'h000, wme_mux_out[7:4]}),
.EXECUTION({12'h000, wme_mux_out[3:0]}),
.PROGRAM_COUNTER(pc_new_address),
.REGISTER_VAL1(rf_op1_out),
.OP1_ADDRESS({12'h000, if_id_instruction[11:8]}),
.OP2_ADDRESS({12'h000, r0_mux_out}),
.VALUE1(op1_mux_out),
.VALUE2(op2_mux_out),
.FUNC_CODE({12'h000, if_id_instruction[3:0]}),

.WRITE_BACK_OUT(id_ex_write_back),
.MEMORY_OUT(id_ex_memory),
.EXECUTION_OUT(id_ex_execution),
.PROGRAM_COUNTER_OUT(id_ex_program_counter),
.REGISTER_VAL1_OUT(id_ex_register_val1),
.OP1_ADDRESS_OUT(id_ex_op1_address),
.OP2_ADDRESS_OUT(id_ex_op2_address),
.VALUE1_OUT(id_ex_value1),
.VALUE2_OUT(id_ex_value2),
.FUNC_CODE_OUT(id_ex_func_code)
);


/***************************************************************************************
 *
 *
 * 				Execution Stage 
 *
 *
 * ************************************************************************************/
FourToOneMux op1_data_mux(.SEL(forward_mux_sel1), .A(id_ex_value1), .B(ex_mem_result_lower), .C(alu_mem_mux_out[15 : 0]), .D(op_data_mux_d_t), .OUT(op1_data_mux_out));
FourToOneMux op2_data_mux(.SEL(forward_mux_sel2), .A(id_ex_value2), .B(ex_mem_result_lower), .C(alu_mem_mux_out[15 : 0]), .D(op_data_mux_d_t), .OUT(op2_data_mux_out));


ALUControl alu_control(.FUNC_CODE(id_ex_func_code[3:0]), .EXECUTION(id_ex_execution[3:0]), .ALU_FUNC_CODE(alu_control_func));


ALU alu(
.FUNC_CODE(alu_control_func),
.OP1(op1_data_mux_out),
.OP2(op2_data_mux_out),
.OVERFLOW(alu_overflow),
.INVALID(alu_invalid),
.VALUE0(alu_value0),
.VALUE1(alu_value1)
);



TwoToOneMux exe_wb_mux(.SEL(exe_wb_mux_sel_t), .A(id_ex_write_back), .B(16'h0000), .OUT(exe_wb_mux_out));
TwoToOneMux exe_mem_mux(.SEL(exe_mem_mux_sel_t), .A(id_ex_memory), .B(16'h0000), .OUT(exe_mem_mux_out));




EX_MEM_BUFFER ex_mem(
.CLK(clk),
.RST(1'b0),
.READ_ENABLE(1'b1),
.WRITE_ENABLE(1'b1),

.WRITE_BACK(exe_wb_mux_out),
.MEMORY(exe_mem_mux_out),
.REGISTER_VAL1(id_ex_register_val1),
.OP1_ADDRESS(id_ex_op1_address),
.ALU_RESULT_UPPER(alu_value1),
.ALU_RESULT_LOWER(alu_value0),

.WRITE_BACK_OUT(ex_mem_write_back),
.MEMORY_OUT(ex_mem_memory),
.REGISTER_VAL1_OUT(ex_mem_register_val1),
.OP1_ADDRESS_OUT(ex_mem_op1_address),
.ALU_RESULT_UPPER_OUT(ex_mem_result_upper),
.ALU_RESULT_LOWER_OUT(ex_mem_result_lower)
);
/***************************************************************************************
 *
 *
 * 				Data Memory 
 *
 *
 * ************************************************************************************/


DataMemory dm(
.CLK(clk),
.RST(rst), 
.WRITE_ENABLE(ex_mem_memory[0]),
.READ_ENABLE(ex_mem_memory[1]),
.ADDRESS(ex_mem_result_lower),
.DATA_IN(id_ex_register_val1),
.DATA_OUT(dm_data)
);

MEM_WB_BUFFER mem_wb(
.CLK(clk),
.RST(rst),
.READ_ENABLE(1'b1),
.WRITE_ENABLE(1'b1),

.WRITE_BACK(ex_mem_write_back),
.OP1_ADDRESS(ex_mem_op1_address),
.ALU_RESULT_UPPER(ex_mem_result_upper),
.ALU_RESULT_LOWER(ex_mem_result_lower),
.MEM_DATA({dm_data[7:0], dm_data[15:8]}),


.WRITE_BACK_OUT(mem_wb_write_back),
.OP1_ADDRESS_OUT(mem_wb_op1_address),
.ALU_RESULT_UPPER_OUT(mem_wb_result_upper),
.ALU_RESULT_LOWER_OUT(mem_wb_result_lower),
.MEM_DATA_OUT(mem_wb_dm_data)

);

/***************************************************************************************
 *
 *
 * 				Write Back 
 *
 *
 * ************************************************************************************/


TwoToOneMux #(.SIZE(32))alu_mem_mux(.SEL(mem_wb_write_back[2]), .A({mem_wb_result_upper, mem_wb_result_lower}), .B({16'h0000, mem_wb_dm_data}), .OUT(alu_mem_mux_out));

Forward forward(
.OP1(id_ex_op1_address[3:0]),
.OP2(id_ex_op2_address[3:0]),
.EXE_MEM_OP1(ex_mem_op1_address[3:0]),
.MEM_WB_OP1(mem_wb_op1_address[3:0]),
.EXE_MEM_WB(ex_mem_write_back[0]),
.MEM_WB_WB(mem_wb_write_back[0]),
.FM1(forward_mux_sel1),
.FM2(forward_mux_sel2)
);


endmodule 
