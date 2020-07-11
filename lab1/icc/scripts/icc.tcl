#====================================================
# Physical Design main script
#====================================================

#----------------------------
# set top
#----------------------------
set top "cnn_acc"

#----------------------------
# Multi Cores
#----------------------------
set_host_options -max_cores 4

#----------------------------
# Set Path
#----------------------------
set script_path  [file dirname [file normalize [info script]]]
set lib_path     [file normalize "$script_path/../lib"]
set mapped_path  [file normalize "$script_path/../mapped"]
set work_path    [file normalize "$script_path/../../work/$top/icc"]
set reports_path [file normalize "$work_path/reports"]
set log_path     [file normalize "$work_path/log"]
set output_path  [file normalize "$work_path/output"]


#----------------------------
# Logic Library settings
#----------------------------
lappend search_path "$lib_path/db/" $script_path/ $mapped_path
set_app_var target_library [list saed32rvt_ff1p16vn40c.db sram_4kx64_ss_0p99v_0p99v_125c.db sram_8kx32_ss_0p99v_0p99v_125c.db]
set_app_var link_library "* $target_library"
# set_min_library slow.db -min_version fast.db
# set_min_library SP018W_V1p5_max.db -min_version SP018W_V1p5_min.db


#----------------------------
# Physical Library settings
#----------------------------
set mw_path "$lib_path/mw_lib"
set tech_file "$lib_path/tf/saed32nm_1p9m_mw.tf"
set tlup_map "$lib_path/tluplus/saed32nm_tf_itf_tluplus.map"
set tlup_max "$lib_path/tluplus/saed32nm_1p9m_Cmax.tluplus"
set tlup_min "$lib_path/tluplus/saed32nm_1p9m_Cmin.tluplus"
set verilog_file "$mapped_path/cnn_acc.mapped.v"
set sdc_file "$mapped_path/cnn_acc.sdc"

source 1_1_run_data_setup.tcl
source 2_1_run_design_planning.tcl
source 3_1_run_placement.tcl
source 4_1_run_cts.tcl
source 5_1_run_route.tcl
source 6_1_run_finishing.tcl