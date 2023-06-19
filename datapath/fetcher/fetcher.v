/*
  Fetcher := Instruction Fetcher
    => Combine [`npc.v`, `pc.v`]
    => With `im.v`
*/


`include "npc.v"
`include "pc.v"
`include "../im.v"
module fetcher (
    input clk,
    input rst,
    input [15:0] imm16,
    input [25:0] target,
    input BranchSignal,
    input BranchCondition,
    input Jump,
    output [31:0] instruction
);

  /* 32-bit PC */
  wire [31:0] PC;
  /* Current PC */
  wire [31:0] CurrPC;
  /* Next PC */
  wire [31:0] NextPC;

  /* PC => Get(CurrPC) */
  pc PCModule (
      .clk(clk),
      .rst(rst),
      .PC(PC),
      .CurrPC(CurrPC)
  );

  /* NPC => Get(NextPC) */
  npc NPCModule (
      .PC(CurrPC),
      .imm16(imm16),
      .target(target),
      .BranchSignal(BranchSignal),
      .BranchCondition(BranchCondition),
      .Jump(Jump),
      .NextPC(NextPC)
  );

  /* IM => Fetch.Addr(CurrPC).From(im_4k) */
  im_4k ImModule (
      .addr(CurrPC[9:0]),
      .dout(instruction)
  );

  // >>> Update(PC)
  assign PC = NextPC;

endmodule
