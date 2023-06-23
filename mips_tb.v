module mips_tb;

  // Parameters

  // Ports
  reg clk = 0;
  reg rst = 0;

  mips MIPS_CPU (
      .clk(clk),
      .rst(rst)
  );

  initial begin
    begin
      $finish;
    end
  end

  always #5 clk = !clk;

endmodule
