/*
  ALUOp Ctrl := Sub Controller for ALUOp
*/


/* ALUOp Macros */
`define ADD 4'b0000;
`define SUB 4'b0001;
`define AND 4'b0010;
`define OR 4'b0011;
`define XOR 4'b0100;
`define SLL 4'b0101;
`define SRL 4'b0110;
`define NOR 4'b0111;
`define SLT 4'b1000;
`define SLE 4'b1001;
`define SEQ 4'b1010;
`define SNE 4'b1011;
`define SGT 4'b1100;
`define SGE 4'b1101;
`define SRA 4'b1110;
`define UNDEFINED 4'bxxxx;


module alu_op_ctrl (
    input  [5:0] op,
    input  [4:0] rt,
    input  [5:0] funct,
    output [3:0] ALUOp
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

  // >>> Assign(ALUOp)
  reg [3:0] ALUOpReg;
  always @(*) begin
    if (_addu || _addiu || _lb || _lbu || _sb || _lw || _sw) begin
      ALUOpReg = alu_op_ctrl.ADD;
    end else if (_subu) begin
      ALUOpReg = alu_op_ctrl.SUB;
    end else if (_and || _andi) begin
      ALUOpReg = alu_op_ctrl.AND;
    end else if (_or || _ori) begin
      ALUOpReg = alu_op_ctrl.OR;
    end else if (_xor || _xori) begin
      ALUOpReg = alu_op_ctrl.XOR;
    end else if (_sll || _sllv) begin
      ALUOpReg = alu_op_ctrl.SLL;
    end else if (_srl || _srlv) begin
      ALUOpReg = alu_op_ctrl.SRL;
    end else if (_nor) begin
      ALUOpReg = alu_op_ctrl.NOR;
    end else if (_slt || _sltu || _bltz || _slti || _sltiu) begin
      ALUOpReg = alu_op_ctrl.SLT;
    end else if (_blez) begin
      ALUOpReg = alu_op_ctrl.SLE;
    end else if (_bne) begin
      ALUOpReg = alu_op_ctrl.SNE;
    end else if (_beq) begin
      ALUOpReg = alu_op_ctrl.SEQ;
    end else if (_bgtz) begin
      ALUOpReg = alu_op_ctrl.SGT;
    end else if (_bgez) begin
      ALUOpReg = alu_op_ctrl.SGE;
    end else if (_sra || _srav) begin
      ALUOpReg = alu_op_ctrl.SRA;
    end else begin
      ALUOpReg = alu_op_ctrl.UNDEFINED;
    end
  end
  assign ALUOp = ALUOpReg;

endmodule
