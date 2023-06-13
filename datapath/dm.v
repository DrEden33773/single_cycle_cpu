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

  input clk;  // clock
  input we;  // memory write enable
  input [11:2] addr;  // address bus
  input [31:0] din;  // 32-bit input data
  output [31:0] dout;  // 32-bit memory output 

  reg [31:0] dm[1023:0];

  always @(posedge clk) begin
    if (we) begin
      dm[addr] <= din;
    end
  end

  assign dout = dm[addr];

endmodule
