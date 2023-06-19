/*
  Ctrl := General Controller
*/

/*
  Signals Definitions & Logic Expressions
    => reference : '../README.md'
*/


/* import */
`include "alu_op_ctrl.v"


module ctrl (
    input [31:0] instruction,
    output RegWr,
    output ALUSrc,
    output RegDst,
    output MemToReg,
    output MemWr,
    output Branch,
    output Jump,
    output Link,
    output [1:0] ExtOp,
    output RType,
    output JType,
    output IType,
    output [3:0] ALUOp
);
  // >>> Split(instruction)
  wire [5:0] op = instruction[31:26];
  wire [4:0] rt = instruction[25:21];
  wire [5:0] funct = instruction[5:0];

  // >>> Assign(Type)
  assign RType = (op == 6'b000000) && (funct != 6'b000000);
  assign JType = (op == 6'b000010) || (op == 6'b000011);
  assign IType = ~RType && ~JType;

  // >>> Assign(ALUOp)
  alu_op_ctrl assign_alu_op (
      .op(op),
      .rt(rt),
      .funct(funct),
      .ALUOp(ALUOp)
  );

  // >>> Assign(Signal.Which(OneBit))
  one_bit_signal_ctrl assign_one_bit_signal (
      .op(op),
      .rt(rt),
      .funct(funct),
      .RegWr(RegWr),
      .ALUSrc(ALUSrc),
      .RegDst(RegDst),
      .MemToReg(MemToReg),
      .MemWr(MemWr),
      .Branch(Branch),
      .Jump(Jump),
      .Link(Link)
  );

  // >>> Assign(ExtOp)
  ext_op_ctrl assign_ext_op (
      .op(op),
      .rt(rt),
      .funct(funct),
      .ExtOp(ExtOp)
  );


endmodule
