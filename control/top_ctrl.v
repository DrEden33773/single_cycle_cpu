/*
  Top Ctrl := General Controller
*/

/*
  Signals Definitions & Logic Expressions
    => reference : '../README.md'
*/


`include "../tools/logic_expr.v"
`include "../tools/mux.v"
module top_ctrl (
    input [31:0] instruction,
    output RegWr,
    output ALUSrc,
    output RegDst,
    output MemToReg,
    output MemWr,
    output Branch,
    output Jump,
    output Link,
    output ExtOp,
    output RType,
    output JType,
    output IType,
    output [3:0] ALUOp
);

  // >>> Split(instruction)
  wire [5:0] opcode = instruction[31:26];
  wire [5:0] funct = instruction[5:0];

  // >>> Judge(Type)
  assign RType = (opcode == 6'b000000) && (funct != 6'b000000);
  assign JType = (opcode == 6'b000010) || (opcode == 6'b000011);
  assign IType = ~RType && ~JType;

  // >>> RouteTo(SubCtrl)
  always @(instruction) begin
  end

endmodule
