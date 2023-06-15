/*
  RegFile := Register File
*/


module reg_file (
    clk,
    rst,
    we,
    Rw,
    Ra,
    Rb,
    busW,
    busA,
    busB
);

  /* clock */
  input clk;
  /* reset */
  input rst;
  /* write enable */
  input we;
  /* write addr */
  input [4:0] Rw;
  /* read addr A */
  input [4:0] Ra;
  /* read addr B */
  input [4:0] Rb;
  /* write data (from write addr) */
  input [31:0] busW;
  /* read data A (from read addr A) */
  output [31:0] busA;
  /* read data B (from read addr B) */
  output [31:0] busB;

  /* 32-bit * 32-bit registers  */
  reg [31:0] reges[31:0];
  /* loop counter */
  integer i = 0;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        reges[i] <= 0;
      end
    end else if (we) begin
      reges[Rw] <= busW;
    end
  end

  assign busA = reges[Ra];
  assign busB = reges[Rb];

endmodule
