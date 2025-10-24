# synth.tcl - synthesis script for yosys
# to run yosys synth.tcl
#
yosys plugin -i slang
yosys read_slang --top rvj1_top \
                 --compat-mode  \
                 --keep-hierarchy \
                 --allow-use-before-declare \
                 --ignore-unknown-modules \
                 -F synth.flist
yosys check
yosys proc
yosys fsm
yosys opt
yosys memory
yosys opt
yosys techmap
yosys opt
yosys write_verilog -norename ./output/impl_netlist.v
