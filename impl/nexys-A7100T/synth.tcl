# synth.tcl - synthesis script for yosys
# to run yosys synth.tcl
#
yosys plugin -i slang
yosys read_slang --top rvj1_soc \
                 --compat-mode  \
                 --keep-hierarchy \
                 --allow-use-before-declare \
                 --ignore-unknown-modules \
                 -F synth.flist
yosys check
yosys synth_xilinx -top    rvj1_soc \
		   -family xc7 \
           -flatten \
		   -abc9 \
           -nobram \
   		   -edif ./output/impl_netlist.edif
yosys write_verilog ./output/impl_netlist.v
yosys write_blif    ./output/impl_netlist.blif
yosys write_json    ./output/impl_netlist.json
yosys stat
