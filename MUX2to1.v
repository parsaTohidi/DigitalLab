module MUX2to1
  
  (
  input [63 : 0] dataIn1,
  input [63 : 0] dataIn2,
  input selector,
  output [63 : 0] Out
  );
  
  assign Out = selector ? dataIn2 : dataIn1; 
  
endmodule