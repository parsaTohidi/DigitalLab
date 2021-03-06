<<<<<<< HEAD
module alu
	#(
     parameter delay = 100
    )

	(
           input [63:0] firstInput,secondInput,                  
           input [3:0] operation,
           output [63:0] ALU_Out, 
           output CarryOut 
    );
    reg [63:0] ALU_Result;
    wire [64:0] tmp;
    assign ALU_Out = ALU_Result; 
    assign tmp = firstInput + secondInput ;
    assign CarryOut = tmp[64]; 
    always @(firstInput, secondInput, operation)
    begin
        case(operation)
        4'b0000: 
           ALU_Result = firstInput + secondInput ; 
        4'b0001: 
           ALU_Result = firstInput - secondInput ;
        4'b0010: 
           ALU_Result = firstInput * secondInput;
        4'b0011: 
           ALU_Result = firstInput/secondInput;
          4'b1000: 
           ALU_Result = firstInput & secondInput;
          4'b1001: 
           ALU_Result = firstInput | secondInput;
          4'b1010: 
           ALU_Result = firstInput ^ secondInput;

          default: ALU_Result = firstInput + secondInput ; 
        endcase
    end

endmodule
=======
module alu(
           input [63:0] firstInput,secondInput,                  
           input [3:0] operation,
           output [63:0] ALU_Out, 
           output CarryOut 
    );
           reg [63:0] ALU_Result;
           wire [64:0] tmp;
    assign ALU_Out = ALU_Result; 
    assign tmp = firstInput + secondInput ;
           assign CarryOut = tmp[64]; 
    always @(firstInput, secondInput, operation)
    begin
        case(operation)
        4'b0000: base on page 271 of book
           ALU_Result = firstInput + secondInput ; 
        4'b0001: 
           ALU_Result = firstInput - secondInput ;
        4'b0010: 
           ALU_Result = firstInput * secondInput;
        4'b0011: 
           ALU_Result = firstInput/secondInput;
          4'b1000: 
           ALU_Result = firstInput & secondInput;
          4'b1001: 
           ALU_Result = firstInput | secondInput;
          4'b0111: 
           ALU_Result = secondInput;
          4'b1100: 
           ALU_Result =  ~(firstInput|secondInput);

          default: ALU_Result = firstInput + secondInput ; 
        endcase
    end

endmodule
>>>>>>> b1fb49b65abe1d0c939023e18ac1fe8d346d97d9
