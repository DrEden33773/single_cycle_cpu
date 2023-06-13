/*

RegFile := Register File

*/


module reg_file (
    clk,  // clock
    rst,  // reset
    wEn,  // write enable
    Rw,  // register write address
    Ra,  // register read address (A)
    Rb,  // register read address B
    busW,  // write data bus
    busA,  // read data bus (A)
    busB  // read data bus (B)
);

  input clk;  // clock
  input rst;  // reset
  input wEn;  // write enable
  input [4:0] Rw;  // register write address
  input [4:0] Ra;  // register read address (A)
  input [4:0] Rb;  // register read address (B)
  input [31:0] busW;  // write data bus
  output [31:0] busA;  // read data bus (A)
  output [31:0] busB;  // read data bus (B)

  reg [31:0] reges[31:0];  // 32 * 32-bit registers
  integer i = 0;  // loop counter

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        reges[i] <= 0;
      end
    end else if (wEn) begin
      reges[Rw] <= busW;
    end
  end

  assign busA = reges[Ra];
  assign busB = reges[Rb];

endmodule
