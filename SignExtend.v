module signExtend(ins, extendedAddress);

	input [31:0] ins ;
	output reg [63:0] extendedAddress;
	
	wire opcode = ins[31:30]; 
	
	always @(*) begin
		case(opcode) 
			2'b00: extendedAddress = {{38{ins[25]}} ,ins[25:0] };    //B type
			2'b10: extendedAddress = {{45{ins[23]}} ,ins[23:5] };	//CB type
			2'b11: extendedAddress = {{55{ins[20]}} ,ins[20:12] };  //LDUR & STUR
		endcase
	end	
endmodule
