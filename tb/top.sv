`timescale 1ns/1ps

module top;

	import router_test_pkg::*;
	import uvm_pkg::*;

	`include "uvm_macros.svh"

	bit clk;

	always 
		#10 clk = !clk;

	router_if src(clk);
	router_if dst1(clk);
	router_if dst2(clk);
	router_if dst3(clk);

	top_module DUT(.clk(clk),
		.rst_n(src.rst_n),
		.rd_en_0(dst1.rd_en),
		.rd_en_1(dst2.rd_en),
		.rd_en_2(dst3.rd_en),
		.data_i(src.d_in),
		.pkt_vld(src.pkt_vld),
		.data_o_0(dst1.d_out),
		.data_o_1(dst2.d_out),
		.data_o_2(dst3.d_out),
		.vld_o_0(dst1.vld_out),
		.vld_o_1(dst2.vld_out),
		.vld_o_2(dst3.vld_out),
		.error(src.error),
		.busy(src.busy));

	initial begin
		`ifdef VCS
		$fsdbDumpvars(0, top);
		`endif	

		uvm_config_db #(virtual router_if)::set(null,"*","m_cfg0",src);
		uvm_config_db #(virtual router_if)::set(null,"*","s_cfg0",dst1);
		uvm_config_db #(virtual router_if)::set(null,"*","s_cfg1",dst2);
		uvm_config_db #(virtual router_if)::set(null,"*","s_cfg2",dst3);

		run_test();
	end
property stable_data;
		@(posedge clk) src.busy |=> $stable(src.d_in);
	endproperty

	property busy_check;
		@(posedge clk) $rose(src.pkt_vld) |=> src.busy;
	endproperty

	property valid_signal;
		@(posedge clk) $rose(src.pkt_vld) |-> ##3(dst1.vld_out | dst2.vld_out |dst3.vld_out);
	endproperty

	property rd_enb0;
		@(posedge clk) dst1.vld_out |-> ##[1:29]dst1.rd_en;
	endproperty

	property rd_enb1;
		@(posedge clk) dst2.vld_out |-> ##[1:29]dst2.rd_en;
	endproperty
	
	property rd_enb2;
		@(posedge clk) dst3.vld_out |-> ##[1:29]dst3.rd_en;
	endproperty
	
	property rd_enb0_low;
		@(posedge clk) $fell(dst1.vld_out) |=> $fell(dst1.rd_en);
	endproperty

	property rd_enb1_low;
		@(posedge clk) $fell(dst2.vld_out) |=> $fell(dst2.rd_en);
	endproperty

	property rd_enb2_low;
		@(posedge clk) $fell(dst3.vld_out) |=> $fell(dst3.rd_en);
	endproperty

	
	A1: assert property(stable_data)
		$display("assertion is successful for stable data");
	    else
		$display("assertion is failed for stable data");

	C1: cover property(stable_data);

	A2: assert property(busy_check)
		$display("assertion is successful for busy check");
	    else
		$display("assertion is failed for busy check");

	C2: cover property(busy_check);

	A3: assert property(valid_signal)
		$display("assertion is successful for valid signal");
	    else
		$display("assertion is failed for valid signal");
	
	C3: cover property(valid_signal);

	A4: assert property(rd_enb0)
		$display("assertion is successful for rd enb0");
	    else
		$display("assertion is failed for rd enb0");

	C4: cover property(rd_enb0);

	A5: assert property(rd_enb1)
		$display("assertion is successful for rd enb1");
	    else
		$display("assertion is failed for rd enb1");

	C5: cover property(rd_enb1);

	A6: assert property(rd_enb2)
		$display("assertion is successful for rd enb2");
	    else
		$display("assertion is failed for rd enb2");

	C6: cover property(rd_enb2);

	A7: assert property(rd_enb0_low)
		$display("assertion is successful for rd enb0 low");
	    else
		$display("assertion is failed for rd enb0 low");

	C7: cover property(rd_enb0_low);

	A8: assert property(rd_enb1_low)
		$display("assertion is successful for rd enb1 low");
	    else
		$display("assertion is failed for rd enb1 low");

	C8: cover property(rd_enb1_low);

	A9: assert property(rd_enb2_low)
		$display("assertion is successful for rd enb2 low");
	    else
		$display("assertion is failed for rd enb2 low");

	C9: cover property(rd_enb2_low); 
endmodule : top
