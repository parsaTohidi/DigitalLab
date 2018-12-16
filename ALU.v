module alu(
           input [7:0] firstInput,secondInput,                  
           input [3:0] operation,
           output [7:0] ALU_Out, 
           output CarryOut 
    );
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    assign ALU_Out = ALU_Result; 
    assign tmp = firstInput + secondInput ;
    assign CarryOut = tmp[8]; 
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