// ==============================================================
// Convolution
// ==============================================================

module conv #(parameter I_WIDTH = 8, O_WIDTH = 8, ADDR_W = 14)
       (input                  clk,
        input                  rst_n,
        input                  i_valid,
        input  [71:0]          i_tensor,
        input  [71:0]          w_tensor,
//        input  [ADDR_W-1   :0] o_addr,
//        output [ADDR_W-1   :0] o_addr_o,
        output [O_WIDTH-1  :0] o_tensor,
        output                 o_valid);

reg [7:0] i00;
reg [7:0] i01;
reg [7:0] i02;
reg [7:0] i10;
reg [7:0] i11;
reg [7:0] i12;
reg [7:0] i20;
reg [7:0] i21;
reg [7:0] i22;

reg [7:0] w00;
reg [7:0] w01;
reg [7:0] w02;
reg [7:0] w10;
reg [7:0] w11;
reg [7:0] w12;
reg [7:0] w20;
reg [7:0] w21;
reg [7:0] w22;

// reg [ADDR_W-1 :0] o_addr_temp;
// reg [ADDR_W-1 :0] o_addr_o_temp;
reg               i_valid_temp;
reg [O_WIDTH-1:0] o_tensor_reg;
reg               o_valid_reg;

wire [19:0] pe_out;
wire [11:0] pe_out_shift;
wire [8:0]  pe_clip;
wire [O_WIDTH-1:0] o_tensor_act;

assign o_tensor = o_tensor_act;
assign o_valid  = o_valid_reg;
// assign o_addr_o = o_addr_o_temp;

// Input Reg
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
            i00 <= 0;
            i01 <= 0;
            i02 <= 0;
            i10 <= 0;
            i11 <= 0;
            i12 <= 0;
            i20 <= 0;
            i21 <= 0;
            i22 <= 0;
        end
    else if(i_valid)
        begin
            i00 <= i_tensor[7 :0];
            i01 <= i_tensor[15:8];
            i02 <= i_tensor[23:16];
            i10 <= i_tensor[31:24];
            i11 <= i_tensor[39:32];
            i12 <= i_tensor[47:40];
            i20 <= i_tensor[55:48];
            i21 <= i_tensor[63:56];
            i22 <= i_tensor[71:64];
        end
    else 
        begin
            i00 <= 0;
            i01 <= 0;
            i02 <= 0;
            i10 <= 0;
            i11 <= 0;
            i12 <= 0;
            i20 <= 0;
            i21 <= 0;
            i22 <= 0;
        end
end

// Weight Reg
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
            w00 <= 0;
            w01 <= 0;
            w02 <= 0;
            w10 <= 0;
            w11 <= 0;
            w12 <= 0;
            w20 <= 0;
            w21 <= 0;
            w22 <= 0;
        end
    else if(i_valid)
        begin
            w00 <= w_tensor[7 :0];
            w01 <= w_tensor[15:8];
            w02 <= w_tensor[23:16];
            w10 <= w_tensor[31:24];
            w11 <= w_tensor[39:32];
            w12 <= w_tensor[47:40];
            w20 <= w_tensor[55:48];
            w21 <= w_tensor[63:56];
            w22 <= w_tensor[71:64];
        end
    else
        begin
            w00 <= 0;
            w01 <= 0;
            w02 <= 0;
            w10 <= 0;
            w11 <= 0;
            w12 <= 0;
            w20 <= 0;
            w21 <= 0;
            w22 <= 0;
        end
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        i_valid_temp <= 1'b0;
    else if(i_valid)
        i_valid_temp <= 1'b1;
    else
        i_valid_temp <= 1'b0;
end

// always @(posedge clk)
// begin
//     if(!rst_n)
//         o_addr_temp <= 0;
//     else
//         o_addr_temp <= o_addr;
// end
// 
// always @(posedge clk)
// begin
//     if(!rst_n)
//         o_addr_o <= 0;
//     else 
//         o_addr_o <= o_addr_temp;
// end

assign pe_out_shift = pe_out[19:8];
assign pe_clip = pe_out_shift[11] ? 8'b0000_0000 : ((pe_out_shift[11:8] != 4'b0000) ? 8'b0111_1111 : pe_out_shift[7:0]);

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        o_tensor_reg <= 0;
    else if(i_valid_temp)
        o_tensor_reg <= pe_clip;
    else 
        o_tensor_reg <= o_tensor_reg;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        o_valid_reg <= 0;
    else if (i_valid_temp)
        o_valid_reg <= 1'b1;
    else 
        o_valid_reg <= 1'b0;
end

pe33 #(.M_WIDTH(I_WIDTH), .O_WIDTH(20))
    pe(.in000(i00),
       .in001(i01),
       .in002(i02),
       .in010(i10),
       .in011(i11),
       .in012(i12),
       .in020(i20),
       .in021(i21),
       .in022(i22),
       .in100(w00),
       .in101(w01),
       .in102(w02),
       .in110(w10),
       .in111(w11),
       .in112(w12),
       .in120(w20),
       .in121(w21),
       .in122(w22),
       .out(pe_out));

relu #(.I_WIDTH(I_WIDTH), .O_WIDTH(O_WIDTH))
    relu_act(.in(o_tensor_reg),
             .out(o_tensor_act));

endmodule

