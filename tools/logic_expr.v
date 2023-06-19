/*
  Logic Expr := Modulated Logic Expression
*/


module and_6 (
    input [5:0] in,
    output out
);

  assign out = in[5] & in[4] & in[3] & in[2] & in[1] & in[0];

endmodule


module nand_6 (
    input [5:0] in,
    output out
);

  assign out = ~(in[5] & in[4] & in[3] & in[2] & in[1] & in[0]);

endmodule


module or_6 (
    input [5:0] in,
    output out
);

  assign out = in[5] | in[4] | in[3] | in[2] | in[1] | in[0];

endmodule


module nor_6 (
    input [5:0] in,
    output out
);

  assign out = ~(in[5] | in[4] | in[3] | in[2] | in[1] | in[0]);

endmodule
