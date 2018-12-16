
module Memory
     
  ( 
  input clk,
  input [63 : 0] DataIn,
  input [63 : 0] Address,
  input memRead,
  input memWr,
  output [63 : 0] DataOut
  );
  
  reg [63 : 0] Memory [0 : 256];
  assign DataOut = memRead ? Memory[Address] : {64{1'bz}}; 
  
  always @(posedge clk) begin
      if(memWr)
      Memory[Address] <= DataIn;  
  end

endmodule     