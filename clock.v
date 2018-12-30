module oc(output reg clk);
parameter delay = 100
always@(*)
begin 
	#delay clk = 1;
	#delay clk = 0;
end 
endmodule 