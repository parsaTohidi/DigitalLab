module sign_extend( in, out );
input[31:0] in;
output[63:0] out;

reg[63:0] out;
wire[31:0] in;

always@(in)
begin
    out[31:0] = in[31:0];
    out[63:32] = {32{in[31]}};
end
endmodule 