/*
  ctrl := Control Unit
*/

/*
  ### R-type

  | Instruction | Opcode | Funct  | Description |
  | ----------- | ------ | -----  | ----------- |
  | addu        | 000000 | 100001 | `$rd = $rs + $rt` |
  | subu        | 000000 | 100011 | `$rd = $rs - $rt` |
  | and         | 000000 | 100100 | `$rd = $rs & $rt` |
  | or          | 000000 | 100101 | `$rd = $rs \| $rt` |
  | xor         | 000000 | 100110 | `$rd = $rs ^ $rt` |
  | nor         | 000000 | 100111 | `$rd = ~($rs \| $rt)` |
  | slt         | 000000 | 101010 | `$rd = (sExt($rs) < sExt($rt)) ? 1 : 0` |
  | sltu        | 000000 | 101011 | `$rd = (zExt($rs) < zExt($rt)) ? 1 : 0` |
  | sll         | 000000 | 000000 | `$rd = zExt($rt) << shamt` |
  | srl         | 000000 | 000010 | `$rd = zExt($rt) >> shamt` |
  | sra         | 000000 | 000011 | `$rd = sExt($rt) >> shamt` |
  | sllv        | 000000 | 000100 | `$rd = zExt($rt) << $rs` |
  | srlv        | 000000 | 000110 | `$rd = zExt($rt) >> $rs` |
  | srav        | 000000 | 000111 | `$rd = sExt($rt) >> $rs` |
  | jr          | 000000 | 001000 | `PC = $rs` |
  | jalr (rd = 31)       | 000000 | 001001 | `$31 = (PC + 4) + 4; PC = $rs` |

  ### I-type

  | Instruction | Opcode | Description |
  | ----------- | ------ | ----------- |
  | bgez        | 000001 (rt = 1) | `if ($rs >= 0) PC = PC + 4 + sExt(imm) << 2` |
  | bltz        | 000001 (rt = 0) | `if ($rs < 0) PC = PC + 4 + sExt(imm) << 2` |
  | addiu       | 001001 | `$rt = $rs + sExt(imm)` |
  | slti        | 001010 | `$rt = (sExt($rs) < sExt(imm)) ? 1 : 0` |
  | sltiu       | 001011 | `$rt = (zExt($rs) < sExt(imm)) ? 1 : 0` |
  | andi        | 001100 | `$rt = $rs & zExt(imm)` |
  | ori         | 001101 | `$rt = $rs \| zExt(imm)` |
  | xori        | 001110 | `$rt = $rs ^ zExt(imm)` |
  | lui         | 001111 | `$rt = imm << 16` |
  | beq         | 000100 | `if ($rs == $rt) PC = PC + 4 + sExt(imm) << 2` |
  | bne         | 000101 | `if ($rs != $rt) PC = PC + 4 + sExt(imm) << 2` |
  | blez        | 000110 | `if ($rs <= 0) PC = PC + 4 + sExt(imm) << 2` |
  | bgtz        | 000111 | `if ($rs > 0) PC = PC + 4 + sExt(imm) << 2` |
  | lb          | 100000 | `$rt = sExt(MEM[$rs + sExt(imm)])` |
  | lbu         | 100100 | `$rt = zExt(MEM[$rs + sExt(imm)])` |
  | sb          | 101000 | `MEM[$rs + sExt(imm)] = $rt` |
  | lw          | 100011 | `$rt = MEM[$rs + sExt(imm)]` |
  | sw          | 101011 | `MEM[$rs + sExt(imm)] = $rt` |

  ### J-type

  | Instruction | Opcode | Description |
  | ----------- | ------ | ----------- |
  | j           | 000010 | `PC = {(PC + 4)[31:28], imm << 2}` |
  | jal         | 000011 | `PC = {(PC + 4)[31:28], imm << 2}; $31 = (PC + 4) + 4` |
*/

/*
  ### 0-1 Signals

  | Signal   | Description |
  | ------   | ----------- |
  | RegWr    | 1: write to reg, 0: won't write to reg |
  | ALUSrc   | 1: ALU.src := imm, 0: ALU.src := reg |
  | RegDst   | 1: rd <- rt, 0: rd <- rd |
  | MemToReg | 1: reg <- MEM\[ALU.out\], 0: reg <- ALU.out |
  | MemWr    | 1: MEM\[ALU.out\] <- rt, 0: won't write to MEM |
  | Branch   | 1: PC <- PC + 4 + sExt(imm) << 2, 0: won't branch |
  | Jump     | 1: PC <- {B_PC\[31:28\], imm << 2}, 0: won't jump |
  | Link     | 1: $31 <- PC + 4, 0: won't link |
  | ExtOp    | 1: sExt, 0: zExt |
  | RType    | 1: R-type, 0: not R-type |

  ### 4-bit ALUOp

  | ALUOp | Description |
  | ----- | ----------- |
  | 0000  | out <- in1 + in2 |
  | 0001  | out <- in1 - in2 |
  | 0010  | out <- in1 & in2 |
  | 0011  | out <- in1 \| in2 |
  | 0100  | out <- in1 ^ in2 |
  | 0101  | out <- in1 << in2 |
  | 0110  | out <- in1 >> in2 |
  | 0111  | out <- ~(in1 \| in2) |
  | 1000  | out <- in1 < in2 |
  | 1001  | out <- in1 <= in2 |
  | 1010  | out <- in1 == in2 |
  | 1011  | out <- in1 != in2 |
  | 1100  | out <- in1 > in2 |
  | 1101  | out <- in1 >= in2 |
*/


