module signExtend(instruction, extendedAddress);

	input [31:0] instruction ;
	output reg [63:0] extended_address;
	
	wire opcode = instruction[31:30]; 
	
	always @(*) begin
		case(opcode) 
   2'b00: extendedAddress = {{38{instruction[25]}} ,instruction[25:0] };    
			2'b10: extendedAddress = {{45{instruction[23]}} ,instruction[23:5] };
   2'b11: extendedAddress = {{55{instruction[20]}} ,instruction[20:12] };   //LDUR & STUR
		endcase
	end	
endmodule
