/*
  IM := Instructions Memory
*/


module im_4k (
    addr,
    dout
);

  /* address bus */
  input [11:2] addr;
  /* 32-bit memory output */
  output [31:0] dout;

  /* 1024 * 32-bit instructions memory */
  reg [31:0] im[1023:0];

  // load all instructions
  initial begin
    $readmemh("../code.txt", im);
  end

  // pick the instruction at `addr`
  assign dout = im[addr[11:2]];

endmodule
