/// mux.v
///
/// With all needed `m_select_n_mux`


/* 2_select_1_mux = mux2_1 */
module mux2_1 (
    input [31:0] a,  /* `0` */
    input [31:0] b,  /* `1` */
    input sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      1'b0: out = a;
      1'b1: out = b;
    endcase
  end

endmodule

/* 4_select_1_mux = mux4_1 */
module mux4_1 (
    input [31:0] a,  /* `0` */
    input [31:0] b,  /* `1` */
    input [31:0] c,  /* `2` */
    input [31:0] d,  /* `3` */
    input [1:0] sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      2'b00:   out = a;
      2'b01:   out = b;
      2'b10:   out = c;
      2'b11:   out = d;
    endcase
  end

endmodule

/* 3_select_1_mux = mux3_1 (inherit from `mux4_1`) */
module mux3_1 (
    input [31:0] a,  /* `0` */
    input [31:0] b,  /* `1` */
    input [31:0] c,  /* `2` */
    input [1:0] sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      2'b00:   out = a;
      2'b01:   out = b;
      2'b10:   out = c;
    endcase
  end

endmodule

module mux_RegDst (
    input [4:0] rt,  /* `0` */
    input [4:0] rd,  /* `1` */
    input RegDst,
    output reg [4:0] rw
);

  always @(*) begin
    case (RegDst)
      default: rw = 0;
      1'b0: rw = rt;
      1'b1: rw = rd;
    endcase
  end

endmodule
