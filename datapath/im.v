/*
  IM := Instructions Memory
*/


module im_4k (
    addr,
    dout
);

  input [11:2] addr;  // address bus
  output [31:0] dout;  // 32-bit memory output

  reg [31:0] im[1023:0];  // 32-bit * 1024-word


  initial begin
    $readmemh("im_4k.mem", im);
  end

  assign dout = im[addr];

endmodule
