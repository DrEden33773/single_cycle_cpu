/*
  IM := Instructions Memory
*/


module im_4k (
    addr,
    dout
);

  /* address bus */
  input [11:2] addr;  // address bus
  /* 32-bit memory output */
  output [31:0] dout;  // 32-bit memory output

  /* instructions memory */
  reg [31:0] im[1023:0];

  // load all instructions
  initial begin
    $readmemh("../code.txt", im);
  end

  // pick the instruction at `addr`
  assign dout = im[addr];

endmodule
