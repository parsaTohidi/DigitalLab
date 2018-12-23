module instr_mem (	
	parameter delay = 100
        input [5:0] outpc,
        output reg [31:0] instruction 
         );

 	reg [31:0] memory [63:0];


 	#delay assign instruction =  memory[outpc];

endmodule