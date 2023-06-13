/// mux.v
///
/// With all needed `m_select_n_mux`


/* 2_select_1_mux = mux2_1 */
module mux2_1 (
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] out
);

  assign out = sel ? b : a;

endmodule

/* 4_select_1_mux = mux4_1 (inherit from `mux2_1`) */
module mux4_1 (
    input  [31:0] a,
    input  [31:0] b,
    input  [31:0] c,
    input  [31:0] d,
    input  [ 1:0] sel,
    output [31:0] out
);

  wire [31:0] mux1_out;
  wire [31:0] mux2_out;

  mux2_1 mux1 (
      .a  (a),
      .b  (b),
      .sel(sel[0]),
      .out(mux1_out)
  );

  mux2_1 mux2 (
      .a  (c),
      .b  (d),
      .sel(sel[0]),
      .out(mux2_out)
  );

  mux2_1 mux3 (
      .a  (mux1_out),
      .b  (mux2_out),
      .sel(sel[1]),
      .out(out)
  );

endmodule

/* 3_select_1_mux = mux3_1 (inherit from `mux4_1`) */
module mux3_1 (
    input  [31:0] a,
    input  [31:0] b,
    input  [31:0] c,
    input  [ 1:0] sel,
    output [31:0] out
);

  mux4_1 mux (
      .a  (a),
      .b  (b),
      .c  (c),
      .d  (32'b0),
      .sel(sel),
      .out(out)
  );

endmodule
