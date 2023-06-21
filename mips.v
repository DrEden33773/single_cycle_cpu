/*
  Mips := Top Level Mips CPU Emulator
*/

/*
  Five Stages of MIPS CPU
    1. IF := Instruction Fetch
    2. ID := Instruction Decode
    3. EXEC := Execute
    4. MEM := Memory Access
    5. WB := Write Back (to RegFile)
*/



/* imports */

`include "control/ctrl.v"
`include "datapath/fetcher/fetcher.v"
`include "datapath/splitter.v"
`include "datapath/alu.v"
`include "datapath/dm.v"
`include "datapath/ext.v"
`include "datapath/im.v"
`include "datapath/reg_file.v"
`include "tools/mux.v"
`include "tools/adder.v"
`include "tools/logic_expr.v"

module mips (
    input clk,  // clock
    input rst   // reset
);

  wire [15:0] imm16;
  wire [25:0] target;
  wire BranchSignal;
  wire BranchCondition;
  wire Jump;
  wire [31:0] instruction;

  // FetcherModule
  fetcher FetcherModule (
      .clk(clk),
      .rst(rst),
      .imm16(imm16),
      .target(target),
      .BranchSignal(BranchSignal),
      .BranchCondition(BranchCondition),
      .Jump(Jump),
      .instruction(instruction)
  );


endmodule
