# Single Cycle CPU

## Introduction

An implementation of `single-cycle-CPU` based on `LoonArch_32bit_MIPS_Primary` instruction set.

## Basic Knowledge

### Structure Of Instructions

In `MIPS`, length of all instructions is `32 bits`.

Instructions are divided into three types: `R-type`, `I-type` and `J-type`.

- R-type

| 31-26 | 25-21 | 20-16 | 15-11 | 10-6 | 5-0 |
| ----- | ----- | ----- | ----- | ---- | --- |
| opcode | rs | rt | rd | shamt | funct |
| 6 bits | 5 bits | 5 bits | 5 bits | 5 bits | 6 bits |

- I-type

| 31-26 | 25-21 | 20-16 | 15-0 |
| ----- | ----- | ----- | ---- |
| opcode | rs | rt | imm |
| 6 bits | 5 bits | 5 bits | 16 bits |

- J-type

| 31-26 | 25-0 |
| ----- | ---- |
| opcode | imm |
| 6 bits | 26 bits |

### Numeric Ranges

$$ Dex(rs), Dex(rt), Dex(rd) \in [0, 2^{5} - 1] $$

$$ Dex(shamt) \in [0, 2^{5} - 1] $$

$$
Dex(imm_\text{I}) \in \begin{cases}
    [0, 2^{16} - 1] & \text{(unsigned)} \\
    [-2^{15}, 2^{15} - 1] & \text{(signed)}
\end{cases}
$$

$$
Dex(imm_\text{J}) \in \begin{cases}
    [0, 2^{26} - 1] & \text{(unsigned)} \\
    [-2^{25}, 2^{25} - 1] & \text{(signed)}
\end{cases}
$$

## Basic Instructions

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
| j           | 000010 | `B_PC = PC + 4; PC = {B_PC[31:28], imm << 2}` |
| jal         | 000011 | `B_PC = PC + 4; PC = {B_PC[31:28], imm << 2}; $31 = B_PC + 4` |

## Control Signals

| Signal   | Description |
| ------   | ----------- |
| RegDst   | 1: rd = rt; 0: rd = rd |
| ALUSrc   | 1: ALU second operand = sign-extended immediate; 0: ALU second operand = rt |
| MemtoReg | 1: write the value in memory to register; 0: write the value in ALU to register |
| RegWrite | 1: write the value to register; 0: do not write the value to register |
| MemRead  | 1: read the value from memory; 0: do not read the value from memory |
| MemWrite | 1: write the value to memory; 0: do not write the value to memory |
| Branch   | 1: branch; 0: do not branch |
| ALUOp    | 00: add; 01: sub; 10: and; 11: or |
| Jump     | 1: jump; 0: do not jump |
| JumpReg  | 1: jump to register; 0: jump to immediate |

## Pipeline

### IF

- PC
- Instruction Memory

### ID

- Register File
- Sign Extend
- Control Unit

### EX

- ALU
- ALU Control
- Branch
- Jump

### MEM

- Data Memory

### WB

- Register File

## Hazard

### Data Hazard

- Forwarding

### Control Hazard

- Branch Prediction

## References

- [MIPS Instruction Reference](https://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf)
- [MIPS Instruction Set](https://www.cise.ufl.edu/~mssz/CompOrg/CDA-proc.html)
