/*
  ALU Control := Controller for `RType_ALU`
*/

/*
  Instructions :=
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
*/

/*
  ALUOp :=
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


module alu_ctrl (
    funct,
    ALUOp
);

  input [5:0] funct;
  output reg [3:0] ALUOp;

  /* funct params */
  parameter ADDU = 6'b100001;
  parameter SUBU = 6'b100011;
  parameter AND = 6'b100100;
  parameter OR = 6'b100101;
  parameter XOR = 6'b100110;
  parameter NOR = 6'b100111;
  parameter SLT = 6'b101010;
  parameter SLTU = 6'b101011;
  parameter SLL = 6'b000000;
  parameter SRL = 6'b000010;
  parameter SRA = 6'b000011;
  parameter SLLV = 6'b000100;
  parameter SRLV = 6'b000110;
  parameter SRAV = 6'b000111;

  /* ALUOp params */
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

  reg [31:0] ALUOp_Reg;

  always @(funct) begin
    case (funct)
      default: ALUOp = 4'b1111;
      ADDU: ALUOp = ADD_OP;
      SUBU: ALUOp = SUB_OP;
      AND: ALUOp = AND_OP;
      OR: ALUOp = OR_OP;
      XOR: ALUOp = XOR_OP;
      NOR: ALUOp = NOR_OP;
      SLT: ALUOp = SLT_OP;
      SLTU: ALUOp = SLT_OP;
      SLL: ALUOp = SL_OP;
      SRL: ALUOp = SR_OP;
      SRA: ALUOp = SR_OP;
      SLLV: ALUOp = SL_OP;
      SRLV: ALUOp = SR_OP;
      SRAV: ALUOp = SR_OP;
    endcase
  end

endmodule
