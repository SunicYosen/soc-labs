// ==============================================================
// CNN acc top with icb
// ==============================================================
module cnn_acc(
  input   clk,
  input   rst_n,

  input                      i_icb_cmd_valid,
  output                     i_icb_cmd_ready,
  input  [32-1:0]            i_icb_cmd_addr,
  input                      i_icb_cmd_read,
  input  [32-1:0]            i_icb_cmd_wdata,
  
  output                     i_icb_rsp_valid,
  input                      i_icb_rsp_ready,
  output [32-1:0]            i_icb_rsp_rdata);

// ===============================
// Address Define
// ===============================
parameter INPUT_FIFO_ADDR  = 8'h00;
parameter WEIGHT_FIFO_ADDR = 8'h04;
parameter OUTPUT_FIFO_ADDR = 8'h08;
parameter START_CONFIG     = 8'h0c;
parameter FINISH_STATUS    = 8'h10;

// Assign Output
wire    out_cmd_ready;
assign  i_icb_cmd_ready = out_cmd_ready;
wire    out_rsp_valid;
assign  i_icb_rsp_valid = out_rsp_valid;
wire    [32-1:0]  out_rsp_rdata;
assign  i_icb_rsp_rdata = out_rsp_rdata;

// Deal input
wire    in_cmd_valid;
assign  in_cmd_valid = i_icb_cmd_valid;
wire    [32-1:0]  in_cmd_addr;
assign  in_cmd_addr  = i_icb_cmd_addr;
wire    read_en, write_en;
assign  read_en      = i_icb_cmd_read ? 1'b1 : 1'b0;
assign  write_en     = i_icb_cmd_read ? 1'b0 : 1'b1;
wire    [32-1:0]  in_cmd_wdata;
assign  in_cmd_wdata  = i_icb_cmd_wdata;
wire    in_rsp_ready;
assign  in_rsp_ready = i_icb_rsp_ready;

wire          w_en_i;
wire [32-1:0] in_data_i;
wire          r_en_i;
wire [32-1:0] out_data_i;
wire          empty_i;
wire          full_i;
wire          half_full_i;
wire          overflow_i;
wire          o_valid_i;

wire          w_en_w;
wire [32-1:0] in_data_w ;
wire          r_en_w;
wire [32-1:0] out_data_w;
wire          empty_w;
wire          full_w;
wire          half_full_w;
wire          overflow_w;
wire          o_valid_w;

wire          w_en_o;
wire [32-1:0] in_data_o;
wire          r_en_o;
wire [32-1:0] out_data_o;
wire          empty_o;
wire          full_o;
wire          half_full_o;
wire          overflow_o;
wire          o_valid_o;

wire          start_c;
wire [32-1:0] i_data_c;
wire          i_valid_c;
wire          d_type_c;
wire [32-1:0] o_data_c;
wire          o_valid_c;
wire          finish;

reg           read_en_reg;
reg [32-1:0]  in_cmd_addr_reg;
reg           finish_reg;

wire [32-1:0] output_data;
wire [32-1:0] finish_signal;

