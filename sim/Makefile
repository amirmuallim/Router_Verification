# Makefile for UVM Router Verification

# SIMULATOR = Questa for Mentor's QuestaSim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa

FSDB_PATH = /home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL = ../rtl/*
work = work  # Library name
SVTB1 = ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../master_agt_top +incdir+../slave_agt_top 
SVTB2 = ../test/router_test_pkg.sv
VSIMOPT = -vopt -voptargs=+acc 
VSIMCOV = -coverage -sva 

VSIMBATCH1 = -c -do "log -r /*; coverage save -onexit mem_cov1; run -all; exit"
VSIMBATCH2 = -c -do "log -r /*; coverage save -onexit mem_cov2; run -all; exit"
VSIMBATCH3 = -c -do "log -r /*; coverage save -onexit mem_cov3; run -all; exit"
VSIMBATCH4 = -c -do "log -r /*; coverage save -onexit mem_cov4; run -all; exit"
VSIMBATCH5 = -c -do "log -r /*; coverage save -onexit mem_cov5; run -all; exit"
VSIMBATCH6 = -c -do "log -r /*; coverage save -onexit mem_cov6; run -all; exit"
VSIMBATCH7 = -c -do "log -r /*; coverage save -onexit mem_cov7; run -all; exit"
VSIMBATCH8 = -c -do "log -r /*; coverage save -onexit mem_cov8; run -all; exit"
VSIMBATCH9 = -c -do "log -r /*; coverage save -onexit mem_cov9; run -all; exit"
VSIMBATCH10 = -c -do "log -r /*; coverage save -onexit mem_cov10; run -all; exit"

help:
	@echo "============================================================================================================="
	@echo "! USAGE       --  make <target>                                                                          !"
	@echo "! clean       =>  Clean the earlier log and intermediate files.                                          !"
	@echo "! sv_cmp      =>  Create library and compile the code.                                                   !"
	@echo "! run_test    =>  Clean, compile & run simulation for router_vtest_lib_test (topology) in batch mode.    !"
	@echo "!------------------- Small Packet Tests ---------------------------                                       !"
	@echo "! run_test0   =>  Clean, compile & run simulation for small_pkt_test (addr == 0) in batch mode.          !"
	@echo "! run_test1   =>  Clean, compile & run simulation for small_pkt_test (addr == 1) in batch mode.          !"
	@echo "! run_test2   =>  Clean, compile & run simulation for small_pkt_test (addr == 2) in batch mode.          !"
	@echo "!------------------- Medium Packet Tests --------------------------                                       !"
	@echo "! mrun_test0  =>  Clean, compile & run simulation for med_pkt_test (addr == 0) in batch mode.            !"
	@echo "! mrun_test1  =>  Clean, compile & run simulation for med_pkt_test (addr == 1) in batch mode.            !"
	@echo "! mrun_test2  =>  Clean, compile & run simulation for med_pkt_test (addr == 2) in batch mode.            !"
	@echo "!------------------- Big Packet Tests -----------------------------                                       !"
	@echo "! brun_test0  =>  Clean, compile & run simulation for big_pkt_test (addr == 0) in batch mode.            !"
	@echo "! brun_test1  =>  Clean, compile & run simulation for big_pkt_test (addr == 1) in batch mode.            !"
	@echo "! brun_test2  =>  Clean, compile & run simulation for big_pkt_test (addr == 2) in batch mode.            !"
	@echo "! view_wave   =>  View the waveform without any signal driven or sampled.                                !"
	@echo "! view_swave*(0,1,2) =>  View waveform of small_pkt_test to addr:0,1,2.                                  !"
	@echo "! view_mwave*(0,1,2) =>  View waveform of medium_pkt_test to addr:0,1,2.                                 !"
	@echo "! view_bwave*(0,1,2) =>  View waveform of big_pkt_test to addr:0,1,2.                                    !"
	@echo "! view_cc     =>  View code coverage in browser (HTML format).                                           !"
	@echo "! view_cc_text => View code coverage directly in terminal (text format).                                 !"
	@echo "! regress     =>  Clean, compile and run all testcases in batch mode.                                    !"
	@echo "! report      =>  Merge coverage reports for all testcases and convert to HTML format.                   !"
	@echo "! report_text =>  Merge coverage reports and display in terminal (text format).                          !"
	@echo "! cov         =>  Open merged coverage report in HTML format.                                            !"
	@echo "============================================================================================================="

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)

run_test : run_test_$(SIMULATOR)

run_test0 : run_test0_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)

mrun_test0 : mrun_test0_$(SIMULATOR)
mrun_test1 : mrun_test1_$(SIMULATOR)
mrun_test2 : mrun_test2_$(SIMULATOR)

brun_test0 : brun_test0_$(SIMULATOR)
brun_test1 : brun_test1_$(SIMULATOR)
brun_test2 : brun_test2_$(SIMULATOR)

view_wave : view_wave_$(SIMULATOR)

view_swave0 : view_swave0_$(SIMULATOR)
view_swave1 : view_swave1_$(SIMULATOR)
view_swave2 : view_swave2_$(SIMULATOR)

view_mwave0 : view_mwave0_$(SIMULATOR)
view_mwave1 : view_mwave1_$(SIMULATOR)
view_mwave2 : view_mwave2_$(SIMULATOR)

view_bwave0 : view_bwave0_$(SIMULATOR)
view_bwave1 : view_bwave1_$(SIMULATOR)
view_bwave2 : view_bwave2_$(SIMULATOR)

view_cc : view_cc_$(SIMULATOR)
view_cc_text : view_cc_text_$(SIMULATOR)

regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
report_text : report_text_$(SIMULATOR)

cov : cov_$(SIMULATOR)

# ----------------------------- QuestaSim Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1) -wlf wave.wlf -l test1.log -sv_seed random work.top +UVM_TESTNAME=router_vtest_lib
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov1

run_test0_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2) -wlf swave0.wlf -l test2.log -sv_seed random work.top +UVM_TESTNAME=small_pkt_test0
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov2

run_test1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3) -wlf swave1.wlf -l test3.log -sv_seed random work.top +UVM_TESTNAME=small_pkt_test1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov3

run_test2_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4) -wlf swave2.wlf -l test4.log -sv_seed random work.top +UVM_TESTNAME=small_pkt_test2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov4

mrun_test0_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5) -wlf mwave0.wlf -l test5.log -sv_seed random work.top +UVM_TESTNAME=medium_pkt_test0
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov5

mrun_test1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6) -wlf mwave1.wlf -l test6.log -sv_seed random work.top +UVM_TESTNAME=medium_pkt_test1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov6

mrun_test2_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7) -wlf mwave2.wlf -l test7.log -sv_seed random work.top +UVM_TESTNAME=medium_pkt_test2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov7

brun_test0_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8) -wlf bwave0.wlf -l test8.log -sv_seed random work.top +UVM_TESTNAME=big_pkt_test0
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov8

brun_test1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9) -wlf bwave1.wlf -l test9.log -sv_seed random work.top +UVM_TESTNAME=big_pkt_test1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov9

brun_test2_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10) -wlf bwave2.wlf -l test10.log -sv_seed random work.top +UVM_TESTNAME=big_pkt_test2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov10

clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

view_wave_Questa:
	vsim -view wave.wlf

view_swave0_Questa:
	vsim -view swave0.wlf

view_swave1_Questa:
	vsim -view swave1.wlf

view_swave2_Questa:
	vsim -view swave2.wlf

view_mwave0_Questa:
	vsim -view mwave0.wlf

view_mwave1_Questa:
	vsim -view mwave1.wlf

view_mwave2_Questa:
	vsim -view mwave2.wlf

view_bwave0_Questa:
	vsim -view bwave0.wlf

view_bwave1_Questa:
	vsim -view bwave1.wlf

view_bwave2_Questa:
	vsim -view bwave2.wlf

view_cc_Questa:
	firefox covhtmlreport/index.html &

view_cc_text_Questa:
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov

report_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

report_text_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive mem_cov

regress_Questa: run_test_Questa run_test0_Questa run_test1_Questa run_test2_Questa \
                 mrun_test0_Questa mrun_test1_Questa mrun_test2_Questa \
                 brun_test0_Questa brun_test1_Questa brun_test2_Questa

cov_Questa:
	firefox covhtmlreport/index.html &

# ----------------------------- VCS Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) 

run_test_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=router_vtest_lib

run_test0_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+swave0.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=small_pkt_test0

run_test1_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+swave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=small_pkt_test1

run_test2_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+swave2.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=small_pkt_test2

mrun_test0_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+mwave0.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=medium_pkt_test0

mrun_test1_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+mwave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=medium_pkt_test1

mrun_test2_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+mwave2.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=medium_pkt_test2

brun_test0_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+bwave0.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=big_pkt_test0

brun_test1_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+bwave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=big_pkt_test1

brun_test2_VCS: clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+bwave2.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=big_pkt_test2

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h *.fsdb verdi*
	clear

view_wave_VCS:
	verdi -ssf wave.fsdb

view_swave0_VCS:
	verdi -ssf swave0.fsdb

view_swave1_VCS:
	verdi -ssf swave1.fsdb

view_swave2_VCS:
	verdi -ssf swave2.fsdb

view_mwave0_VCS:
	verdi -ssf mwave0.fsdb

view_mwave1_VCS:
	verdi -ssf mwave1.fsdb

view_mwave2_VCS:
	verdi -ssf mwave2.fsdb

view_bwave0_VCS:
	verdi -ssf bwave0.fsdb

view_bwave1_VCS:
	verdi -ssf bwave1.fsdb

view_bwave2_VCS:
	verdi -ssf bwave2.fsdb
