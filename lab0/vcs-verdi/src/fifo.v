module fifo(clk,rst_n,w_en,data_w,r_en,data_r,full,empty,half_full,overflow);
    input   clk;
    input   rst_n;
    input   w_en;
    input   r_en;
    input   [7:0] data_w;
    
    output   full;
    output   empty;
    output   half_full;
    output   overflow;
    output   [7:0]   data_r;
    
    reg  [4:0] wr_ptr;
    reg  [4:0] rd_ptr;
    reg        overflow;
    reg   [7:0]   data_r;
    wire  [7:0]   data_in;

    reg [7:0] fifo_mem [0:15];

always @(posedge clk)
    if(w_en&&(!full))
       fifo_mem[wr_ptr[3:0]]<=data_w;
    else
       fifo_mem[wr_ptr[3:0]]<=fifo_mem[wr_ptr[3:0]];
   

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       data_r<=8'b0;
    else 
       data_r<=fifo_mem[rd_ptr[3:0]];

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       wr_ptr<=5'b0;
    else if(w_en&&(!full))
       wr_ptr<=wr_ptr+1'b1;
   
always @(posedge clk or negedge rst_n)
    if(!rst_n)
       rd_ptr<=5'b0;
    else if(r_en&&(!empty))
       rd_ptr<=rd_ptr+1'b1;

assign  full = (rd_ptr[4:0]-wr_ptr[4:0]==5'b10000) || (wr_ptr[4:0]-rd_ptr[4:0]==5'b10000) ;
assign  empty = (rd_ptr[4:0]==wr_ptr[4:0]);
assign  half_full = (wr_ptr[4:0]==rd_ptr[4:0]+4'b1000);

always @(posedge clk or negedge rst_n)
    if(!rst_n)
       overflow <= 1'b0;
    else if(w_en && full)
       overflow <= full;
    else  
       overflow <= 1'b0;

endmodule 



