module RegisterBank
	#(
    parameter delay = 100
	  )
	
	(clk,
	regWrite,
	readReg1,readReg2,writeReg,
	writeData,
	RegData1,RegData2
);

	input regWrite,clk;
	input[4:0] readReg1,readReg2,writeReg;
	input[63:0] writeData;
	output[63:0] RegData1,RegData2;
	reg[63:0]registersArray[31:0];
	


	always @(posedge clk)
	begin
		RegData1 <= registersArray[readReg1];
		RegData2 <= registersArray[readReg2];
	end

	always @(posedge clk)
	begin
		if(regWrite)
		     begin
			
		 registersArray[writeReg] <= writeData;

		     end
	end

endmodule
