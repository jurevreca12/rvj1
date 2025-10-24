.PHONY: all clean
all: output/impl_netlist.v
output/impl_netlist.v: synth.flist output
	yosys -c synth.tcl -l output/yosys.log

synth.flist: $(wildcard ../../*.{sv,v})
	python create_flist.py

output:
	mkdir output

clean:
	rm -rf output synth.flist
