# Single Cycle CPU

## Introduction

An implementation of `single-cycle-CPU` based on `LoonArch_32bit_MIPS_Primary` instruction set.

## Instructions

### R-type

| Instruction | Opcode | Funct  | Description |
| ----------- | ------ | -----  | ----------- |
| add         | 000000 | 100000 | `$rd = $rs + $rt` |
| sub         | 000000 | 100010 | `$rd = $rs - $rt` |
| and         | 000000 | 100100 | `$rd = $rs & $rt` |
| or          | 000000 | 100101 | `$rd = $rs \| $rt` |
| xor         | 000000 | 100110 | `$rd = $rs ^ $rt` |
| nor         | 000000 | 100111 | `$rd = ~($rs \| $rt)` |
| slt         | 000000 | 101010 | `$rd = ($rs < $rt) ? 1 : 0` |
| sll         | 000000 | 000000 | `$rd = $rt << shamt` |
| srl         | 000000 | 000010 | `$rd = $rt >> shamt` |
| jr          | 000000 | 001000 | `PC = $rs` |

### I-type

| Instruction | Opcode | Description |
| ----------- | ------ | ----------- |
| addi        | 001000 | `$rt = $rs + imm` |
| andi        | 001100 | `$rt = $rs & imm` |
| ori         | 001101 | `$rt = $rs \| imm` |
| xori        | 001110 | `$rt = $rs ^ imm` |
| slti        | 001010 | `$rt = ($rs < imm) ? 1 : 0` |
| lw          | 100011 | `$rt = Memory[$rs + imm]` |
| sw          | 101011 | `Memory[$rs + imm] = $rt` |
| beq         | 000100 | `if ($rs == $rt) PC = PC + 4 + imm * 4` |
| bne         | 000101 | `if ($rs != $rt) PC = PC + 4 + imm * 4` |

### J-type

| Instruction | Opcode | Description |
| ----------- | ------ | ----------- |
| j           | 000010 | `PC = imm` |
| jal         | 000011 | `$ra = PC + 4; PC = imm` |
