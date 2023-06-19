/*
  Mips := Top Level Mips CPU Emulator
*/


`include "control/ctrl.v"
`include "datapath/fetcher/fetcher.v"
`include "datapath/splitter.v"
`include "datapath/alu.v"
`include "datapath/dm.v"
`include "datapath/ext.v"
`include "datapath/im.v"
`include "datapath/reg_file.v"
`include "tools/mux.v"
`include "tools/adder.v"
`include "tools/logic_expr.v"

module mips (
    input clk,  // clock
    input rst   // reset
);

endmodule
