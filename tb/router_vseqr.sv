class router_vseqr extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(router_vseqr)

	function new(string name = "router_vseqr", uvm_component parent);
		super.new(name, parent);
	endfunction : new

endclass : router_vseqr

