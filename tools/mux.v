/// mux.v
///
/// With all needed `m_select_n_mux`


/* 2_select_1_mux = mux2_1 */
module mux2_1 (
    input [31:0] zero,  /* `0` */
    input [31:0] one,  /* `1` */
    input sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      1'b0: out = zero;
      1'b1: out = one;
    endcase
  end

endmodule

/* 4_select_1_mux = mux4_1 */
module mux4_1 (
    input [31:0] zero,  /* `0` */
    input [31:0] one,  /* `1` */
    input [31:0] two,  /* `2` */
    input [31:0] three,  /* `3` */
    input [1:0] sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      2'b00:   out = zero;
      2'b01:   out = one;
      2'b10:   out = two;
      2'b11:   out = three;
    endcase
  end

endmodule

/* 3_select_1_mux = mux3_1 (inherit from `mux4_1`) */
module mux3_1 (
    input [31:0] zero,  /* `0` */
    input [31:0] one,  /* `1` */
    input [31:0] two,  /* `2` */
    input [1:0] sel,
    output reg [31:0] out
);

  always @(*) begin
    case (sel)
      default: out = 0;
      2'b00:   out = zero;
      2'b01:   out = one;
      2'b10:   out = two;
    endcase
  end

endmodule

module mux_RegDst (
    input [4:0] rt,  /* `0` */
    input [4:0] rd,  /* `1` */
    input RegDst,
    output reg [4:0] rt_rd
);

  always @(*) begin
    case (RegDst)
      default: rt_rd = 0;
      1'b0: rt_rd = rt;
      1'b1: rt_rd = rd;
    endcase
  end

endmodule

module mux_RtRd_Rw_IfLinked (
    input [4:0] rt_rd,  /* `0` */
    input Link,
    output reg [4:0] rw
);

  always @(*) begin
    case (Link)
      default: rw = 0;
      1'b0: rw = rt_rd;
      1'b1: rw = 5'b11111;
    endcase
  end

endmodule  //mux
