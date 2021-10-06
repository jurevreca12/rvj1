# synth.tcl is a synthesis script for Vivado
# 
# run "vivado -mode batch -source synth.tcl" to get a compiled vivado design
#
set script_path [ file dirname [ file normalize [ info script ] ] ]
set project_root_dir $script_path/../../.
set source_dir $project_root_dir/rtl
set output_dir $script_path/output/.
set_part xc7z010clg225-1
# Out-of-context synthesis

read_verilog [ glob $source_dir/inc/*.sv ] 
read_verilog [ glob $source_dir/*.sv ] 
read_verilog [ glob $source_dir/alu/adder/*.v ] 
read_verilog [ glob $source_dir/alu/compare/*.v ] 
read_verilog [ glob $source_dir/alu/shift/*.v ] 
read_verilog [ glob $source_dir/alu/sign_extension/sign_extender.v ]
read_xdc     $script_path/constr.xdc

# Run synthesis
synth_design -top jedro_1_top \
	     -include_dirs $source_dir/inc \
	     -mode out_of_context
write_checkpoint -force $output_dir/post_synth
report_timing_summary 		-file $output_dir/post_synth_timing_summary.rpt
report_power			-file $output_dir/post_synth_power.rpt
report_clock_interaction	-file $output_dir/post_synth_clock_interaction.rpt \
				-delay_type min_max
report_high_fanout_nets		-file $output_dir/post_synth_high_fanout_nets.rpt  \
				-fanout_greater_than 200 \
				-max_nets 50

write_verilog -force $output_dir/impl_netlist.v
write_edif    -force $output_dir/impl_netlist.edif
