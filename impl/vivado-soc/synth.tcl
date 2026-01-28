# synth.tcl is a synthesis script for Vivado
# 
# run "vivado -mode batch -source synth.tcl" to get a compiled vivado design
#
# Nexys boards
#set_part xc7a750tcsg324-1
#set_part xc7a100tcsg324-1
# ZedBoard
set_part xc7z020clg484-1 

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
read_xdc $script_path/constr.xdc

# Run synthesis
synth_design -top rvj1_soc -include_dirs $source_dir/inc
report_timing_summary    -file ./output/post_synth_timing_summary.rpt
report_power             -file ./output/post_synth_power.rpt
report_clock_interaction -file ./output/post_synth_clock_interaction.rpt -delay_type min_max
report_high_fanout_nets	 -file ./output/post_synth_high_fanout_nets.rpt -fanout_greater_than 200 -max_nets 5
write_verilog -force ./output/impl_netlist.v
write_edif    -force ./output/impl_netlist.edif

if {[lindex $argv 0] == "DEBUG"} {
    puts "DEBUG MODE: Adding ILA cores."
    #Create the debug core 
    create_debug_core u_ila_0 ila
    #set debug core properties
    set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
    set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
    set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
    set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
    set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
    set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
    set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
    set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
    #connect the probe ports in the debug core to the signals being probed in the design
    set_property port_width 1 [get_debug_ports u_ila_0/clk]
    connect_debug_port u_ila_0/clk [get_nets [list clk_i ]]
    set_property port_width 1 [get_debug_ports u_ila_0/rstn_i]
    connect_debug_port u_ila_0/probe0 [get_nets [list rstn_i]]
    set_property port_width 1 [get_debug_ports u_ila_0/rst]
    connect_debug_port u_ila_0/probe0 [get_nets [list rst]]
    set_property port_width 1 [get_debug_ports u_ila_0/data_req_valid]
    connect_debug_port u_ila_0/probe0 [get_nets [list data_req_valid]]
    set_property port_width 1 [get_debug_ports u_ila_0/data_req_ready]
    connect_debug_port u_ila_0/probe0 [get_nets [list data_req_ready]]
    set_property port_width 1 [get_debug_ports u_ila_0/data_req_write]
    connect_debug_port u_ila_0/probe0 [get_nets [list data_req_write]]
    set_property port_width 32 [get_debug_ports u_ila_0/data_req_addr]
    connect_debug_port u_ila_0/probe0 [get_nets [list data_req_addr]]
    create_debug_port u_ila_0 probe
}

opt_design
place_design
route_design

write_bitstream -force ./output/impl.bit -bin_file
