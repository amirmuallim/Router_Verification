class router_slave_agt_top extends uvm_env;

	`uvm_component_utils(router_slave_agt_top)

	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	router_env_cfg e_cfg;

	router_slave_agt agt_h[];
		
	router_slave_agt_cfg m_slave_agt_cfg[];

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(router_env_cfg)::get(this, "", "router_config", e_cfg))
			`uvm_fatal("m_agt_top", "can't get e_cfg")

		if(e_cfg.has_slave_agt)
		begin
			agt_h = new[e_cfg.no_of_slave_agt];
			
			foreach(agt_h[i])
			begin
				agt_h[i] = router_slave_agt::type_id::create($sformatf("agt_h[%0d]",i),this);
				uvm_config_db #(router_slave_agt_cfg)::set(this,$sformatf("agt_h[%0d]*",i),"m_cfg",e_cfg.m_slave_agt_cfg[i]);
			end
		end
	endfunction : build_phase

endclass 

