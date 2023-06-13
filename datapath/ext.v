/*
  EXT := Extend Unit
*/


module ext (
    input [15:0] imm16,
    input ExtOp,
    output [31:0] ext_out
);

  reg [31:0] ext_out_reg;

  always @(*) begin
    case (ExtOp)
      default: ext_out_reg = {32{imm16[15]}};  // default case
      2'b00:   ext_out_reg = {16'b0, imm16};  // zero extend
      2'b01:   ext_out_reg = {{16{imm16[15]}}, imm16};  // sign extend
    endcase
  end

  assign ext_out = ext_out_reg;

endmodule
