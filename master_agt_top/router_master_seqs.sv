class router_master_seqs extends uvm_sequence #(write_xtn);
	`uvm_object_utils(router_master_seqs)

	function new(string name="router_master_seqs");
		super.new(name);
	endfunction

endclass

class small_pkt extends router_master_seqs;
	`uvm_object_utils(small_pkt)

	bit [1:0]address;

	function new(string name="small_pkt");
		super.new(name);
	endfunction

	task body();
		
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
			`uvm_fatal("router_master_seqs","Cant get address")
			req = write_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[1:20]} && header[1:0] == address;});
		`uvm_info("router_master_seqs",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask
endclass

class medium_pkt extends router_master_seqs;
	`uvm_object_utils(medium_pkt)

	bit [1:0]address;

	function new(string name="medium_pkt");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
			`uvm_fatal("router_master_seqs","Cant get address")
		req = write_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[21:40]} && header[1:0] == address;});
		`uvm_info("router_master_seqs",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask
endclass

class big_pkt extends router_master_seqs;
	`uvm_object_utils(big_pkt)

	bit [1:0]address;

	function new(string name="big_pkt");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
			`uvm_fatal("router_master_seqs","Cant get address")
		req = write_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[41:63]} && header[1:0] == address;});
		`uvm_info("router_master_seqs",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask
endclass
