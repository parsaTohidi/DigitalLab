
module testBench;
   reg [63:0] dataIn = 0;
   wire [63:0] newPC = 0;
   wire [63:0] oldPC = 0;
   wire myClk = 1;
   integer i;
   reg pc_reset;
<<<<<<< HEAD
   reg pos = 1'b1;
   reg neg = 1'b0;
=======
>>>>>>> b1fb49b65abe1d0c939023e18ac1fe8d346d97d9
   reg [63:0] add = 4;
   
   
   Adder adder (oldPC, add , newPC);
  
   pc PC(myClk, pc_reset,0, oldPC, newPC);
  
   oc myClock(myClk);
   
   Memory myMem(myClk, dataIn, newPC,1'b1, 1'b0, DataOut);
    
  initial
    for(i=0; i<32; i=i+1) begin
       dataIn = i; 
       #100;
    end
    
    
  always @(dataIn) begin   
    $display("dataIn = %0d,  dataOut = %0d, newPC = %0d \n", myMem.DataIn, myMem.DataOut);
  end
  
<<<<<<< HEAD
endmodule
=======
endmodule
>>>>>>> b1fb49b65abe1d0c939023e18ac1fe8d346d97d9
