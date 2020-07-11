// ==============================================================
// Conv TOP
// ==============================================================

module conv_top #(parameter I_WIDTH=8, O_WIDTH=8)
       (input          clk,
        input          rst_n,
        input          start,
        input  [31:0]  i_data,
        input          i_valid,
        input          d_type, // 0 for Input or 1 for Weight
        output [31:0]  o_data,
        output         o_valid,
        output         finish);

reg [7:0] mem_input [0: 9];
reg [7:0] mem_weight[0: 143];
reg [7:0] mem_output[0: 3];

reg [10:0] i_addr;
reg [7:0]  w_addr;

reg [3:0] status_flag;
reg       finish_reg;

wire load_end_flag;
wire compute_end_flag;

// ===============================
// Status
// ===============================
parameter LOAD    = 4'b0001;
parameter COMPUTE = 4'b0010;
parameter STORE   = 4'b0100;
parameter IDLE    = 4'b1000;

assign load_end_flag = ((i_addr == 11'd1156) & (w_addr == 8'd144));
assign finish        = finish_reg;

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                status_flag <= IDLE;
        else if(status_flag == IDLE & start)
                status_flag <= LOAD;
        else if(status_flag == LOAD & load_end_flag)
                status_flag <= COMPUTE;
        else
                status_flag <= status_flag;
end

// ===============================
// Get Data
// ===============================

