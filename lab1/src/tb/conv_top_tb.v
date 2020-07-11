// ==============================================================
// Conv TOP Testbenchs
// ==============================================================

module conv_top_tb();

    reg		     clk;
    reg          rst_n;
    reg          start;
    reg  [31:0]  i_data;
    reg          i_valid;
    reg          d_type; // 0 for Input or 1 for Weight
    wire  [31:0] o_data;
    wire         o_valid;
    wire         finish;

    reg   [10:0] count;

    initial 
        begin
            clk      = 1;
            rst_n    = 0;
            start    = 0;
            i_data   = 32'h0000_0000;
            i_valid  = 0;
            d_type   = 0;
            #5 
            rst_n = 1;
            #5 
            start = 1;
            i_valid  = 1;
            d_type   = 0;
            #579
            start = 1;
            i_valid  = 1;
            d_type   = 1;
            #72
            start = 0;
            i_valid  = 0;
            #32768
            $finish;
        end

    conv_top #(.I_WIDTH(8), .O_WIDTH(8))
        conv_top1(.clk(clk),
                  .rst_n(rst_n),
                  .start(start),
                  .i_data(i_data),
                  .i_valid(i_valid),
                  .d_type(d_type),
                  .o_data(o_data),
                  .o_valid(o_valid),
                  .finish(finish));

`ifdef FSDB_ON
    initial
        begin
    `ifdef FSDB_FILE
        string fsdbfile        = "";
	    if ($value$plusargs("fsdbfile=%s", fsdbfile))
            begin
                $fsdbDumpfile(fsdbfile);
                $fsdbDumpvars(0,"+all");
            end
    `else
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0,"+all");
    `endif
	    end
`endif



always #1 clk=~clk;

always @(posedge clk)
if(!rst_n)
    count <= 1;
else
    count <= count+1;

always @(posedge clk)
if(!rst_n)
    i_data <= 1;
else
    i_data <= i_data + count;

endmodule

