/*
  NPC => NextPC Calculator
*/


`include "../ext.v"
`include "../../tools/mux.v"
module npc (
    input [31:0] PC,
    input [15:0] imm16,
    input [25:0] target,
    input BranchSignal,  // => ControlSignal.Branch
    input BranchCondition,  // => ALU.out
    input Jump,
    output [31:0] NextPC
);

  // >>> Generate(B_PC)
  wire [31:0] B_PC;
  assign B_PC = PC + 4;

  // >>> SignExtend(imm16).To(imm30)
  wire [29:0] imm30;
  ext_16_to_30 SignExtImm (
      .imm16 (imm16),
      .ExtOp (1),
      .ExtOut(imm30)
  );

  // >>> Get(Branched NPC)
  wire [31:0] Branched;
  assign Branched = B_PC + imm30 << 2;

  // >>> Get(Jumped NPC)
  wire [31:0] Jumped;
  assign Jumped   = {B_PC[31:28], target, 2'b00};

  // >>> Mux(0: B_PC, 1: Branched) => SelBranched
  assign IfBranch = BranchSignal & BranchCondition;
  wire [31:0] SelBranched;
  mux2_1 SelBranch (
      .zero(B_PC),
      .one (Branched),
      .sel (IfBranch),
      .out (SelBranched)
  );

  // >>> Mux(0: SelBranched, 1: Jumped) => NextPC
  mux2_1 SelJump (
      .zero(SelBranched),
      .one (Jumped),
      .sel (Jump),
      .out (NextPC)
  );

endmodule
