# Router Verification using SystemVerilog and UVM

This project showcases the functional verification of a **packet-based Router design** using **SystemVerilog** and **Universal Verification Methodology (UVM)**. The verification environment is structured to test the router under various valid and invalid scenarios, ensuring robust data handling and protocol correctness.

## 🔧 Design Overview

The **Router DUT (Design Under Test)** accepts packets with headers and payloads and routes them based on the header information. It includes:

- Packet parsing
- Buffering logic
- Routing logic for multiple output ports

## ✅ Verification Objectives

- Build a reusable and modular UVM testbench
- Verify correct packet routing to designated output ports
- Test behavior under different traffic patterns (single/multiple packets)
- Check for corner cases like back-to-back packets and invalid headers
- Achieve functional coverage goals

## 🔍 Key Components

- **Router Interface**: Captures communication between DUT and TB
- **Driver & Monitor**: Drive and sample DUT signals
- **Sequencer & Sequence**: Generate test stimuli with randomization
- **Scoreboard**: Compares actual and expected outputs
- **Assertions**: Check protocol compliance and data integrity

## 🧪 Testcases

| Testcase               | Description                                  |
|------------------------|----------------------------------------------|
| `small_pkt0, 1, 2`     | Sends small packets                          |
| `med_pkt0, 1, 2`       | Sends med packets                            |
| `large_pkt 0, 1, 2`    | Sends large packets                          |

## 🚀 How to Run

Ensure you have a UVM-compatible simulator (e.g., **QuestaSim**, **Synopsys VCS**).

```bash
# Navigate to the project directory
cd Router_Verification

# Compile and simulate
vlog +acc rtl/router.v tb/*.sv uvm_components/**/*.sv sequences/*.sv
vsim -c -do sim/run.do testbench_top
Modify run.do for GUI-based or batch simulation.

📊 Coverage
Functional and code coverage reports can be generated using built-in simulator options. Coverage points include:

Header decoding

Output port routing

Buffer underflow/overflow conditions

📌 Tools Used
SystemVerilog, UVM 1.2

QuestaSim / VCS

Linux-based simulation flow
