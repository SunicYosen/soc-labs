#====================================================
# Logic synthesis main script
#====================================================

#----------------------------
# set top
#----------------------------
set top "conv_top"

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
set work_path    [file normalize "$script_path/../../work/$top/dc"]
set lib_path     [file normalize "$script_path/../lib"]
set src_path     [file normalize "$script_path/../../src_dc"]
set reports_path [file normalize "$work_path/reports"]
set mapped_path  [file normalize "$work_path/mapped"]
set log_path     [file normalize "$work_path/log"]

if { [ file exists $mapped_path ] } {
    file delete -force $mapped_path
    file mkdir $mapped_path
} else {
    file mkdir $mapped_path
}

if { [file exists $reports_path] } {
    file delete -force $reports_path
    file mkdir $reports_path
} else {
    file mkdir $reports_path
}

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

#-------------------------------------
# Compile
#-------------------------------------
source $script_path/6_compile.tcl

#-------------------------------------
# Optimization
#-------------------------------------
source $script_path/7_optimization.tcl

#-----------------------------------------
# Give the report fot a varity of elements
#-----------------------------------------
source $script_path/8_write_file.tcl
