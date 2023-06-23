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
  wire [ 4:0] rt_rd;
  wire [ 4:0] rw;
  wire [31:0] busW_UnLinked;
  wire [31:0] busW_Linked;
  wire [31:0] busW;
  wire [31:0] busRS;
  wire [31:0] busRT;

  mux_RegDst SelRtRd (
      .rt(rt),
      .rd(rd),
      .RegDst(RegDst),
      .rt_rd(rt_rd)
  );

  mux_RtRd_Rw_IfLinked Sel_RtRd_Rw_IfLinked (
      .rt_rd(rt_rd),
      .Link(Link),
      .rw(rw)
  );

  assign busW_Linked = B_PC + 4;

  mux2_1 Sel_busW_IfLinked (
      .zero(busW_UnLinked),
      .one (busW_Linked),
      .sel (Link),
      .out (busW)
  );

  reg_file GPR (
      .clk(clk),
      .rst(rst),
      .RegWr(RegWr),
      .rw(rw),
      .ra(rs),
      .rb(rt),
      .busW(busW),
      .busA(busRS),
      .busB(busRT)
  );


  /// 3. EXEC := Execute

  /* ext */
  wire [31:0] ext_imm32;

  ext_16_to_32 ExtImm16 (
      .imm16 (imm16),
      .ExtOp (ExtOp),
      .ExtOut(ext_imm32)
  );

  /* alu */
  wire [31:0] ALUInA;
  wire [31:0] ALUInB;
  wire [31:0] ALUOut;

  mux2_1 SelRtImm (
      .zero(busRT),
      .one (ext_imm32),
      .sel (ALUSrc),
      .out (ALUOut)
  );

  alu ALUModule (
      .a(ALUInA),
      .b(ALUInB),
      .ALUOp(ALUOp),
      .ALUOut(ALUOut),
      .BranchCondition(BranchCondition)
  );


  /// 4. MEM := Memory Access

  /* dm */
  wire [31:0] dout;

  dm_4k DataMemModule (
      .clk (clk),
      .we  (MemWr),
      .addr(ALUOut[9:0]),
      .din (busRT),
      .dout(dout)
  );


  /// 5. WB := Write Back (to RegFile)

  /* mux */
  mux2_1 Sel_ALUOut_Dout (
      .zero(ALUOut),
      .one (dout),
      .sel (MemToReg),
      .out (busW_UnLinked)
  );

endmodule
