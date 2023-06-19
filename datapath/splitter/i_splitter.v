/*
  I Splitter := IType Instruction Splitter
*/


module i_splitter (
    input  [31:0] instruction,
    output [ 5:0] opcode,
    output [ 4:0] rs,
    output [ 4:0] rt,
    output [15:0] imm16
);

  // >>> Split(instruction)
  assign opcode = instruction[31:26];
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign imm16 = instruction[15:0];

endmodule
