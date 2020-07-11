// ==============================================================
// PE33
// ==============================================================

module pe33 #(parameter M_WIDTH=8, O_WIDTH=20)
         (input  [M_WIDTH-1:0] in000,
          input  [M_WIDTH-1:0] in001,
          input  [M_WIDTH-1:0] in002,
          input  [M_WIDTH-1:0] in010,
          input  [M_WIDTH-1:0] in011,
          input  [M_WIDTH-1:0] in012,
          input  [M_WIDTH-1:0] in020,
          input  [M_WIDTH-1:0] in021,
          input  [M_WIDTH-1:0] in022,
          input  [M_WIDTH-1:0] in100,
          input  [M_WIDTH-1:0] in101,
          input  [M_WIDTH-1:0] in102,
          input  [M_WIDTH-1:0] in110,
          input  [M_WIDTH-1:0] in111,
          input  [M_WIDTH-1:0] in112,
          input  [M_WIDTH-1:0] in120,
          input  [M_WIDTH-1:0] in121,
          input  [M_WIDTH-1:0] in122,
          output [O_WIDTH-1:0] out);

wire [M_WIDTH * 2 + 1 : 0]    out0;
wire [M_WIDTH * 2 + 1 : 0]    out1;
wire [M_WIDTH * 2 + 1 : 0]    out2;

wire [M_WIDTH * 2 + 3 : 0]    out_t;

pe3 #(.M_WIDTH(M_WIDTH), 
      .A_WIDTH(16), 
      .O_WIDTH(18))
     pe30(.in00(in000),
          .in01(in100),
          .in10(in001),
          .in11(in101),
          .in20(in002),
          .in21(in102),
          .out(out0));

pe3 #(.M_WIDTH(M_WIDTH), 
      .A_WIDTH(16), 
      .O_WIDTH(18))
     pe31(.in00(in010),
          .in01(in110),
          .in10(in011),
          .in11(in111),
          .in20(in012),
          .in21(in112),
          .out(out1));

pe3 #(.M_WIDTH(M_WIDTH), 
      .A_WIDTH(16), 
      .O_WIDTH(18))
     pe32(.in00(in020),
          .in01(in120),
          .in10(in021),
          .in11(in121),
          .in20(in022),
          .in21(in122),
          .out(out2));

assign out_t = out0 + out1;
assign out   = out_t + out2;

endmodule