`include "ControlUnit.v"


module ControlUnit_fixture;

reg [3:0] op_code, func_code;
wire [15 : 0] wme_signal;
wire [5 : 0] id_mux_sel;
wire wrong_op_code;

ControlUnit cu( .OP_CODE(op_code), .FUNC_CODE(func_code), .WME_SIGNAL(wme_signal), .ID_MUX_SEL(id_mux_sel), .WRONG_OP_CODE(wrong_op_code));

initial $vcdpluson;

initial $monitor("op_code %b, func_code %b, wme_signal %b, id_mux_sel %b wrong op %b", op_code, func_code, wme_signal, func_code, wrong_op_code);


initial
begin
  	op_code=4'b0000; func_code=4'b0000;
#10 	op_code=4'b0000; func_code=4'b0001;
#10 	op_code=4'b0000; func_code=4'b0010;
#10 	op_code=4'b0000; func_code=4'b0011;
#10 	op_code=4'b0000; func_code=4'b0100;
#10 	op_code=4'b0000; func_code=4'b0101;
#10 	op_code=4'b0000; func_code=4'b0110;
#10 	op_code=4'b0000; func_code=4'b0111;

#10 	op_code=4'b0000; func_code=4'b1000;
#10 	op_code=4'b0000; func_code=4'b1001;
#10 	op_code=4'b0000; func_code=4'b1010;
#10 	op_code=4'b0000; func_code=4'b1011;
#10 	op_code=4'b0000; func_code=4'b1100;
#10 	op_code=4'b0000; func_code=4'b1101;
#10 	op_code=4'b0000; func_code=4'b1110;
#10 	op_code=4'b0000; func_code=4'b1111;

#10	op_code=4'b0000; func_code=4'b0000;
#10 	op_code=4'b0001; func_code=4'b0001;
#10 	op_code=4'b0010; func_code=4'b0010;
#10 	op_code=4'b0011; func_code=4'b0011;
#10 	op_code=4'b0100; func_code=4'b0100;
#10 	op_code=4'b0101; func_code=4'b0101;
#10 	op_code=4'b0110; func_code=4'b0110;
#10 	op_code=4'b0111; func_code=4'b0111;

#10 	op_code=4'b1000; func_code=4'b1000;
#10 	op_code=4'b1001; func_code=4'b1001;
#10 	op_code=4'b1010; func_code=4'b1010;
#10 	op_code=4'b1011; func_code=4'b1011;
#10 	op_code=4'b1100; func_code=4'b1100;
#10 	op_code=4'b1101; func_code=4'b1101;
#10 	op_code=4'b1110; func_code=4'b1110;
#10 	op_code=4'b1111; func_code=4'b1111;


#10 	$finish;
end 
endmodule 
