# synth.tcl is a synthesis script for Vivado
# 
# run "vivado -mode batch -source synth.tcl" to get a compiled vivado design
#
# Nexys boards
#set_part xc7a750tcsg324-1
set_part xc7a100tcsg324-1
# ZedBoard
#set_part xc7z020clg484-1 

set script_path [ file dirname [ file normalize [ info script ] ] ]
set project_root_dir $script_path/../../.
set source_dir $project_root_dir/rtl
set output_dir $script_path/output/.

read_verilog [ glob $source_dir/inc/*.sv ] 
read_verilog [ glob $source_dir/*.sv ] 
read_verilog [ glob $source_dir/alu/compare/*.sv ] 
read_verilog [ glob $source_dir/lib/*.sv ] 
read_verilog $project_root_dir/tb/support/bytewrite_sram.sv
read_verilog $project_root_dir/tb/support/bytewrite_sram_wrap.sv
read_verilog rvj1_soc.sv
read_xdc $script_path/constr_nexys.xdc

# Run synthesis
synth_design -top rvj1_soc -include_dirs $source_dir/inc
report_timing_summary    -file ./output/post_synth_timing_summary.rpt
report_power             -file ./output/post_synth_power.rpt
report_clock_interaction -file ./output/post_synth_clock_interaction.rpt -delay_type min_max
report_high_fanout_nets	 -file ./output/post_synth_high_fanout_nets.rpt -fanout_greater_than 200 -max_nets 5
report_utilization       -file ./output/utilization_post_synth.rpt
write_verilog -force ./output/impl_netlist.v
write_edif    -force ./output/impl_netlist.edif

opt_design
place_design
report_utilization -file ./output/utilization_post_place.rpt
route_design

write_bitstream -force ./output/impl.bit -bin_file
