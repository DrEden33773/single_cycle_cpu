/*
  One Bit Signal Ctrl := Sub Controller for `One Bit Signal` (Except `Type`)
*/


module one_bit_signal_ctrl (
    input [5:0] op,
    input [4:0] rt,
    input [5:0] funct,
    output RegWr,
    output ALUSrc,
    output RegDst,
    output MemToReg,
    output MemWr,
    output Branch,
    output Jump,
    output Link
);

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

  // >>> Assign(Signal.Which(OneBit))
  assign RegWr = ~(
    _jr || _bgez || _bltz || _beq || _bne || _blez || _bgtz || _sb ||
    _sw || _j || _jal
  );
  assign ALUSrc = ~(
    _addu || _subu || _and || _or || _xor || _nor || _slt || _sltu || _sllv ||
    _srlv || _srav || _beq || _bne
  );
  assign RegDst = ~(_addiu || _slti || _sltiu || _andi || _ori || _xori || _lui);
  assign MemToReg = _lb || _lbu || _lw;
  assign MemWr = _sb || _sw;
  assign Branch = _bgez || _bltz || _beq || _bne || _blez || _bgtz;
  assign Jump = _jr || _jalr || _j || _jal;
  assign Link = _jalr || _jal;

endmodule
