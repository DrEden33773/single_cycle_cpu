/*

NPC => NextPC Calculator

*/


module npc (
    clk,
    rst,
    pc,
    npc
);

  input clk;  // clock
  input rst;  // reset
  input [31:0] pc;  // 32-bit PC
  output [31:0] npc;  // 32-bit next PC

  reg [31:0] npc_reg;  // 32-bit next PC register

  always @(posedge clk) begin
    if (rst) begin
      npc_reg <= 0;
    end else begin
      npc_reg <= pc + 4;
    end
  end

  assign npc = npc_reg;

endmodule
