package router_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Configurations
  `include "router_slave_agt_cfg.sv"
  `include "router_master_agt_cfg.sv"
  `include "router_env_cfg.sv"

  // Transactions
  `include "read_xtn.sv"
  `include "write_xtn.sv"

  // Driver, Monitor, Sequencer (Slave Agent)
  `include "router_slave_drv.sv"
  `include "router_slave_mon.sv"
  `include "router_slave_seqr.sv"
  `include "router_slave_seqs.sv"
  `include "router_slave_agt.sv"
  `include "router_slave_agt_top.sv"

  // Driver, Monitor, Sequencer (Master Agent)
  `include "router_master_drv.sv"
  `include "router_master_mon.sv"
  `include "router_master_seqr.sv"
  `include "router_master_seqs.sv"
  `include "router_master_agt.sv"
  `include "router_master_agt_top.sv"

  // Scoreboard
  `include "router_scoreboard.sv"

  // Virtual sequences
  `include "router_vseqr.sv"
  `include "router_vseqs.sv"

  // Testbench top
  `include "router_tb.sv"

  // Test
  `include "router_vtest_lib.sv"

endpackage

