class router_slave_mon extends uvm_monitor;

	`uvm_component_utils(router_slave_mon)

	router_slave_agt_cfg cfg;
	virtual router_if.DST_MON vif;
	uvm_analysis_port #(read_xtn) monitor_port;
	read_xtn d_xtn;

	function new (string name = "", uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(router_slave_agt_cfg)::get(this,"","m_cfg",cfg))
			`uvm_fatal("DMON","Can't get cfg")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
				collect_data();
			end
	endtask
	
	// with wait constrt suitable for questa
	
	task collect_data();
		d_xtn = read_xtn::type_id::create("d_xtn");
		wait(vif.dst_mon_cb.rd_en == 1 && vif.dst_mon_cb.vld_out == 1)
		@(vif.dst_mon_cb);
		d_xtn.header = vif.dst_mon_cb.d_out;
		d_xtn.payload = new[d_xtn.header[7:2]];
		@(vif.dst_mon_cb);
		foreach(d_xtn.payload[i])
			begin
				@(vif.dst_mon_cb);
				d_xtn.payload[i] = vif.dst_mon_cb.d_out;
			end
		d_xtn.parity = vif.dst_mon_cb.d_out;
		`uvm_info("Dst_MON",$sformatf("printing from dest monitor \n %s", d_xtn.sprint()),UVM_LOW)
		monitor_port.write(d_xtn);
	endtask 

	// collect_data without wait ,suitable for vcs 
/*	task collect_data();
  		  d_xtn = read_xtn::type_id::create("d_xtn");

  		  forever begin
        @(vif.dst_mon_cb); // sample signals on clocking block
        if (vif.dst_mon_cb.rd_en == 1 && vif.dst_mon_cb.vld_out == 1)
            break;
    end

  		  @(vif.dst_mon_cb);
 		   d_xtn.header = vif.dst_mon_cb.d_out;
 		   d_xtn.payload = new[d_xtn.header[7:2]];

  		  @(vif.dst_mon_cb);
  		  foreach(d_xtn.payload[i]) begin
    		    d_xtn.payload[i] = vif.dst_mon_cb.d_out;
    		    @(vif.dst_mon_cb);
  		  end

  		  d_xtn.parity = vif.dst_mon_cb.d_out;

   		 `uvm_info("Dst_MON", $sformatf("printing from dest monitor \n %s", d_xtn.sprint()), UVM_LOW)
  		  monitor_port.write(d_xtn);
	endtask
*/	

endclass

