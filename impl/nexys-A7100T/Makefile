.PHONY: all pnr bitgen clean

FPGA_DB=/foss/tools/nextpnr-xilinx/xilinx/xc7a100t.bin

all: output/impl_netlist.edif pnr bitgen
pnr: output/rvj1_soc.fasm
bitgen: output/rvj1_soc.bit

synth.flist: $(wildcard ../../*.{sv,v})
	python create_flist.py

output:
	mkdir output

output/impl_netlist.edif: synth.flist output
	yosys -c synth.tcl -l output/yosys.log

output/rvj1_soc.fasm: output/impl_netlist.json
	nextpnr-xilinx --freq 50 --json output/impl_netlist.json --chipdb $(FPGA_DB) --xdc constr_nexys.xdc --fasm output/rvj1_soc.fasm --log output/nextpnr-xilinx.log

output/rvj1_soc.frames: output/rvj1_soc.fasm
	fasm2frames --part xc7a100tcsg324-1 \
		    --db-root /foss/tools/prjxray-db/artix7/ \
		    ./output/rvj1_soc.fasm > output/rvj1_soc.frames

output/rvj1_soc.bit: output/rvj1_soc.frames
	xc7frames2bit --part_file /foss/tools/prjxray-db/artix7/xc7a100tcsg324-1/part.yaml \
		      --part_name xc7a100tcsg324-1  \
		      --frm_file ./output/rvj1_soc.frames \
		      --output_file ./output/rvj1_soc.bit

clean:
	rm -rf output synth.flist
