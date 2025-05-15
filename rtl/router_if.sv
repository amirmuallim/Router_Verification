

interface router_if(input bit clk);
	
	logic [7:0] d_in;
	logic pkt_vld;
	logic rst_n;
	logic error;
	logic busy;
	logic rd_en;
	logic [7:0]d_out;
	logic vld_out;

	clocking src_drv_cb@(posedge clk);
		default input #1 output #1;
		input busy;
		input error;
		output d_in;
		output pkt_vld;
		output rst_n;
	endclocking

	clocking src_mon_cb@(posedge clk);
		default input #1 output #1;
		input d_in;
		input pkt_vld;
		input error;
		input busy;
		input rst_n;
	endclocking

	clocking dst_drv_cb@(posedge clk);
		default input #1 output #1;
		input vld_out;
		output rd_en;
	endclocking

	clocking dst_mon_cb@(posedge clk);
		default input #1 output #1;
		input d_out;
		input rd_en;
		input vld_out;
	endclocking

	modport SRC_DRV(clocking src_drv_cb);
	modport SRC_MON(clocking src_mon_cb);
	modport DST_DRV(clocking dst_drv_cb);
	modport DST_MON(clocking dst_mon_cb);

endinterface














