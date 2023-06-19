/*
  Top Ctrl := General Controller
*/

/*
  Signals Definitions & Logic Expressions
    => reference : '../README.md'
*/


module top_ctrl (
    input [31:0] instruction
);

  // >>> Split(instruction)
  wire [ 5:0] opcode = instruction[31:26];
  wire [ 4:0] rs = instruction[25:21];
  wire [ 4:0] rt = instruction[20:16];
  wire [ 4:0] rd = instruction[15:11];
  wire [ 5:0] shamt = instruction[10:6];
  wire [ 5:0] funct = instruction[5:0];
  wire [15:0] imm16 = instruction[15:0];
  wire [25:0] imm26 = instruction[25:0];


endmodule
