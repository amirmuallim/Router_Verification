class router_slave_seqs extends uvm_sequence #(read_xtn);
	`uvm_object_utils(router_slave_seqs)

	function new(string name="router_slave_seqs");
		super.new(name);
	endfunction

endclass

class r_seqs extends router_slave_seqs;
	`uvm_object_utils(r_seqs)

	function new(string name = "r_seqs");
		super.new(name);
	endfunction

	task body();
	//	`uvm_info("slave_seqs", "starting seqs ", UVM_MEDIUM)
//		if(uvm_config_db #(router_slave_agt_cfg)::get(this,"", "m_cfg", cfg)
//			`uvm_fatal("slave", 
		req = read_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay < 29;});
		finish_item(req);
	endtask
endclass

class sft_rst_seq extends router_slave_seqs;
	`uvm_object_utils(sft_rst_seq)
	
	function new(string name="sft_rst_seq");
		super.new(name);
	endfunction

	task body();
		req = read_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay > 30;});
		finish_item(req);
	endtask
endclass
