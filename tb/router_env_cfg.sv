class router_env_cfg extends uvm_object;
	bit has_scoreboard = 1;
	bit has_virtual_seqr = 1;
	
	bit has_master_agt = 1;
	bit has_slave_agt = 1;
	int no_of_master_agt = 1;
	int no_of_slave_agt = 3;

	router_master_agt_cfg m_master_agt_cfg[];
	router_slave_agt_cfg m_slave_agt_cfg[];

	`uvm_object_utils(router_env_cfg)

	function new(string name = "router_env_cfg");
		super.new(name);
	endfunction : new

endclass : router_env_cfg
