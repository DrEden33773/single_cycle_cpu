/*
  RegFile := Register File
*/


module reg_file (
    /* clock */
    input clk,
    /* reset */
    input rst,
    /* write enable */
    input RegWr,
    /* write addr */
    input [4:0] rw,
    /* read addr A */
    input [4:0] ra,
    /* read addr B */
    input [4:0] rb,
    /* write data (from write addr) */
    input [31:0] busW,
    /* read data A (from read addr A) */
    output [31:0] busA,
    /* read data B (from read addr B) */
    output [31:0] busB
);

  /* 32 * 32-bit registers  */
  reg [31:0] reges[31:0];
  /* loop counter */
  integer i = 0;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) reges[i] <= 0;
    end else if (RegWr) begin
      reges[rw] <= busW;
      reges[0]  <= 0;  // `$zero` should always be `0` [[not_writeable]]
    end
  end

  assign busA = reges[ra];
  assign busB = reges[rb];

endmodule
