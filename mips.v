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
    input clk,
    input rst
);

  /// 1. IF := Instruction Fetch

  /* fetcher */
  wire [15:0] imm16;
  wire [25:0] target;
  wire BranchSignal;  // If xxx instruction is `Branch` instruction
  wire BranchCondition;  // If xxx Branch instruction satisfies the condition to branch
  wire Jump;
  wire [31:0] instruction;
  wire [31:0] B_PC;

  fetcher FetcherModule (
      .clk(clk),
      .rst(rst),
      .imm16(imm16),
      .target(target),
      .BranchSignal(BranchSignal),
      .BranchCondition(BranchCondition),
      .Jump(Jump),
      .instruction(instruction),
      .B_PC(B_PC)
  );

  /* controller (with signals) */
  wire RegWr;
  wire ALUSrc;
  wire RegDst;
  wire MemToReg;
  wire MemWr;
  wire Link;
  wire [1:0] ExtOp;
  wire RType;
  wire JType;
  wire IType;
  wire [3:0] ALUOp;

  ctrl CtrlModule (
      .instruction(instruction),
      .RegWr(RegWr),
      .ALUSrc(ALUSrc),
      .RegDst(RegDst),
      .MemToReg(MemToReg),
      .MemWr(MemWr),
      .Branch(BranchSignal),
      .Jump(Jump),
      .Link(Link),
      .ExtOp(ExtOp),
      .RType(RType),
      .JType(JType),
      .IType(IType),
      .ALUOp(ALUOp)
  );


  /// 2. ID := Instruction Decode

  /* splitter */
  wire [5:0] opcode;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [4:0] shamt;
  wire [5:0] funct;

  splitter SplitterModule (
      .instruction(instruction),
      .opcode(opcode),
      .rs(rs),
      .rt(rt),
      .rd(rd),
      .shamt(shamt),
      .funct(funct),
      .imm16(imm16),
      .target(target)
  );

  /* reg_file (aka. GPR) */
  wire [ 4:0] rw;
  wire [31:0] busW;
  wire [31:0] busA;
  wire [31:0] busB;

  mux_RegDst SelRtRd (
      .rt(rt),
      .rd(rd),
      .RegDst(RegDst),
      .rw(rw)
  );

  reg_file GPR (
      .clk(clk),
      .rst(rst),
      .RegWr(RegWr),
      .Rw(rw),
      .Ra(rs),
      .Rb(rt),
      .busW(busW),
      .busA(busA),
      .busB(busB)
  );

endmodule
