class router_slave_agt extends uvm_agent;

	`uvm_component_utils(router_slave_agt)

	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	router_slave_agt_cfg m_cfg;

	router_slave_drv drvh;
	router_slave_mon monh;
	router_slave_seqr seqrh;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(router_slave_agt_cfg)::get(this, "", "m_cfg", m_cfg))
			`uvm_fatal("m_agt", "can't get m_cfg")

		monh = router_slave_mon::type_id::create("monh", this);

		if(m_cfg.is_active == UVM_ACTIVE)
		begin
			drvh = router_slave_drv::type_id::create("drvh", this);
			seqrh = router_slave_seqr::type_id::create("seqrh", this);
		end
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		
			begin
				drvh.seq_item_port.connect(seqrh.seq_item_export);
			end

	endfunction : connect_phase
endclass : router_slave_agt

