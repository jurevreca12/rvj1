set DEVICE xc7a100t_0
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices $DEVICE]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices $DEVICE] 0]
set_property PROBES.FILE {} [get_hw_devices $DEVICE]
set_property FULL_PROBES.FILE {} [get_hw_devices $DEVICE]
set_property PROGRAM.FILE {./output/impl.bit} [get_hw_devices $DEVICE]
program_hw_devices [get_hw_devices $DEVICE]
refresh_hw_device [lindex [get_hw_devices $DEVICE] 0]
close_hw_target
