/*
  ExtOp Ctrl := Sub Controller for ExtOp
*/


module ext_op_ctrl (
    input  [5:0] op,
    input  [4:0] rt,
    input  [5:0] funct,
    output [1:0] ExtOp
);

  parameter ZEXT = 2'b00;
  parameter SEXT = 2'b01;
  parameter LUI = 2'b10;
  parameter UNDEFINED = 2'bxx;

  assign RType = (op == 6'b000000) && (funct != 6'b000000);

  // >>> Distinguish.ForEach(Instruction) @Via.(Programmable Net)
  /* RType */
  wire _addu = RType && (funct == 6'b100001);
  wire _subu = RType && (funct == 6'b100011);
  wire _and = RType && (funct == 6'b100100);
  wire _or = RType && (funct == 6'b100101);
  wire _xor = RType && (funct == 6'b100110);
  wire _nor = RType && (funct == 6'b100111);
  wire _slt = RType && (funct == 6'b101010);
  wire _sltu = RType && (funct == 6'b101011);
  wire _sll = RType && (funct == 6'b000000);
  wire _srl = RType && (funct == 6'b000010);
  wire _sra = RType && (funct == 6'b000011);
  wire _sllv = RType && (funct == 6'b000100);
  wire _srlv = RType && (funct == 6'b000110);
  wire _srav = RType && (funct == 6'b000111);
  wire _jr = RType && (funct == 6'b001000);
  wire _jalr = RType && (funct == 6'b001001);
  /* IType */
  wire _bgez = (op == 6'b000001) && (rt == 5'b00001);
  wire _bltz = (op == 6'b000001) && (rt == 5'b00000);
  wire _addiu = (op == 6'b001001);
  wire _slti = (op == 6'b001010);
  wire _sltiu = (op == 6'b001011);
  wire _andi = (op == 6'b001100);
  wire _ori = (op == 6'b001101);
  wire _xori = (op == 6'b001110);
  wire _lui = (op == 6'b001111);
  wire _beq = (op == 6'b000100);
  wire _bne = (op == 6'b000101);
  wire _blez = (op == 6'b000110);
  wire _bgtz = (op == 6'b000111);
  wire _lb = (op == 6'b100000);
  wire _lbu = (op == 6'b100100);
  wire _sb = (op == 6'b101000);
  wire _lw = (op == 6'b100011);
  wire _sw = (op == 6'b101011);
  /* JType */
  wire _j = (op == 6'b000010);
  wire _jal = (op == 6'b000011);

  // >>> Judge(ExtCase)
  wire zext_case =
    _addu || _subu || _and || _or ||
    _xor || _nor || _sltu || _sll ||
    _srl || _sllv || _srlv || _jr ||
    _jalr || _sltiu || _andi || _ori ||
    _xori || _lbu;
  wire sext_case =
    _slt || _sra || _srav || _bltz ||
    _bgez || _addiu || _slti || _beq ||
    _bne || _blez || _bgtz || _lb ||
    _sb || _lw || _sw;
  wire lui_case = _lui;

  // >>> Assign(ExtOp)
  reg [1:0] ExtOpReg;
  always @(*) begin
    if (zext_case) begin
      ExtOpReg = ZEXT;
    end else if (sext_case) begin
      ExtOpReg = SEXT;
    end else if (lui_case) begin
      ExtOpReg = LUI;
    end else begin
      ExtOpReg = UNDEFINED;
    end
  end
  assign ExtOp = ExtOpReg;

endmodule
