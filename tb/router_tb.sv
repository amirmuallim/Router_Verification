class router_tb extends uvm_env;

	`uvm_component_utils(router_tb)

	router_master_agt_top m_agt_top;
	router_slave_agt_top s_agt_top;

	router_vseqr v_seqr;

	router_env_cfg m_cfg;

	router_scoreboard sb;

	function new(string name = "router_tb", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(router_env_cfg)::get(this, "", "router_config", m_cfg))
                `uvm_fatal("Router_tb","cannot get() m_cfg from uvm_config_db. Have you set() it?")

	//	if(m_cfg.has_master_agt)
	//	begin
	//		uvm_config_db #(router_master_agt_cfg)::set(this, "m_agt_top*", "router_master_agt_cfg", m_cfg.m_master_agt_cfg);
			
			m_agt_top = router_master_agt_top::type_id::create("m_agt_top", this);

	//	end

	//	if(m_cfg.has_slave_agt)
	//	begin
	//		uvm_config_db #(router_slave_agt_cfg)::set(this, "s_agt_top*", "router_slave_agt_cfg", m_cfg.m_slave_agt_cfg);
			
			s_agt_top = router_slave_agt_top::type_id::create("s_agt_top", this);

	//	end

		super.build_phase(phase);

		//if(m_cfg.has_virtual_seqr)
                // Create the instance of v_sequencer handle
            	//	v_seqr=router_vseqr::type_id::create("v_seqr",this);

    		if(m_cfg.has_scoreboard)
                	sb = router_scoreboard::type_id::create("sb",this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
/*		 if(m_cfg.has_v_seqr)
                	begin
            		if(m_cfg.has_master_agt)
                                                v_seqr.wr_seqrh[i] = wagt_top[i].agnth.seqrh;

                        if(m_cfg.has_ragent)
                                begin
                                        foreach(ragt_top[i])
                                                v_sequencer.rd_seqrh[i] = ragt_top[i].agnth.seqrh;
              			end
        		end	
*/

		if(m_cfg.has_scoreboard)
			begin
				foreach(m_agt_top.agt_h[i])
					m_agt_top.agt_h[i].monh.monitor_port.connect(sb.fifo_src.analysis_export);
				foreach(s_agt_top.agt_h[i])
					s_agt_top.agt_h[i].monh.monitor_port.connect(sb.fifo_dest[i].analysis_export);
			end

	endfunction : connect_phase

endclass : router_tb
