/*
  Top Ctrl := General Controller
*/

/*
  Signals Definitions & Logic Expressions
    => reference : '../README.md'
*/


`include "r_sub_ctrl.v"
`include "i_sub_ctrl.v"
`include "j_sub_ctrl.v"
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
    output [3:0] ALUOp
);

  // >>> Split(instruction)
  wire [5:0] opcode = instruction[31:26];
  wire [5:0] funct = instruction[5:0];

  // >>> Judge(Type)
  assign RType = (opcode == 6'b000000) && (funct != 6'b000000);
  wire JType = (opcode == 6'b000010) || (opcode == 6'b000011);
  wire IType = ~RType && ~JType;

  // >>> RouteTo(SubCtrl)
  always @(instruction) begin
  end

endmodule
