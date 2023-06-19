/*
  Splitter := Split `Instruction`
    => [[Attention]]:
      => This module will split `Instruction` in all possible ways.
*/


module splitter (
    input  [31:0] instruction,
    output [ 5:0] opcode,
    output [ 4:0] rs,
    output [ 4:0] rt,
    output [ 4:0] rd,
    output [ 4:0] shamt,
    output [ 5:0] funct,
    output [15:0] imm16,
    output [25:0] target
);

  // RType
  assign opcode = instruction[31:26];
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd = instruction[15:11];
  assign shamt = instruction[10:6];
  assign funct = instruction[5:0];
  // IType
  assign imm16 = instruction[15:0];
  // JType
  assign target = instruction[25:0];

endmodule
