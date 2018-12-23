module Adder(input[63:0] a,input [63:0] b,output[63:0] out);
	parameter delay = 100
	assign #delay out = a+b ;
endmodule 
