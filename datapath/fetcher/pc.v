/*
  PC := Program Counter (Only deliver current `PC`)
*/


module pc (
    input clk,
    input rst,
    input [31:0] PC,
    output [31:0] CurrPC
);

  reg [31:0] CurrPCReg;

  always @(posedge clk) begin
    if (rst) begin
      CurrPCReg <= 0;
    end else begin
      CurrPCReg <= PC;
    end
  end

  assign CurrPC = CurrPCReg;

endmodule
