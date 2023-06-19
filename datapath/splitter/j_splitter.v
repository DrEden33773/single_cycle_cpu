/*
  J Splitter := JType Instruction Splitter
*/


module j_splitter (
    input  [31:0] instruction,
    output [ 5:0] opcode,
    output [25:0] target
);

  // >>> Split(instruction)
  assign opcode = instruction[31:26];
  assign target = instruction[25:0];

endmodule
