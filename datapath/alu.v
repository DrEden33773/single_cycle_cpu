/*
  ALU := Algebraic Logic Unit

  | ALUOp | Description |
  | ----- | ----------- |
  | 0000  | out <- in1 + in2 |
  | 0001  | out <- in1 - in2 |
  | 0010  | out <- in1 & in2 |
  | 0011  | out <- in1 \| in2 |
  | 0100  | out <- in1 ^ in2 |
  | 0101  | out <- in1 << in2 |
  | 0110  | out <- in1 >> in2 |
  | 0111  | out <- ~(in1 \| in2) |
  | 1000  | out <- in1 < in2 |
  | 1001  | out <- in1 <= in2 |
  | 1010  | out <- in1 == in2 |
  | 1011  | out <- in1 != in2 |
  | 1100  | out <- in1 > in2 |
  | 1101  | out <- in1 >= in2 |
*/


module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [ 3:0] ALUOp,
    output [31:0] alu_out
);

  parameter ADD = 4'b0000;
  parameter SUB = 4'b0001;
  parameter AND = 4'b0010;
  parameter OR = 4'b0011;
  parameter XOR = 4'b0100;
  parameter SLL = 4'b0101;
  parameter SRL = 4'b0110;
  parameter NOR = 4'b0111;
  parameter SLT = 4'b1000;
  parameter SLE = 4'b1001;
  parameter SEQ = 4'b1010;
  parameter SNE = 4'b1011;
  parameter SGT = 4'b1100;
  parameter SGE = 4'b1101;

  reg [31:0] out_reg;

  always @(*) begin
    case (ALUOp)
      default: out_reg = 0;
      ADD: out_reg = a + b;
      SUB: out_reg = a - b;
      AND: out_reg = a & b;
      OR: out_reg = a | b;
      XOR: out_reg = a ^ b;
      SLL: out_reg = a << b;
      SRL: out_reg = a >> b;
      NOR: out_reg = ~(a | b);
      SLT: out_reg = (a < b) ? 1 : 0;
      SLE: out_reg = (a <= b) ? 1 : 0;
      SEQ: out_reg = (a == b) ? 1 : 0;
      SNE: out_reg = (a != b) ? 1 : 0;
      SGT: out_reg = (a > b) ? 1 : 0;
      SGE: out_reg = (a >= b) ? 1 : 0;
    endcase
  end

  assign alu_out = out_reg;

endmodule
