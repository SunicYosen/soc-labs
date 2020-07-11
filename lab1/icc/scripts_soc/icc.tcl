#====================================================
# Physical Design main script
#====================================================


#----------------------------
# Sub TCL
#----------------------------
set script_path  [file dirname [file normalize [info script]]]

source $script_path/1_0_data_setup.tcl
source $script_path/2_0_floorplan.tcl
source $script_path/3_0_virtual_flat_placement.tcl
source $script_path/4_0_pns.tcl 
source $script_path/5_0_placement.tcl
source $script_path/6_0_cts.tcl
source $script_path/7_0_route.tcl
source $script_path/8_0_chip_finish.tcl
source $script_path/9_0_write_stream.tcl