module control_unit 
	#(parameter delay = 100)	
	(
	input[10:0] 	opcode,
  	output reg reg2Loc,
  	output	reg aluscr,
  	output reg memtoreg,
  	output reg regwrite,
	output	reg memread,
  	output reg memwrite,
	output 	reg branch,
	output	reg [1:0] aluop
	);
	
	always @(Instruction) begin

		case(opcode)
			11'b1x_x01_01x_000: begin //R-type
				reg2Loc <= 1'b0	;
			  	aluscr <= 1'b0;
			  	memtoreg <= 1'b0;
			  	regwrite <= 1'b1;
				memread <= 1'b0;
			  	memwrite <= 1'b0;
				branch <= 1'b0;
				aluop <= 2'b10;
			end
			11'b11_111_000_010: begin // LDUR
				
              	                reg2Loc <= 1'bx ;
			  	aluscr <= 1'b1;
			  	memtoreg <= 1'b1;
			  	regwrite <= 1'b1;
				memread <= 1'b1;
			  	memwrite <= 1'b0;
				branch <= 1'b0;
				aluop <= 2'b00;
			end
			11'b11_111_000_000: begin // STUR
				reg2Loc <= 1'b1	;
			  	aluscr <= 1'b1;
			  	memtoreg <= 1'bx;
			  	regwrite <= 1'b0;
				memread <= 1'b0;
			  	memwrite <= 1'b1;
				branch <= 1'b0;
				aluop <= 2'b00;   
			end
			11'b10_110_100_xxx: begin // CBZ
				reg2Loc <= 1'b1	;
			  	aluscr <= 1'b0;
			  	memtoreg <= 1'bx;
			  	regwrite <= 1'b0;
				memread <= 1'b0;
			  	memwrite <= 1'b0;
				branch <= 1'b1;
				aluop <= 2'b01;
			end
		endcase
	end
endmodule 
