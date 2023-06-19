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
  | 1010  | out <- in1 != in2 |
  | 1011  | out <- in1 == in2 |
  | 1100  | out <- in1 > in2 |
  | 1101  | out <- in1 >= in2 |
  | 1110  | out <- in1 >>> in2 |
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
    input  [31:0] a,
    input  [31:0] b,
    input  [ 3:0] ALUOp,
    output [31:0] ALUOut
);

  reg [31:0] out_reg;

  always @(*) begin
    case (ALUOp)
      default: out_reg = 0;
      alu.ADD: out_reg = a + b;
      alu.SUB: out_reg = a - b;
      alu.AND: out_reg = a & b;
      alu.OR:  out_reg = a | b;
      alu.XOR: out_reg = a ^ b;
      alu.SLL: out_reg = a << b;
      alu.SRL: out_reg = a >> b;
      alu.NOR: out_reg = ~(a | b);
      alu.SLT: out_reg = (a < b) ? 1 : 0;
      alu.SLE: out_reg = (a <= b) ? 1 : 0;
      alu.SEQ: out_reg = (a == b) ? 1 : 0;
      alu.SNE: out_reg = (a != b) ? 1 : 0;
      alu.SGT: out_reg = (a > b) ? 1 : 0;
      alu.SGE: out_reg = (a >= b) ? 1 : 0;
      alu.SRA: out_reg = a >>> b;
    endcase
  end

  assign ALUOut = out_reg;

endmodule
