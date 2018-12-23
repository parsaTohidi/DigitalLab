module shiftleft2 ( shiftIn , shiftOut );
      parameter delay = 100;
      input [63:0] shiftIn;
      output [63:0] shiftOut;


          assign #delay shiftOut = shiftIn >> 2 ;


endmodule   
