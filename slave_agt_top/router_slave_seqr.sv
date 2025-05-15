class router_slave_seqr extends uvm_sequencer #(read_xtn);

	`uvm_component_utils(router_slave_seqr)

	function new (string name = "router_slave_seqr", uvm_component parent);
		super.new(name, parent);
	endfunction : new

endclass : router_slave_seqr

