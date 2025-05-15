class router_slave_drv extends uvm_driver #(read_xtn);

	`uvm_component_utils(router_slave_drv)

	router_slave_agt_cfg cfg;
	virtual router_if.DST_DRV vif;

	function new (string name = "router_slave_drv", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(router_slave_agt_cfg)::get(this,"","m_cfg",cfg))
			`uvm_fatal("DDRV","Can't get router_slave_agt_cfg");
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
			//	`uvm_info("slave_drv", "in the run_phase of slave drv", UVM_MEDIUM)
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(read_xtn d_xtn);
		// with wait constrt
		@(vif.dst_drv_cb);
		wait(vif.dst_drv_cb.vld_out == 1)
		repeat(d_xtn.delay)
			@(vif.dst_drv_cb);
		vif.dst_drv_cb.rd_en <= 1'b1;
		@(vif.dst_drv_cb);
		wait(vif.dst_drv_cb.vld_out == 0)
		@(vif.dst_drv_cb);
		vif.dst_drv_cb.rd_en <= 1'b0;
	//	`uvm_info("slave_DRV",$sformatf("printing from slave driver \n %s", d_xtn.sprint()),UVM_LOW)  

	/*	// while instead of wait
		@(vif.dst_drv_cb);
		while (vif.dst_drv_cb.vld_out !== 1)
 		   @(vif.dst_drv_cb);
		
		repeat(d_xtn.delay)
			@(vif.dst_drv_cb);
		vif.dst_drv_cb.rd_en <= 1'b1;
		@(vif.dst_drv_cb);
		while (vif.dst_drv_cb.vld_out !== 0)
    		@(vif.dst_drv_cb);
		
		@(vif.dst_drv_cb);
		vif.dst_drv_cb.rd_en <= 1'b0;
		*/
	//	`uvm_info("slave_DRV",$sformatf("printing from slave driver \n %s", d_xtn.sprint()),UVM_LOW)
	endtask

endclass : router_slave_drv

