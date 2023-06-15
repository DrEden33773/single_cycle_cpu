/*
  PC := Program Counter
*/


module pc (
    clk,
    rst,
    pc,
    npc
);

  /* clock */
  input clk;
  /* reset */
  input rst;
  /* 32-bit PC */
  input [31:0] pc;
  /* 32-bit next_PC */
  output [31:0] npc;

  /* 32-bit next_PC register */
  reg [31:0] npc_reg;

  always @(posedge clk) begin
    if (rst) begin
      npc_reg <= 0;
    end else begin
      npc_reg <= pc + 4;
    end
  end

  assign npc = npc_reg;

endmodule
