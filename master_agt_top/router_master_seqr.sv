class router_master_seqr extends uvm_sequencer #(write_xtn);

	`uvm_component_utils(router_master_seqr)

	function new (string name = "router_master_seqr", uvm_component parent);
		super.new(name, parent);
	endfunction : new

endclass : router_master_seqr
