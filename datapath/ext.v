/*
  EXT := Extend Unit
*/


module ext_16_to_32 (
    input [15:0] imm16,
    input ExtOp,
    output [31:0] ext_out
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
    endcase
  end

  assign ext_out = ext_out_reg;

endmodule


module ext_any_to_32 #(
    parameter IMM_WIDTH = 16
) (
    input [IMM_WIDTH-1:0] imm,
    input ExtOp,
    output [31:0] ext_out
);

  reg [31:0] ext_out_reg;

  always @(*) begin
    case (ExtOp)
      /* default case */
      default: ext_out_reg = {32{imm[IMM_WIDTH-1]}};
      /* zero extend */
      2'b00:   ext_out_reg = {0, imm};
      /* sign extend */
      2'b01:   ext_out_reg = {{(32 - IMM_WIDTH) {imm[IMM_WIDTH-1]}}, imm};
    endcase
  end

  assign ext_out = ext_out_reg;

endmodule  //name
