.PHONY: all synth clean

all: synth

synth: output/impl_netlist.v

output/impl_netlist.v:
	vivado -mode batch -source synth.tcl

clean:
	rm -rf output/ *.jou *.log
