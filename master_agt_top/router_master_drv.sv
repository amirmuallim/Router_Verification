

class router_master_drv extends uvm_driver #(write_xtn);
	
	`uvm_component_utils(router_master_drv)

	router_master_agt_cfg cfg;
	virtual router_if.SRC_DRV vif;
	
	function new(string name="router_master_drv",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(router_master_agt_cfg)::get(this,"","m_cfg",cfg))
			`uvm_fatal("SDRV","can't get router_master_agt_cfg!")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.src_drv_cb);
		vif.src_drv_cb.rst_n <= 0; //resetting the dut
		@(vif.src_drv_cb);
		vif.src_drv_cb.rst_n <= 1; //setting dut

		forever
			begin
				seq_item_port.get_next_item(req); //sending request to sequence
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(write_xtn write_xtn1);
//		`uvm_info("S_DRV",$sformatf("printing from driver \n %s", write_xtn1.sprint()),UVM_LOW)
		`uvm_info(get_type_name(),$sformatf("printing from driver \n %s",write_xtn1.sprint()),UVM_LOW)
		@(vif.src_drv_cb);
		while(vif.src_drv_cb.busy)
			@(vif.src_drv_cb);

		vif.src_drv_cb.pkt_vld <= 1;
		vif.src_drv_cb.d_in <= write_xtn1.header;
		@(vif.src_drv_cb);
		foreach(write_xtn1.payload[i])
			begin
				while(vif.src_drv_cb.busy)
					@(vif.src_drv_cb);
				vif.src_drv_cb.d_in <= write_xtn1.payload[i];
				@(vif.src_drv_cb);
			end
		while(vif.src_drv_cb.busy)
			@(vif.src_drv_cb);
		
		vif.src_drv_cb.pkt_vld <= 0;
		vif.src_drv_cb.d_in <= write_xtn1.parity;
		
		repeat(2)
			@(vif.src_drv_cb);

		write_xtn1.error = vif.src_drv_cb.error;
		
	//	@(vif.src_drv_cb);

		cfg.drv_data_count++;


	endtask
	
endclass

























