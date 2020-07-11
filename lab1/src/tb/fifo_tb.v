module test_top;

   parameter LOG_DEEPTH = 4;
   parameter D_WIDTH    = 32;

   reg		            clk;
   reg                  rst_n;
   reg                  r_en;
   reg                  w_en;
   reg	[D_WIDTH-1:0]	in_data;
   wire	[D_WIDTH-1:0]	out_data;
   wire		            full;
   wire                 empty;
   wire                 half_full;
   wire                 overflow;
   wire                 o_valid;

   integer i;

fifo #(.LOG_DEEPTH(LOG_DEEPTH), .D_WIDTH(D_WIDTH))
	fifo1(.clk(clk),
		   .rst_n(rst_n),
		   .w_en(w_en),
		   .data_w(in_data),
		   .r_en(r_en),
		   .data_r(out_data),
		   .empty(empty),
		   .full(full),
		   .half_full(half_full),
		   .overflow(overflow),
		   .o_valid(o_valid));

initial//test signals status  after reset(full empty half_full)
  begin
	in_data = 0;
	r_en    = 0;
	w_en    = 0;
	clk     = 1;
	rst_n   = 0;
	i       = 1;
	#5 rst_n= 1;
	
	$display("\n\ninitial done\n\n");
	if({empty, half_full, full, overflow}!=4'b1000)
		begin
			$display("\nError at time %0t:",$time);
			$display("After reset, status not asserted\n");
			$display("empty = %b full = %b half_full = %b overflow = %b\n", empty, full,half_full,overflow);
			//$stop;
		end
	else
		begin
			$display("Initial status right!\nempty = %b full = %b half_full = %b overflow = %b\n", empty, full, half_full, overflow);
		end
   #5;
	//causing half_full
	for (i=1; i<((1<<(LOG_DEEPTH-1))+1); i=i+1)
		begin
			@(negedge clk) w_en=1; in_data=i;
			$display("storing %d  w_en=%d r_en=%d\n", i, w_en, r_en);
		end
	@(negedge clk) w_en=0;

	#50;
	if({empty, half_full, full, overflow} != 4'b0100)
		begin
			$display("\nError at time %0t:",$time);
			$display("Half_full\n");
			$display("empty = %b full = %b half_full = %b overflow = %b\n", empty, full, half_full, overflow);
			//$stop;
		end
	else
		begin
			$display("Half_full status right\nempty = %b full = %b half_full = %b overflow = %b\n", empty, full, half_full, overflow);
		end

	//causing full
	for (i=((1<<(LOG_DEEPTH-1))+1); i<((1<<(LOG_DEEPTH))+1); i=i+1)
		begin
		@(negedge clk) w_en=1;in_data=i; 
			$display("storing %d  w_en=%d r_en=%d\n", i, w_en, r_en);
		end
	@(negedge clk) w_en=0;

	#5;
	if({empty,half_full,full,overflow}!=4'b0010)
		begin
			$display("\nError at time %0t:",$time);
			$display("Full\n");
			$display("empty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
			//$stop;
		end
	else
		begin
			$display("full status right\nempty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
		end

	//causing overflow
	begin
	    @(negedge clk) w_en=1; in_data = 99;
		$display("storing %d  w_en=%d r_en=%d\n", i, w_en, r_en);
	end

	#5;
	if({empty,half_full,full,overflow}!=4'b0011)
		begin
			$display("\nError at time %0t:",$time);
			$display("Overflow\n");
			$display("empty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
			//$stop;
		end
	else
		begin
			$display("overflow status right\nempty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
		end

	//Starting to read nums
	@(negedge clk) w_en=0; r_en=1;
	#1;

	for (i=1; i<4; i=i+1)
	begin
	    @(posedge clk);
		$display("reading data %d, your data %d\n", i, out_data);
		if(out_data != i)
			begin
				$display("expected data %d\n your data %d",i,out_data);
			//$stop;
			end
	end
	@(negedge clk) r_en=0;

	#5;
	if({empty, half_full, full, overflow}!=4'b0000)
		begin
			$display("\nError at time %0t:",$time);
			$display("empty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
			//$stop;
		end
	else
		begin
			$display("after reading 3 data, right, empty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
		end
	
	//write again
	@(negedge clk) r_en=0;
	#5;
	
	for (i=1;i<5;i=i+1)
		begin
			@(negedge clk) w_en=1; in_data=i;
			$display("storing %d again  w_en=%d r_en=%d\n", i, w_en, r_en);
		end

	//read fifo all out
	@(negedge clk) w_en=0; r_en=1;	
	#1;

	for (i=5; i<((1<<(LOG_DEEPTH))+1); i=i+1)
		begin
			@(posedge clk);
			$display("reading data %d   %d\n",i,out_data);		
			if(out_data!=i)
				begin
					$display("date stored in %d maybe wrong\n",out_data);
					//$stop;
				end	
		end
	
	for (i=1;i<5;i=i+1)
		begin
			@(posedge clk);
			$display("reading data %d  %d\n",i,out_data);
			if(out_data != i)
				begin
					$display("date stored in %d maybe wrong\n",i);
					//$stop;
				end
		end

	@(negedge clk) r_en=0;
	#5;

	if({empty, half_full, full, overflow}!=4'b1000)
	begin
		$display("\nerror at time %0t:",$time);
		$display("empty = %b full = %b half_full = %b overflow = %b\n",empty,full,half_full,overflow);
		//$stop;
	end
	else
	begin
		$display("********************\nDone, Without error\n********************\n");
		//$stop;
	end
    #5     $finish;
  end

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
	  $fsdbDumpfile("top.fsdb");
	  $fsdbDumpvars(0,"+all");
`endif
	end
`endif

always #1 clk=~clk;

endmodule
