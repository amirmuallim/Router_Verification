class router_master_agt extends uvm_agent;

	`uvm_component_utils(router_master_agt)

	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	router_master_agt_cfg m_cfg;

	router_master_drv drvh;
	router_master_mon monh;
	router_master_seqr seqrh;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(router_master_agt_cfg)::get(this, "", "m_cfg", m_cfg))
			`uvm_fatal("m_agt", "can't get m_cfg")

		monh = router_master_mon::type_id::create("monh", this);

		if(m_cfg.is_active == UVM_ACTIVE)
		begin
			drvh = router_master_drv::type_id::create("drvh", this);
			seqrh = router_master_seqr::type_id::create("seqrh", this);
		end
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		if(m_cfg.is_active == UVM_ACTIVE)
			begin
				drvh.seq_item_port.connect(seqrh.seq_item_export);
			end

	endfunction : connect_phase
endclass : router_master_agt
