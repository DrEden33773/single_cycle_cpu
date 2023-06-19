/*
  R Splitter := RType Instruction Splitter
*/


module r_splitter (
    input  [31:0] instruction,
    output [ 5:0] opcode,
    output [ 4:0] rs,
    output [ 4:0] rt,
    output [ 4:0] rd,
    output [ 4:0] shamt,
    output [ 5:0] funct
);

  // >>> Split(instruction)
  assign opcode = instruction[31:26];
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd = instruction[15:11];
  assign shamt = instruction[10:6];
  assign funct = instruction[5:0];

endmodule
