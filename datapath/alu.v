/*
  ALU := Algebraic Logic Unit
*/


module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [ 2:0] alu_op,
    output [31:0] alu_out
);

  reg [31:0] alu_out_reg;

  always @(*) begin
    case (alu_op)
      3'b000: alu_out_reg = a + b;  // add
      3'b001: alu_out_reg = a - b;  // sub
      3'b010: alu_out_reg = a & b;  // bitwise and
      3'b011: alu_out_reg = a | b;  // bitwise or
      3'b100: alu_out_reg = a ^ b;  // bitwise xor
      3'b101: alu_out_reg = a << b;  // shift left
      3'b110: alu_out_reg = a >> b;  // shift right
      3'b111: alu_out_reg = ~a;  // bitwise not
    endcase
  end

  assign alu_out = alu_out_reg;

endmodule
