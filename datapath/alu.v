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


`define ADD 4'b0000;
`define SUB 4'b0001;
`define AND 4'b0010;
`define OR 4'b0011;
`define XOR 4'b0100;
`define SLL 4'b0101;
`define SRL 4'b0110;
`define NOR 4'b0111;
`define SLT 4'b1000;
`define SLE 4'b1001;
`define SEQ 4'b1010;
`define SNE 4'b1011;
`define SGT 4'b1100;
`define SGE 4'b1101;
`define SRA 4'b1110;


module alu (
    input [31:0] a,
    input [31:0] b,
    input [3:0] ALUOp,
    output [31:0] ALUOut,
    output BranchCondition
);

  reg [31:0] alu_out;
  reg branch_condition;

  always @(*) begin
    case (ALUOp)
      /* default */
      default: alu_out = 0;
      /* algebra */
      alu.ADD: alu_out = a + b;
      alu.SUB: alu_out = a - b;
      alu.AND: alu_out = a & b;
      alu.OR:  alu_out = a | b;
      alu.XOR: alu_out = a ^ b;
      alu.SLL: alu_out = a << b;
      alu.SRL: alu_out = a >> b;
      alu.NOR: alu_out = ~(a | b);
      alu.SRA: alu_out = a >>> b;
      /* branch */
      alu.SLT: branch_condition = (a < b) ? 1 : 0;
      alu.SLE: branch_condition = (a <= b) ? 1 : 0;
      alu.SEQ: branch_condition = (a == b) ? 1 : 0;
      alu.SNE: branch_condition = (a != b) ? 1 : 0;
      alu.SGT: branch_condition = (a > b) ? 1 : 0;
      alu.SGE: branch_condition = (a >= b) ? 1 : 0;
    endcase
  end

  assign ALUOut = alu_out;
  assign BranchCondition = branch_condition;

endmodule
