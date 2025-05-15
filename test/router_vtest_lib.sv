class router_vtest_lib extends uvm_test;
	`uvm_component_utils(router_vtest_lib)

	router_env_cfg e_cfg;
	router_master_agt_cfg m_cfg[];
	router_slave_agt_cfg s_cfg[];

	int no_of_master_agt = 1;
	int no_of_slave_agt = 3;
	int has_scoreboard = 1;
	int has_virtual_seqr = 1;

	router_tb envh;

	function new(string name="router_vtest_lib",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		m_cfg = new[no_of_master_agt];
		s_cfg = new[no_of_slave_agt];
		e_cfg = router_env_cfg::type_id::create("e_cfg");
		e_cfg.m_master_agt_cfg = new[no_of_master_agt];
		e_cfg.m_slave_agt_cfg = new[no_of_slave_agt];
		
		foreach(m_cfg[i])
			begin
			m_cfg[i] = router_master_agt_cfg::type_id::create($sformatf("m_cfg[%0d]",i));
			if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("m_cfg%0d",i),m_cfg[i].vif))
				`uvm_fatal("TEST","Cant find vif")
			m_cfg[i].is_active = UVM_ACTIVE;
			e_cfg.m_master_agt_cfg[i] = m_cfg[i];
			end

		foreach(s_cfg[i])
			begin
			s_cfg[i] = router_slave_agt_cfg::type_id::create($sformatf("s_cfg[%0d]",i));
			if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("s_cfg%0d",i),s_cfg[i].vif))
				`uvm_fatal("TEST","cant find vif")
		
			s_cfg[i].is_active = UVM_ACTIVE;
			e_cfg.m_slave_agt_cfg[i] = s_cfg[i];
			end
 	
		e_cfg.no_of_master_agt = no_of_master_agt;
		e_cfg.no_of_slave_agt = no_of_slave_agt;
		e_cfg.has_scoreboard = has_scoreboard;
		e_cfg.has_virtual_seqr = has_virtual_seqr;
		uvm_config_db #(router_env_cfg)::set(this,"*","router_config",e_cfg);
		super.build_phase(phase);
		envh = router_tb::type_id::create("envh",this);
	endfunction

	task run_phase(uvm_phase phase);
	
		uvm_top.print_topology();
	endtask

endclass

// sending small pkt to addr 0 

class small_pkt_test0 extends router_vtest_lib;
	`uvm_component_utils(small_pkt_test0)

	small_pkt s_pkt;
	r_seqs rs;
//	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="small_pkt_test0",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 0;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = small_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
			//foreach(envh.m_agt_top.agt_h[i])
			s_pkt.start(envh.m_agt_top.agt_h[address].seqrh);
			rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs
				
		join
		#100;
		`uvm_info("DEBUG", "Dropping objection", UVM_LOW)	
		phase.drop_objection(this);
	endtask

endclass

// sending small pkt to addr 1

class small_pkt_test1 extends router_vtest_lib;
	`uvm_component_utils(small_pkt_test1)

	small_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="small_pkt_test1",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 1;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = small_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
			s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
			rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

// sending small pkt to addr 2 

class small_pkt_test2 extends router_vtest_lib;
	`uvm_component_utils(small_pkt_test2)

	small_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="small_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 2;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = small_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass
/////////////////////////
////////////////////
//
// sending med pkt to addr 0
///////////////////
//\///////////////////
//////////////////
class medium_pkt_test0 extends router_vtest_lib;
	`uvm_component_utils(medium_pkt_test0)

	medium_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="medium_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 0;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = medium_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

// sending med pkt to addr 1 

class medium_pkt_test1 extends router_vtest_lib;
	`uvm_component_utils(medium_pkt_test1)

	medium_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="medium_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 1;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = medium_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

// sending medium_pkt to addr 2 

class medium_pkt_test2 extends router_vtest_lib;
	`uvm_component_utils(medium_pkt_test2)

	medium_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="medium_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 2;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = medium_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass
/////////////////////////
///////////////////
// sending big_pkt to addr 0 
/////////////////////
///////////////////////
//////////////////////
class big_pkt_test0 extends router_vtest_lib;
	`uvm_component_utils(big_pkt_test0)

	big_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="big_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 0;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = big_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

// sending big_pkt to addr 1 

class big_pkt_test1 extends router_vtest_lib;
	`uvm_component_utils(big_pkt_test1)

	big_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="big_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 1;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = big_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

// sending big_pkt to addr 2 

class big_pkt_test2 extends router_vtest_lib;
	`uvm_component_utils(big_pkt_test2)

	big_pkt s_pkt;
	r_seqs rs;
	sft_rst_seq srseqs;
	bit [1:0] address;

	function new(string name="big_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		
		address = 2;
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
		
		s_pkt = big_pkt::type_id::create("s_pkt");
		rs = r_seqs::type_id::create("rs");
//		srseqs = sft_rst_seq::type_id::create("srseqs"); // uncomment for softrst seqs
		fork
		//	foreach(envh.m_agt_top.agt_h[i])
				s_pkt.start(envh.m_agt_top.agt_h[0].seqrh);
				rs.start(envh.s_agt_top.agt_h[address].seqrh);
				//srseqs.start(envh.s_agt_top.agt_h[address].seqrh); // uncommment for softrst seqs

		join
		#100;
		phase.drop_objection(this);
	endtask

endclass

