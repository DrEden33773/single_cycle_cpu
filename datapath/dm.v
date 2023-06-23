/*
  DM := Data Memory
*/


module dm_4k (
    clk,
    we,
    addr,
    din,
    dout
);

  /* clock */
  input clk;
  /* memory write enable */
  input we;
  /* address bus */
  input [11:2] addr;
  /* 32-bit input data */
  input [31:0] din;
  /* 32-bit memory output */
  output [31:0] dout;

  /* data memory */
  reg [31:0] dm[1023:0];

  always @(posedge clk) begin
    if (we) begin
      dm[addr] <= din;
    end
  end

  assign dout = dm[addr];

endmodule
