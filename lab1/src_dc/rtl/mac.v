// ==============================================================
// Mac
// ==============================================================

`timescale 1 ns / 1 ps

module mac #(parameter M_WIDTH=8, A_WIDTH=16, O_WIDTH=17)
        (input  [M_WIDTH-1:0] in0,
         input  [M_WIDTH-1:0] in1,
         input  [A_WIDTH-1:0] inc,
         output [O_WIDTH-1:0] out);

wire signed [M_WIDTH - 1:0]   in0s;
wire signed [M_WIDTH - 1:0]   in1s;
wire signed [A_WIDTH - 1:0]   incs;
wire signed [A_WIDTH - 1:0]   muls;
wire signed [O_WIDTH - 1:0]   adds;

assign in0s = $signed(in0);
assign in1s = $signed(in1);
assign incs = $signed(inc);

assign muls = in0s * in1s;
assign adds = muls + incs;

assign out  = adds;

endmodule
