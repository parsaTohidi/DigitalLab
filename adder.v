module adder 
( cin , a, b , s, cout);

	input cin;
	input [63:0] b;
	input [63:0] a ;
	output cout;
	output [63:0] s;

	assign {cout, s} = a + b + cin;
endmodule