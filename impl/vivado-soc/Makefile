.PHONY: all debug program sim clean
all: ./output/impl.bit
sim: ./output/tb.vcd
REPORTS = ./output/post_synth_power.rpt \
				  ./output/post_synth.dcp \
					./output/post_synth_clock_interaction.rpt \
					./output/post_synth_high_fanout_nets.rpt
NETLISTS = ./output/impl_netlist.v ./output/impl_netlist.edif
BITFILES = ./output/impl.bin ./output/impl.bit

SVFILES   = $(shell find -name "*.sv" -exec basename \{} \;)
SDBFILESX = $(SVFILES:%=./xsim.dir/work/%)
SDBFILES  = $(SDBFILESX:.sv=.sdb)
MODULES   = $(SVFILES:.sv=)

debug:
	vivado -mode batch -source synth.tcl -log ./output/vivado.log -nojournal -tclargs DEBUG

$(REPORTS) $(NETLISTS) $(BITFILES): $(SVFILES) synth.tcl constr.xdc ./output/
	vivado -mode batch -source synth.tcl -log ./output/vivado.log -nojournal

./output/:
	mkdir output

program: 
	vivado -mode batch -source prog.tcl

./output/tb.vcd: ./xsim.dir/top_tb.simsnap/ ./output/
	xsim -R top_tb.simsnap -nolog --wdb ./output/top_tb.simsnap.wdb 
 
./xsim.dir/top_tb.simsnap/: $(SDBFILES)
	xelab --nolog -debug typical $(MODULES) -s top_tb.simsnap 

./xsim.dir/work/%.sdb: %.sv
	xvlog -sv -nolog $<

clean:
	rm -rf output/
	rm -f clockInfo.txt xvlog*.log xvlog*.pb
	rm -rf xsim.dir
	rm -f xelab.pb
	rm -f *simsnap.wdb
	rm -f xsim*.jou vivado*.log vivado*.jou
