class router_master_mon extends uvm_monitor;
	`uvm_component_utils(router_master_mon)

	router_master_agt_cfg cfg;
	virtual router_if.SRC_MON vif;
	uvm_analysis_port #(write_xtn) monitor_port;

	function new(string name="router_master_mon",uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(router_master_agt_cfg)::get(this,"","m_cfg",cfg))
			`uvm_fatal("router_master_mon","Can't get s_cfg!")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			collect_data();
	endtask

	task collect_data();
		write_xtn s_xtn;

		s_xtn = write_xtn::type_id::create("s_xtn");
	
		@(vif.src_mon_cb);

		wait(vif.src_mon_cb.busy == 0 && vif.src_mon_cb.pkt_vld == 1)
		s_xtn.header = vif.src_mon_cb.d_in;
		s_xtn.payload = new[s_xtn.header[7:2]];
		@(vif.src_mon_cb);
		foreach(s_xtn.payload[i])
			begin
				while(vif.src_mon_cb.busy)
					@(vif.src_mon_cb);
				@(vif.src_mon_cb);
				s_xtn.payload[i] = vif.src_mon_cb.d_in;
			end
		
		while(vif.src_mon_cb.busy)
			@(vif.src_mon_cb);
	
		while(vif.src_mon_cb.pkt_vld)
			@(vif.src_mon_cb);
	
		s_xtn.parity = vif.src_mon_cb.d_in; 
		
		repeat(2)
			@(vif.src_mon_cb);
	
		s_xtn.error = vif.src_mon_cb.error;

		cfg.mon_data_count++;
		
		`uvm_info("S_MON",$sformatf("printing from source monitor \n %s", s_xtn.sprint()),UVM_LOW)
		monitor_port.write(s_xtn);
	endtask
		
endclass
