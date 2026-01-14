.PHONY: all clean openroad


OPENROAD_OUT_FILES = output/rvj1.def output/rvj1.v output/rvj1.sdc output/rvj1.odb

all: synth openroad klayout
synth: output/rvj1_top_yosys.v  
openroad: ${OPENROAD_OUT_FILES}
klayout: output/rvj1.gds 
output/rvj1.gds: output/rvj1.def
	./def2gds.sh

${OPENROAD_OUT_FILES}: output/rvj1_top_yosys.v
	mkdir -p ./output/save
	mkdir -p ./output/reports
	NETLIST="output/rvj1_top_yosys.v" \
	TOP_DESIGN="rvj1_top" \
	PROJ_NAME="rvj1" \
	SAVE="./output/save" \
	REPORTS="./output/reports" \
	PDK=$(PDK) \
	PDKPATH=$(PDKPATH) \
	openroad openroad/chip.tcl -log output/impl.log
	

output/rvj1_top_yosys.v: synth.flist output tmp rep
	yosys -c yosys/yosys_synthesis.tcl -l output/yosys.log


synth.flist: $(wildcard ../../*.{sv,v})
	python create_flist.py

output:
	mkdir output

tmp:
	mkdir tmp

rep:
	mkdir rep

clean:
	rm -rf output synth.flist tmp rep .klayout
