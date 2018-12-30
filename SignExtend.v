module signExtend(instruction, signExtendOut);

	input [31:0] instruction
	output reg [63:0] signExtendOut 

always@(instruction)
begin
	if (instruction[31:26] == 6'b000101)
	begin
        	signExtendOut[25:0] = instruction[25:0];
        	signExtendOut[63:26] = {38{signExtendOut[25]}};
	end //B_type

	else if (instruction[31:24] == 8'b10110100)
	begin 
        	signExtendOut[19:0] = instruction[23:5];
        	signExtendOut[63:20] = {44{signExtendOut[19]}};
	end //CB_type
 
	else 
	begin 
        	signExtendOut[9:0] = instruction[20:12];
        	signExtendOut[63:10] = {54{signExtendOut[9]}};
    	end //D_type
end
endmodule