// ICB Signal
assign out_cmd_ready = 1'b1;
assign out_rsp_valid = ((read_en_reg) ? 1'b1 : 1'b0) | (write_en & in_cmd_valid);
assign out_rsp_rdata = (read_en_reg) ? ((in_cmd_addr_reg[7:0] == OUTPUT_FIFO_ADDR) ? output_data 
                                     : ((in_cmd_addr_reg[7:0] == FINISH_STATUS)    ? finish_signal : 32'h0000_0001)) : 32'h0000_0000;

// Input FIFO control
assign w_en_i    = ~full_i & write_en & in_cmd_valid & (in_cmd_addr[7:0] == INPUT_FIFO_ADDR);
assign in_data_i = w_en_i ? in_cmd_wdata : 32'h0000_0000;
assign r_en_i    = r_en_w ? 0 : (~empty_i);
// Weight FIFO control
assign w_en_w    = ~full_w & write_en & in_cmd_valid & (in_cmd_addr[7:0] == WEIGHT_FIFO_ADDR);
assign in_data_w = w_en_w ? in_cmd_wdata : 32'h0000_0000;
assign r_en_w    = ~empty_w;
// Output FIFO control
assign w_en_o    = ~full_o & o_valid_c;
assign in_data_o = w_en_o ? o_data_c : 32'h0000_0000;
assign r_en_o    = ~empty_o & read_en & (in_cmd_addr[7:0] == OUTPUT_FIFO_ADDR);
// Output Data
assign output_data   = (read_en_reg & o_valid_o & (in_cmd_addr_reg[7:0] == OUTPUT_FIFO_ADDR)) ? out_data_o : 32'h0000_0000;
assign finish_signal = (read_en_reg & finish_reg & (in_cmd_addr_reg[7:0] == FINISH_STATUS)) ? FINISH_STATUS : 32'h0000_0000;

// Compute
assign start_c   = 1'b1;  // Always Start
assign i_data_c  = o_valid_w ? out_data_w : (o_valid_i ? out_data_i : 32'h0000_0000);
assign i_valid_c = o_valid_w | o_valid_i;
assign d_type_c  = o_valid_w ? 1'b1 : (o_valid_i ? 1'b0 : 1'b1);

// Read for one clock delay
always @(posedge clk or negedge rst_n)
if(!rst_n)
	read_en_reg <= 1'b0;
else
	read_en_reg <= read_en;

always @(posedge clk or negedge rst_n)
if(!rst_n)
	in_cmd_addr_reg <= 32'h0000_0000;
else
	in_cmd_addr_reg <= in_cmd_addr;

// Keep Finish
always @(posedge clk or negedge rst_n)
if(!rst_n)
	finish_reg <= 1'b0;
else if(finish)
	finish_reg <= 1'b1;
else
	finish_reg <= finish_reg;

// ===============================
// FIFO
// ===============================
parameter I_LOG_DEEPTH = 2;
parameter W_LOG_DEEPTH = 2;
parameter O_LOG_DEEPTH = 5;
parameter D_WIDTH      = 32;
// Input FIFO
fifo #(.LOG_DEEPTH(I_LOG_DEEPTH), .D_WIDTH(D_WIDTH))
	fifo_i(.clk(clk),
		     .rst_n(rst_n),
		     .w_en(w_en_i),
		     .data_w(in_data_i),
		     .r_en(r_en_i),
		     .data_r(out_data_i),
		     .empty(empty_i),
		     .full(full_i),
		     .half_full(half_full_i),
		     .overflow(overflow_i),
		     .o_valid(o_valid_i));
// Weight FIFO
fifo #(.LOG_DEEPTH(W_LOG_DEEPTH), .D_WIDTH(D_WIDTH))
	fifo_w(.clk(clk),
		     .rst_n(rst_n),
		     .w_en(w_en_w),
		     .data_w(in_data_w),
		     .r_en(r_en_w),
		     .data_r(out_data_w),
		     .empty(empty_w),
		     .full(full_w),
		     .half_full(half_full_w),
		     .overflow(overflow_w),
		     .o_valid(o_valid_w));

// Output FIFO
fifo #(.LOG_DEEPTH(O_LOG_DEEPTH), .D_WIDTH(D_WIDTH))
	fifo_o(.clk(clk),
		     .rst_n(rst_n),
		     .w_en(w_en_o),
		     .data_w(in_data_o),
		     .r_en(r_en_o),
		     .data_r(out_data_o),
		     .empty(empty_o),
		     .full(full_o),
		     .half_full(half_full_o),
		     .overflow(overflow_o),
		     .o_valid(o_valid_o));

// ===============================
// Conv Acc TOP
// ===============================
parameter I_WIDTH=8;
parameter O_WIDTH=8;
conv_top #(.I_WIDTH(I_WIDTH), .O_WIDTH(O_WIDTH))
    conv_top1(.clk(clk),
              .rst_n(rst_n),
              .start(start_c),
              .i_data(i_data_c),
              .i_valid(i_valid_c),
              .d_type(d_type_c),
              .o_data(o_data_c),
              .o_valid(o_valid_c),
              .finish(finish));
endmodule
