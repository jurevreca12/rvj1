# synth.tcl - synthesis script for yosys
# to run yosys synth.tcl
#
#yosys read_verilog -lib +/xilinx/cells_xtra.v
#yosys read_verilog -lib -specify +/xilinx/cells_sim.v
yosys read_verilog src/ibuf.v
yosys read_verilog src/bufg.v
yosys read_verilog src/plle2_base.v
yosys plugin -i slang
yosys read_slang --top rvj1_soc -F synth.flist --extern-modules
yosys check
yosys synth_xilinx -top    rvj1_soc \
           -family xc7 \
           -abc9 \
           -dff \
           -nodsp \
           -nowidelut \
           -edif ./output/impl_netlist.edif
yosys write_verilog ./output/impl_netlist.v
yosys write_blif    ./output/impl_netlist.blif
yosys write_json    ./output/impl_netlist.json
yosys stat -tech xilinx
