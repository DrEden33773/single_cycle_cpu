/*
  EXT := Extend Unit
*/


/// Support `LUI`
module ext_16_to_32 (
    input  [15:0] imm16,
    input  [ 1:0] ExtOp,
    output [31:0] ExtOut
);

  reg [31:0] ext_out_reg;

  always @(*) begin
    case (ExtOp)
      /* default case */
      default: ext_out_reg = {32{imm16[15]}};
      /* zero extend */
      2'b00:   ext_out_reg = {16'b0, imm16};
      /* sign extend */
      2'b01:   ext_out_reg = {{16{imm16[15]}}, imm16};
      /* LUI */
      2'b10:   ext_out_reg = {imm16, 16'b0};
    endcase
  end

  assign ExtOut = ext_out_reg;

endmodule


/// Haven't Support `LUI`
module ext_16_to_30 (
    input [15:0] imm16,
    input ExtOp,
    output [31:0] ExtOut
);

  reg [31:0] ext_out_reg;

  always @(*) begin
    case (ExtOp)
      /* default case */
      default: ext_out_reg = {30{imm16[15]}};
      /* zero extend */
      0: ext_out_reg = {14'b0, imm16};
      /* sign extend */
      1: ext_out_reg = {{14{imm16[15]}}, imm16};
    endcase
  end

  assign ExtOut = ext_out_reg;

endmodule