module ctrl (
    instruction,
    RegWr,
    ALUSrc,
    RegDst,
    MemToReg,
    MemWr,
    Branch,
    Jump,
    Link,
    ExtOp,
    RType,
    ALUOp
);

  /* Ports */
  input [31:0] instruction;
  output RegWr;
  output ALUSrc;
  output RegDst;
  output MemToReg;
  output MemWr;
  output Branch;
  output Jump;
  output Link;
  output ExtOp;
  output RType;
  output [3:0] ALUOp;

  /* >>> Split(instruction) */
  wire [5:0] opcode = instruction[31:26];
  wire [4:0] rs = instruction[25:21];
  wire [4:0] rt = instruction[20:16];
  wire [4:0] rd = instruction[15:11];
  wire [4:0] shamt = instruction[10:6];
  wire [5:0] funct = instruction[5:0];
  wire [15:0] imm16 = instruction[15:0];
  wire [25:0] imm26 = instruction[25:0];

  /* RType Inst => Distinguish := funct */
  wire ADDU = opcode == 0 && funct == 6'b100001;
  wire SUBU = opcode == 0 && funct == 6'b100011;
  wire AND = opcode == 0 && funct == 6'b100100;
  wire OR = opcode == 0 && funct == 6'b100101;
  wire XOR = opcode == 0 && funct == 6'b100110;
  wire NOR = opcode == 0 && funct == 6'b100111;
  wire SLT = opcode == 0 && funct == 6'b101010;
  wire SLTU = opcode == 0 && funct == 6'b101011;
  wire SLL = opcode == 0 && funct == 6'b000000;
  wire SRL = opcode == 0 && funct == 6'b000010;
  wire SRA = opcode == 0 && funct == 6'b000011;
  wire SLLV = opcode == 0 && funct == 6'b000100;
  wire SRLV = opcode == 0 && funct == 6'b000110;
  wire SRAV = opcode == 0 && funct == 6'b000111;
  wire JR = opcode == 0 && funct == 6'b001000;
  wire JALR = opcode == 0 && funct == 6'b001001;

  /* IType Inst => Distinguish := opcode, rt[[maybe_unused]] */
  wire BGEZ = opcode == 6'b000001 && rt == 5'b00001;
  wire BLTZ = opcode == 6'b000001 && rt == 5'b00000;
  wire ADDIU = opcode == 6'b001001;
  wire SLTI = opcode == 6'b001010;
  wire SLTIU = opcode == 6'b001011;
  wire ANDI = opcode == 6'b001100;
  wire ORI = opcode == 6'b001101;
  wire XORI = opcode == 6'b001110;
  wire LUI = opcode == 6'b001111;
  wire BEQ = opcode == 6'b000100;
  wire BNE = opcode == 6'b000101;
  wire BLEZ = opcode == 6'b000110;
  wire BGTZ = opcode == 6'b000111;
  wire LB = opcode == 6'b100000;
  wire LBU = opcode == 6'b100100;
  wire SB = opcode == 6'b101000;
  wire LW = opcode == 6'b100011;
  wire SW = opcode == 6'b101011;

  /* JType Inst => Distinguish := opcode */
  wire J = opcode == 6'b000010;
  wire JAL = opcode == 6'b000011;

  /* ALUOp Parameter */
  parameter ADD_OP = 4'b0000;
  parameter SUB_OP = 4'b0001;
  parameter AND_OP = 4'b0010;
  parameter OR_OP = 4'b0011;
  parameter XOR_OP = 4'b0100;
  parameter SL_OP = 4'b0101;
  parameter SR_OP = 4'b0110;
  parameter NOR_OP = 4'b0111;
  parameter SLT_OP = 4'b1000;
  parameter SLE_OP = 4'b1001;
  parameter SEQ_OP = 4'b1010;
  parameter SNE_OP = 4'b1011;
  parameter SGT_OP = 4'b1100;
  parameter SGE_OP = 4'b1101;

  /* >>> Assign(ALUOp)  */




endmodule
