`default_nettype none
module PipelineCPU();
wire clk,
	 wPC,
	 Branch,
	 cout,
	 Z,
	 regMux_selector,
	 wRegBank,
	 aluMUX_selector,
	 readMem,
	 writeMem,
	 Mem_selector;

wire IFID_wPC,
	 IFID_Branch,
	 IFID_cout,
	 IFID_Z,
	 IFID_regMux_selector,
	 IFID_wRegBank,
	 IFID_aluMUX_selector,
	 IFID_readMem,
	 IFID_writeMem,
	 IFID_Mem_selector;

wire IDEX_wPC,
	 IDEX_Branch,
	 IDEX_cout,
	 IDEX_Z,
	 IDEX_regMux_selector,
	 IDEX_wRegBank,
	 IDEX_aluMux_selector,
	 IDEX_readMem,
	 IDEX_writeMem,
	 IDEX_Mem_selector;

wire EXMEM_wPC,
	 EXMEM_Branch,
	 EXMEM_cout,
	 EXMEM_Z,
	 EXMEM_regMux_selector,
	 EXMEM_wRegBank,
	 EXMEM_readMem,
	 EXMEM_writeMem,
	 EXMEM_Mem_selector;

wire MEMWB_wPC,
	 MEMWB_Branch,
	 MEMWB_cout,
	 MEMWB_Z,
	 MEMWB_regMux_selector,
	 MEMWB_wRegBank,
	 MEMWB_readMem,
	 MEMWB_writeMem,
	 MEMWB_Mem_selector;

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

wire [1:0] IFID_ALUop;
wire [31:0] IFID_instruction;
wire [3:0] IFID_opAlu;
wire [4:0] IFID_regMUX_Out;
wire [63:0] IFID_memMUX_Out,
			IFID_signex_Out,
			IFID_oldpc,
			IFID_newpc,
			IFID_pcadder_Out, 
			IFID_dataRead1, 
			IFID_dataRead2,  
			IFID_aluMUX_Out, 
			IFID_alu_Out, 
			IFID_jumpadder_Out, 
			IFID_dataMem_out, 
			IFID_shift_out;

wire [1:0] IDEX_ALUop;
wire [31:0] IDEX_instruction;
wire [3:0] IDEX_opAlu;
wire [4:0] IDEX_regMUX_Out;
wire [63:0] IDEX_memMUX_Out,
			IDEX_signex_Out,
			IDEX_oldpc,
			IDEX_newpc,
			IDEX_pcadder_Out, 
			IDEX_dataRead1, 
			IDEX_dataRead2,  
			IDEX_aluMUX_Out, 
			IDEX_alu_Out, 
			IDEX_jumpadder_Out, 
			IDEX_dataMem_out, 
			IDEX_shift_out;

wire [1:0] EXMEM_ALUop;
wire [31:0] EXMEM_instruction;
wire [3:0] EXMEM_opAlu;
wire [4:0] EXMEM_regMUX_Out;
wire [63:0] EXMEM_memMUX_Out,
			EXMEM_signex_Out,
			EXMEM_oldpc,
			EXMEM_newpc,
			EXMEM_pcadder_Out, 
			EXMEM_dataRead1, 
			EXMEM_dataRead2,  
			EXMEM_aluMUX_Out, 
			EXMEM_alu_Out, 
			EXMEM_jumpadder_Out, 
			EXMEM_dataMem_out, 
			EXMEM_shift_out;

wire [1:0] MEMWB_ALUop;
wire [31:0] MEMWB_instruction;
wire [3:0] MEMWB_opAlu;
wire [4:0] MEMWB_regMUX_Out;
wire [63:0] MEMWB_memMUX_Out,
			MEMWB_signex_Out,
			MEMWB_oldpc,
			MEMWB_newpc,
			MEMWB_pcadder_Out, 
			MEMWB_dataRead1, 
			MEMWB_dataRead2,  
			MEMWB_aluMUX_Out, 
			MEMWB_alu_Out, 
			MEMWB_jumpadder_Out, 
			MEMWB_dataMem_out, 
			MEMWB_shift_out;

wire [10:0] IDEX_instruction3121;
wire [4:0] IDEX_instruction40;

wire [10:0] EXMEM_instruction3121;
wire [4:0] EXMEM_instruction40;

wire [10:0] MEMWB_instruction3121;
wire [4:0] MEMWB_instruction40;

clock c(clk);
initial begin
	rstPC = 1;
	#210 rstPC = 0;

end
Mux jumpMUX( EXMEM_Branch&EXMEM_Z, pcadder_Out, EXMEM_jumpadder_Out, newpc);
pc PC(clk,newpc,rstPC,wPC,oldpc);

adder pcadder( 1'b0,
			   oldpc, 
			   64'b100,
			   pcadder_Out, 
			   cout);
InstructionMemory imemory(oldpc,
						  instruction);


pc#(.n(64)) IFID_oldpc_reg(clk, oldpc, rstPC, wPC, IFID_oldpc);
pc#(.n(32)) IFID_instruction_reg(clk, instruction, rstPC, wPC, IFID_instruction);
// pc PC(clk,pcadder_Out,rstPC,wPC,oldpc);


Mux regMUX( regMux_selector,
		    IFID_instruction[20:16], 
		    IFID_instruction[4:0], 
		    regMUX_Out);

regbank register(clk, 
				 IFID_instruction[9:5],
				 regMUX_Out, 
				 MEMWB_instruction40,
				 MEMWB_wRegBank,
				 memMUX_Out,
				 dataRead1, 
				 dataRead2);

SignExtend signex(IFID_instruction, 
				  signex_Out);

ControlUnit control(
  IFID_instruction[31:21],
  regMux_selector,
  aluMUX_selector,
  Mem_selector,
  wRegBank,
  readMem,
  writeMem,
  Branch,
  ALUop
  );

pc#(.n(1)) IDEX_aluMux_selector_reg(clk, aluMUX_selector, rstPC, wPC, IDEX_aluMux_selector);
pc#(.n(1)) IDEX_Mem_selector_reg(clk, Mem_selector, rstPC, wPC, IDEX_Mem_selector);
pc#(.n(1)) IDEX_wRegBank_reg(clk, wRegBank, rstPC, wPC, IDEX_wRegBank);
pc#(.n(1)) IDEX_readMem_reg(clk, readMem, rstPC, wPC, IDEX_readMem);
pc#(.n(1)) IDEX_writeMem_reg(clk, writeMem, rstPC, wPC, IDEX_writeMem);
pc#(.n(1)) IDEX_Branch_reg(clk, Branch, rstPC, wPC, IDEX_Branch);
pc#(.n(2)) IDEX_ALUop_reg(clk, ALUop, rstPC, wPC, IDEX_ALUop);

pc#(.n(64)) IDEX_oldpc_reg(clk, IFID_oldpc, rstPC, wPC, IDEX_oldpc);
pc#(.n(64)) IDEX_dataRead1_reg(clk, dataRead1, rstPC, wPC, IDEX_dataRead1);
pc#(.n(64)) IDEX_dataRead2_reg(clk, dataRead2, rstPC, wPC, IDEX_dataRead2);
pc#(.n(64)) IDEX_signex_Out_reg(clk, signex_Out, rstPC, wPC, IDEX_signex_Out);
pc#(.n(32)) IDEX_instruction_reg(clk, IFID_instruction, rstPC, wPC, IDEX_instruction);
pc#(.n(11)) IDEX_instruction0_reg(clk, IFID_instruction[31:21], rstPC, wPC, IDEX_instruction3121);
pc#(.n(5)) IDEX_instruction1_reg(clk, IFID_instruction[4:0], rstPC, wPC, IDEX_instruction40);

Mux aluMUX( IDEX_aluMux_selector, IDEX_dataRead2, IDEX_signex_Out, aluMUX_Out);
ALU alu(IDEX_dataRead1, aluMUX_Out, opAlu, Z, alu_Out);
ALUcontrol Acontrol(
      IDEX_ALUop,
      IDEX_instruction3121,
      opAlu
    );
shift2left shift(IDEX_signex_Out, shift_out);
adder jumpadder( 0 ,IDEX_signex_Out, IDEX_oldpc , jumpadder_Out, cout);
//Mux jumpMUX( 0, pcadder_Out, jumpadder_Out, newpc);

pc#(.n(64)) EXMEM_jumpadder_Out_reg(clk, EXMEM_jumpadder_Out, rstPC, wPC, EXMEM_jumpadder_Out);
pc#(.n(1)) EXMEM_Z_reg(clk, Z, rstPC, wPC, EXMEM_Z);
pc#(.n(64)) EXMEM_alu_Out_reg(clk, alu_Out, rstPC, wPC, EXMEM_alu_Out);
pc#(.n(1)) EXMEM_readData2_reg(clk, IDEX_dataRead2, rstPC, wPC, EXMEM_dataRead2);
pc#(.n(5)) EXMEM_instruction_reg40(clk, IDEX_instruction40, rstPC, wPC, EXMEM_instruction40);

pc#(.n(32)) EXMEM_instruction_reg(clk, IDEX_instruction, rstPC, wPC, EXMEM_instruction);
pc#(.n(1)) EXMEM_Mem_selector_reg(clk, IDEX_Mem_selector, rstPC, wPC, EXMEM_Mem_selector);
pc#(.n(1)) EXMEM_readMem_reg(clk, IDEX_readMem, rstPC, wPC, EXMEM_readMem);
pc#(.n(1)) EXMEM_writeMem_reg(clk, IDEX_writeMem, rstPC, wPC, EXMEM_writeMem);
pc#(.n(1)) EXMEM_Branch_reg(clk, IDEX_Branch, rstPC, wPC, EXMEM_Branch);
pc#(.n(1)) EXMEM_wRegBank_reg(clk, IDEX_wRegBank, rstPC, wPC, EXMEM_wRegBank);



datamemory dmemory(clk, 
				   EXMEM_alu_Out, 
				   EXMEM_dataRead2, 
				   EXMEM_readMem,
	 			   EXMEM_writeMem, 
				   dataMem_out);

pc#(.n(64)) MEMWB_alu_Out_reg(clk, EXMEM_alu_Out, rstPC, wPC, MEMWB_alu_Out);
pc#(.n(64)) MEMWB_dataMem_out_reg(clk, dataMem_out, rstPC, wPC, MEMWB_dataMem_out);
pc#(.n(32)) MEMWB_instruction_reg(clk, EXMEM_instruction, rstPC, wPC, MEMWB_instruction);
pc#(.n(5)) MEMWB_instruction40_reg(clk, EXMEM_instruction40, rstPC, wPC, MEMWB_instruction40);
pc#(.n(1)) MEMWB_wRegBank_reg(clk, EXMEM_wRegBank, rstPC, wPC, MEMWB_wRegBank);
pc#(.n(1)) MEMWB_Mem_selector_reg(clk, EXMEM_Mem_selector, rstPC, wPC, MEMWB_Mem_selector);

Mux memMUX(MEMWB_Mem_selector, MEMWB_alu_Out, MEMWB_dataMem_out, memMUX_Out);








endmodule
