class router_master_agt_cfg extends uvm_object;

	`uvm_object_utils(router_master_agt_cfg)

	virtual router_if vif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	static int drv_data_count = 0;
	static int mon_data_count = 0;

	function new(string name = "router_master_agt_cfg");
		super.new;
	endfunction : new
	
endclass : router_master_agt_cfg
