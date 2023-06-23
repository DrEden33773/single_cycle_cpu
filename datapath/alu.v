/*
  ALU := Algebraic Logic Unit

  | ALUOp | Description |
  | ----- | ----------- |
  | 0000  | alu_out <- in1 + in2 |
  | 0001  | alu_out <- in1 - in2 |
  | 0010  | alu_out <- in1 & in2 |
  | 0011  | alu_out <- in1 \| in2 |
  | 0100  | alu_out <- in1 ^ in2 |
  | 0101  | alu_out <- in1 << in2 |
  | 0110  | alu_out <- in1 >> in2 |
  | 0111  | alu_out <- ~(in1 \| in2) |
  | 1000  | alu_out <- in1 < in2 |
  | 1001  | alu_out <- in1 <= in2 |
  | 1010  | alu_out <- in1 != in2 |
  | 1011  | alu_out <- in1 == in2 |
  | 1100  | alu_out <- in1 > in2 |
  | 1101  | alu_out <- in1 >= in2 |
  | 1110  | alu_out <- in1 >>> in2 |
*/


module alu (
    input [31:0] a,
    input [31:0] b,
    input [3:0] ALUOp,
    output [31:0] ALUOut,
    output BranchCondition
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
  parameter SRA = 4'b1110;

  reg [31:0] alu_out;
  reg branch_condition;

  always @(*) begin
    case (ALUOp)
      /* default */
      default: alu_out = 0;
      /* algebra */
      ADD: alu_out = a + b;
      SUB: alu_out = a - b;
      AND: alu_out = a & b;
      OR: alu_out = a | b;
      XOR: alu_out = a ^ b;
      SLL: alu_out = a << b;
      SRL: alu_out = a >> b;
      NOR: alu_out = ~(a | b);
      SRA: alu_out = a >>> b;
      /* branch */
      SLT: branch_condition = (a < b) ? 1 : 0;
      SLE: branch_condition = (a <= b) ? 1 : 0;
      SEQ: branch_condition = (a == b) ? 1 : 0;
      SNE: branch_condition = (a != b) ? 1 : 0;
      SGT: branch_condition = (a > b) ? 1 : 0;
      SGE: branch_condition = (a >= b) ? 1 : 0;
    endcase
  end

  assign ALUOut = alu_out;
  assign BranchCondition = branch_condition;

endmodule
