/*
  EXT := Extend Unit
*/


module ext_16_to_32 (
    input [15:0] imm16,
    input ExtOp,
    output [31:0] ExtOut
);

  reg [31:0] ext_out_reg;

  always @(*) begin
    case (ExtOp)
      /* default case */
      default: ext_out_reg = {32{imm16[15]}};
      /* zero extend */
      0: ext_out_reg = {16'b0, imm16};
      /* sign extend */
      1: ext_out_reg = {{16{imm16[15]}}, imm16};
    endcase
  end

  assign ExtOut = ext_out_reg;

endmodule

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
