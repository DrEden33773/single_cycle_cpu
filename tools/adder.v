/// adder
///
/// in  := {A, B, Ci}
/// out := {Sum, Co}


module adder (
    A,
    B,
    Ci,
    Sum,
    Co
);

  input [31:0] A;
  input [31:0] B;
  input Ci;
  output [31:0] Sum;
  output Co;

  assign {Sum, Co} = A + B + Ci;

endmodule
