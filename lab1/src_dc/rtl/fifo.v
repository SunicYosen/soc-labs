module fifo #(parameter LOG_DEEPTH=10, D_WIDTH=32)
           (clk,
            rst_n,
            w_en,
            data_w,
            r_en,
            data_r,
            full,
            empty,
            half_full,
            overflow,
            o_valid);

    input                clk;
    input                rst_n;
    input                w_en;
    input                r_en;
    input  [D_WIDTH-1:0] data_w;
    
    output               full;
    output               empty;
    output               half_full;
    output               overflow;
    output               o_valid;
    output [D_WIDTH-1:0] data_r;

    reg   [LOG_DEEPTH : 0]  wr_ptr;
    reg   [LOG_DEEPTH : 0]  rd_ptr;
    reg                     overflow;
    reg                     o_valid;
    reg   [D_WIDTH-1:0]     data_r;
    wire  [D_WIDTH-1:0]     data_in;

    reg [D_WIDTH-1 : 0] fifo_mem [0 : (1<<LOG_DEEPTH)-1];

always @(posedge clk or negedge rst_n)
    if (!rst_n)
       fifo_mem[wr_ptr[LOG_DEEPTH-1 : 0]] <= {D_WIDTH{1'b0}};
    else if(w_en && (!full))
       fifo_mem[wr_ptr[LOG_DEEPTH-1 : 0]] <= data_w;
    else
       fifo_mem[wr_ptr[LOG_DEEPTH-1 : 0]] <= fifo_mem[wr_ptr[LOG_DEEPTH-1 : 0]];
   

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       data_r <= 32'b0;
    else if (r_en && (!empty))
       data_r <= fifo_mem[rd_ptr[LOG_DEEPTH-1 : 0]];
    else
       data_r <= data_r;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       wr_ptr <= {(LOG_DEEPTH+1){1'b0}};
    else if(w_en && (!full))
       wr_ptr <= wr_ptr + 1'b1;
   
always @(posedge clk or negedge rst_n)
    if(!rst_n)
       rd_ptr <= {(LOG_DEEPTH+1){1'b0}};
    else if(r_en && (!empty))
       rd_ptr <= rd_ptr + 1'b1;

assign  full      = (rd_ptr[LOG_DEEPTH : 0] -  wr_ptr[LOG_DEEPTH : 0] == {1'b1, {LOG_DEEPTH{1'b0}}}) || (wr_ptr[LOG_DEEPTH:0] - rd_ptr[LOG_DEEPTH : 0] == {1'b1, {LOG_DEEPTH{1'b0}}});
assign  empty     = (rd_ptr[LOG_DEEPTH : 0] == wr_ptr[LOG_DEEPTH : 0]);
assign  half_full = (wr_ptr[LOG_DEEPTH : 0] == rd_ptr[LOG_DEEPTH : 0] + {1'b1, {(LOG_DEEPTH-1){1'b0}}});

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       overflow <= 1'b0;
    else if(w_en && full)
       overflow <= full;
    else  
       overflow <= 1'b0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        o_valid <= 1'b0;
    else if (r_en && (!empty))
       o_valid <= 1'b1;
    else
       o_valid <= 1'b0;
    

endmodule
