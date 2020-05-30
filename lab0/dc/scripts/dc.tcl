#====================================================
# Logic synthesis main script
#====================================================

#----------------------------
# Multi Cores
#----------------------------
set_host_options -max_cores 4

# set_units -capacitance pf
# set_units -time ns
# set_units -resistance ohm

#----------------------------
# Set Path
#----------------------------
set script_path  [file dirname [file normalize [info script]]]
set work_path    [file normalize "$script_path/../work"]
set lib_path     [file normalize "$script_path/../lib"]
set src_path     [file normalize "$script_path/../rtl"]
set reports_path [file normalize "$work_path/reports"]
set mapped_path  [file normalize "$work_path/mapped"]
set log_path     [file normalize "$work_path/log"]

if { [file exists $log_path] } {
    file delete -force $log_path
    file mkdir $log_path
} else {
    file mkdir $log_path
}

#----------------------------
# Set library
#----------------------------
source $script_path/1_setup.tcl

#----------------------------
# Read Design Files
#----------------------------
source $script_path/2_read_file.tcl

#------------------------------------
# Set logical design rule constraint
#------------------------------------
source $script_path/3_set_drc.tcl

#------------------------------------
# Set clk & Design rule for clk net
#------------------------------------
source $script_path/4_set_clk.tcl

#------------------------------------
# Specify inout pad latency
#------------------------------------
source $script_path/5_set_io_delay.tcl
set compile_implementation_selection true
set compile_preserve_subdesign_interfaces true

# set hdlin_preserve_sequential true
# set compile_delete_unloaded_sequential_cells false

set_fix_multiple_port_nets -all -buffer_constants

set ports_clock_root [filter_collection [get_attribute [get_clocks] sources] object_class==port]
group_path -name reg2out -from [all_registers -clock_pins] -to [all_outputs] 
group_path -name in2reg -from [remove_from_collection [all_inputs] $ports_clock_root] -to [all_registers -data_pins]
group_path -name in2out -from [remove_from_collection [all_inputs] $ports_clock_root] -to [all_outputs]

check_timing > $log_path/check_timing.log
compile > $log_path/compile.log

#-------------------------------------
# Optimization
#-------------------------------------
source $script_path/6_optimization.tcl

#-----------------------------------------
# Give the report fot a varity of elements
#-----------------------------------------
source $script_path/7_write_file.tcl

exit
