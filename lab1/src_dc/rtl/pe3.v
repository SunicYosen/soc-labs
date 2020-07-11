// ==============================================================
// PE3
// ==============================================================

module pe3 #(parameter M_WIDTH=8, A_WIDTH=16, O_WIDTH=18)
        (input  [M_WIDTH-1:0] in00,
         input  [M_WIDTH-1:0] in01,
         input  [M_WIDTH-1:0] in10,
         input  [M_WIDTH-1:0] in11,
         input  [M_WIDTH-1:0] in20,
         input  [M_WIDTH-1:0] in21,
         output [O_WIDTH-1:0] out);

wire [M_WIDTH * 2 -1 : 0]        out0;
wire [M_WIDTH * 2 : 0]        out1;
wire [M_WIDTH * 2 + 1 : 0]        out2;

assign out = out2;

mac #(.M_WIDTH(M_WIDTH),
      .A_WIDTH(A_WIDTH),
      .O_WIDTH(A_WIDTH))
    mac0(.in0(in00),
         .in1(in01),
         .inc(16'h0000),
         .out(out0));

mac #(.M_WIDTH(M_WIDTH),
      .A_WIDTH(A_WIDTH),
      .O_WIDTH(A_WIDTH+1))
    mac1(.in0(in10),
         .in1(in11),
         .inc(out0),
         .out(out1));

mac #(.M_WIDTH(M_WIDTH),
      .A_WIDTH(A_WIDTH+1),
      .O_WIDTH(O_WIDTH))
    mac2(.in0(in20),
         .in1(in21),
         .inc(out1),
         .out(out2));

endmodule