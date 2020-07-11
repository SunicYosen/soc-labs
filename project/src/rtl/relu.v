// ==============================================================
// RELU
// ==============================================================

module relu #(parameter I_WIDTH = 8, O_WIDTH = 8)
             (input  [I_WIDTH-1:0] in,
              output [O_WIDTH-1:0] out);

assign out = in[I_WIDTH-1] ? 0 : in;

endmodule