// Input buffer address
always@(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                i_addr <= 11'h000;
        else if (finish)
                i_addr <= 11'h000;
        else if(i_valid & (d_type == 0) & (status_flag == LOAD))
                i_addr <= i_addr + 4'b0100;
end

// Weight buffer address
always@(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                w_addr <= 8'h00;
        else if (finish)
                w_addr <=  8'h00;
        else if(i_valid & (d_type == 1) & (status_flag == LOAD))
                w_addr <= w_addr + 4'b0100;
end

// Write Data to input buffer
always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
        begin
                mem_input[i_addr + 0] <= 8'h00;
                mem_input[i_addr + 1] <= 8'h00;
                mem_input[i_addr + 2] <= 8'h00;
                mem_input[i_addr + 3] <= 8'h00;
        end
        else if(i_valid & (d_type == 0) & (status_flag == LOAD))
        begin
                mem_input[i_addr + 0] <= i_data[7:0];
                mem_input[i_addr + 1] <= i_data[15:8];
                mem_input[i_addr + 2] <= i_data[23:16];
                mem_input[i_addr + 3] <= i_data[31:24];
        end
end

// Write Data to weight buffer
always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
        begin
                mem_weight[w_addr + 0] <= 8'h00;
                mem_weight[w_addr + 1] <= 8'h00;
                mem_weight[w_addr + 2] <= 8'h00;
                mem_weight[w_addr + 3] <= 8'h00;
        end
        else if(i_valid & (d_type == 1) & (status_flag == LOAD))
        begin
                mem_weight[w_addr + 0] <= i_data[7:0];
                mem_weight[w_addr + 1] <= i_data[15:8];
                mem_weight[w_addr + 2] <= i_data[23:16];
                mem_weight[w_addr + 3] <= i_data[31:24];
        end
end

// ===============================
// Compute
// ===============================
reg  [9:0]  com_o_addr;
reg  [7:0]  com_w_addr;
wire [10:0] com_i_addr;
reg  [1:0]  tmp_o_addr;
reg  [1:0]  last_tmp_o_addr;
wire        conv_o_valid;
reg         com_i_valid;

reg [71:0]  i_tensor;
reg [71:0]  w_tensor;
wire [7:0]  o_tensor;
reg [31:0]  o_data_tmp;
reg         o_valid_tmp;

assign com_i_addr = com_o_addr[9:5] * 34 + com_o_addr[4:0];

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                com_o_addr <= 10'b00_0000_0000;
        //else if(status_flag == COMPUTE & (com_w_addr == 8'b1000_0111) & (com_o_addr == 10'b11_1111_1111))
        //        com_o_addr <= 10'b00_0000_0000;
        else if(status_flag == COMPUTE & (com_w_addr == 8'b1000_0111))
                com_o_addr <= com_o_addr + 1'b1;
        else
                com_o_addr <= com_o_addr;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                last_tmp_o_addr <= 2'b00;
        else
                last_tmp_o_addr <= tmp_o_addr;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                o_data_tmp <= 32'h0000_0000;
        else if((last_tmp_o_addr == 2'b11) & (conv_o_valid == 1))
                o_data_tmp <= {mem_output[3], mem_output[2], mem_output[1], mem_output[0]};
        else
                o_data_tmp <= o_data_tmp;
end


always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                o_valid_tmp <= 1'b0;
        else if((last_tmp_o_addr == 2'b11) & (conv_o_valid == 1))
                o_valid_tmp <= 1'b1;
        else
                o_valid_tmp <= 1'b0;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                com_w_addr <= 8'b0000_0000;
        else if(status_flag == COMPUTE & (com_w_addr == 8'b1000_0111))
                com_w_addr <= 8'b0000_0000;
        else if(status_flag == COMPUTE)
                com_w_addr <= com_w_addr + 8'b0000_1001;
        else 
                com_w_addr <= com_w_addr;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                tmp_o_addr <= 2'b00;
        else if(conv_o_valid)
                tmp_o_addr <= tmp_o_addr + 1'b1;
        else
                tmp_o_addr <= tmp_o_addr;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                mem_output[tmp_o_addr] <= 8'b0000_0000;
        else if (conv_o_valid)
                mem_output[tmp_o_addr] <= o_tensor;
        else 
                mem_output[tmp_o_addr] <= mem_output[tmp_o_addr];
end

// ===============================
// Get Next compute data
// ===============================

assign o_data  = o_data_tmp;
assign o_valid = o_valid_tmp;

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                i_tensor <= 72'h00_0000_0000_0000_0000;
        else if (status_flag == COMPUTE)
                i_tensor <= {mem_input[com_i_addr+70], 
                             mem_input[com_i_addr+69], 
                             mem_input[com_i_addr+68], 
                             mem_input[com_i_addr+36], 
                             mem_input[com_i_addr+35], 
                             mem_input[com_i_addr+34], 
                             mem_input[com_i_addr+2],
                             mem_input[com_i_addr+1],
                             mem_input[com_i_addr+0]};
        else
                i_tensor <= 72'h00_0000_0000_0000_0000;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                w_tensor <= 72'h00_0000_0000_0000_0000;

        else if (status_flag == COMPUTE)
                w_tensor <= {mem_weight[com_w_addr+8], 
                             mem_weight[com_w_addr+7], 
                             mem_weight[com_w_addr+6], 
                             mem_weight[com_w_addr+5], 
                             mem_weight[com_w_addr+4], 
                             mem_weight[com_w_addr+3], 
                             mem_weight[com_w_addr+2], 
                             mem_weight[com_w_addr+1], 
                             mem_weight[com_w_addr+0]};

        else
                w_tensor <= 72'h00_0000_0000_0000_0000;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                com_i_valid <= 1'b0;
        else if(status_flag == COMPUTE)
                com_i_valid <= 1'b1;
        else 
                com_i_valid <= 1'b0;
end

always @(posedge clk or negedge rst_n)
begin
        if(!rst_n)
                finish_reg <= 1'b0;
        else if((com_w_addr == 8'b1000_0111) & (com_o_addr == 10'b11_1111_1111))
                finish_reg <= 1'b1;
        else
                finish_reg <= 1'b0;
end

conv #(.I_WIDTH(8), .O_WIDTH(8), .ADDR_W(14))
   conv1(.clk(clk),
         .rst_n(rst_n),
         .i_valid(com_i_valid),
         .i_tensor(i_tensor),
         .w_tensor(w_tensor),
         .o_tensor(o_tensor),
         .o_valid(conv_o_valid));

endmodule