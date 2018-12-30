<<<<<<< HEAD
`default_nettype none
module CPU();
wire clk,
	 wPC,
	 Branch,
	 cout,
	 Z,
	 regMux_selector,
	 wRegbank,
	 aluMUX_selector,
	 readMem,
	 writeMem,
	 Mem_selector;
assign wPC = 1;
reg rstPC;
wire [1:0] ALUop;
wire [31:0] instruction;
wire [3:0] opAlu;
wire [4:0] regMUX_Out;
wire [63:0] memMUX_Out,
			signex_Out,
			oldpc,
			newpc,
			pcadder_Out, 
			dataRead1, 
			dataRead2,  
			aluMUX_Out, 
			alu_Out, 
			jumpadder_Out, 
			dataMem_out, 
			shift_out;
clock c(clk);
initial begin
	rstPC = 1;
	#210 rstPC = 0;

end
ControlUnit control(
  instruction[31:21],
  regMux_selector,
  aluMUX_selector,
  Mem_selector,
  wRegbank,
  readMem,
  writeMem,
  Branch,
  ALUop
  ); 
pc PC(clk,newpc,rstPC,wPC,oldpc);
// pc PC(clk,pcadder_Out,rstPC,wPC,oldpc);

adder pcadder( 1'b0,
			   oldpc, 
			   64'b100,
			   pcadder_Out, 
			   cout);

InstructionMemory imemory(oldpc,
						  instruction);

Mux regMUX( regMux_selector,
		    instruction[20:16], 
		    instruction[4:0], 
		    regMUX_Out);

regbank register(clk, 
				 instruction[9:5],
				 regMUX_Out, 
				 instruction[4:0], 
				 wRegbank, 
				 memMUX_Out, 
				 dataRead1, 
				 dataRead2);

SignExtend signex(instruction, 
				  signex_Out);

Mux aluMUX( aluMUX_selector, dataRead2, signex_Out, aluMUX_Out);
ALU alu(dataRead1, aluMUX_Out, opAlu, Z, alu_Out);
ALUcontrol Acontrol(
      ALUop,
      instruction,
      opAlu
    );
shift2left shift(signex_Out, shift_out);
adder jumpadder( 0 ,shift_out, oldpc , jumpadder_Out, cout);
Mux jumpMUX( Branch&Z, pcadder_Out, jumpadder_Out, newpc);
//Mux jumpMUX( 0, pcadder_Out, jumpadder_Out, newpc);
datamemory dmemory(clk, 
				   alu_Out, 
				   dataRead2, 
				   readMem,
	 			   writeMem, 
				   dataMem_out);

Mux memMUX(Mem_selector , alu_Out, dataMem_out, memMUX_Out);






=======
`default_nettype none
module CPU();
wire clk,
	 wPC,
	 Branch,
	 cout,
	 Z,
	 regMux_selector,
	 wRegbank,
	 aluMUX_selector,
	 readMem,
	 writeMem,
	 Mem_selector;
assign wPC = 1;
reg rstPC;
wire [1:0] ALUop;
wire [31:0] instruction;
wire [3:0] opAlu;
wire [4:0] regMUX_Out;
wire [63:0] memMUX_Out,
			signex_Out,
			oldpc,
			newpc,
			pcadder_Out, 
			dataRead1, 
			dataRead2,  
			aluMUX_Out, 
			alu_Out, 
			jumpadder_Out, 
			dataMem_out, 
			shift_out;
clock c(clk);
initial begin
	rstPC = 1;
	#210 rstPC = 0;

end
ControlUnit control(
  instruction[31:21],
  regMux_selector,
  aluMUX_selector,
  Mem_selector,
  wRegbank,
  readMem,
  writeMem,
  Branch,
  ALUop
  ); 
pc PC(clk,newpc,rstPC,wPC,oldpc);
// pc PC(clk,pcadder_Out,rstPC,wPC,oldpc);

adder pcadder( 1'b0,
			   oldpc, 
			   64'b100,
			   pcadder_Out, 
			   cout);

InstructionMemory imemory(oldpc,
						  instruction);

Mux regMUX( regMux_selector,
		    instruction[20:16], 
		    instruction[4:0], 
		    regMUX_Out);

regbank register(clk, 
				 instruction[9:5],
				 regMUX_Out, 
				 instruction[4:0], 
				 wRegbank, 
				 memMUX_Out, 
				 dataRead1, 
				 dataRead2);

SignExtend signex(instruction, 
				  signex_Out);

Mux aluMUX( aluMUX_selector, dataRead2, signex_Out, aluMUX_Out);
ALU alu(dataRead1, aluMUX_Out, opAlu, Z, alu_Out);
ALUcontrol Acontrol(
      ALUop,
      instruction,
      opAlu
    );
shift2left shift(signex_Out, shift_out);
adder jumpadder( 0 ,shift_out, oldpc , jumpadder_Out, cout);
Mux jumpMUX( Branch&Z, pcadder_Out, jumpadder_Out, newpc);
//Mux jumpMUX( 0, pcadder_Out, jumpadder_Out, newpc);
datamemory dmemory(clk, 
				   alu_Out, 
				   dataRead2, 
				   readMem,
	 			   writeMem, 
				   dataMem_out);

Mux memMUX(Mem_selector , alu_Out, dataMem_out, memMUX_Out);






>>>>>>> b1fb49b65abe1d0c939023e18ac1fe8d346d97d9
endmodule