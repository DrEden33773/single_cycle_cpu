/*
  ALU := Algebraic Logic Unit
*/


module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [ 2:0] ALUOp,
    output [31:0] alu_out
);

  reg [31:0] out_reg;

  always @(*) begin
    case (ALUOp)
      default: out_reg = 0;  // default
      3'b000:  out_reg = a + b;  // add
      3'b001:  out_reg = a - b;  // sub
      3'b010:  out_reg = a & b;  // bitwise and
      3'b011:  out_reg = a | b;  // bitwise or
      3'b100:  out_reg = a ^ b;  // bitwise xor
      3'b101:  out_reg = a << b;  // shift left
      3'b110:  out_reg = a >> b;  // shift right
      3'b111:  out_reg = ~a;  // bitwise not
    endcase
  end

  assign alu_out = out_reg;

endmodule
