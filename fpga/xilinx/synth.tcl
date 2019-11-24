# synth.tcl is a synthesis script for Vivado
# 
# run "vivado -mode batch -source synth.tcl" to get a compiled vivado design

set project_root_dir ../../.
set source_dir $project_root_dir/source/


read_verilog [ glob $source_dir/jedro_1_decoder.v ] 


# Run synthesis
synth_design -top jedro_1_decoder -part xc7k70tfbg676-2 -flatten rebuilt -include_dirs $source_dir/inc
write_checkpoint -force ./post_synth
report_timing_summary -file ./post_synth_timing_summary.rpt
report_power -file ./post_synth_power.rpt

# Run placement and logic optimization
opt_design
place_design
phys_opt_design
write_checkpoint post_place
report_timing_summary -file ./post_place_timing_summary.rpt

# Run router
route design
write_checkpoint -force ./post_route
report_timing_summary -file post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file post_route_timing.rpt
report clock_utilization -file ./clock_util.rpt
report_utilization -file post_route_util.rpt
report_power -file ./post_route_power.rpt
report_drc -file ./post_imp_drc.rpt
write_verilog -force ./cpu_impl_netlist.v
write_xdc -no_fixed_only -force ./cpu_impl.xdc

# Generate bistream
write_bistream -force DESIGN.bit

