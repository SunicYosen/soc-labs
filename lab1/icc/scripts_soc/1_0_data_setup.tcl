#this is the setting for csmc130nm technology
#change to library V1.0
#

#----------------------------
# set top
#----------------------------
set top "conv_top"

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
set output_path  [file normalize "$work_path/outputs"]

if { [ file exists $work_path ] } {
    file delete -force $work_path
    file mkdir $work_path
} else {
    file mkdir $work_path
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

if { [file exists $output_path] } {
    file delete -force $output_path
    file mkdir $output_path
} else {
    file mkdir $output_path
}

set std_path      "$lib_path/db"
set io_path       "$lib_path/db"
set std_symb_path "$lib_path/db"
set io_symb_path  "$lib_path/db"

set tech_file_path "$lib_path/tf"

set search_path [list $std_path/ \
                      $std_symb_path/ \
                      $io_path/ \
                      $tech_file_path/ \
                      $io_symb_path/]

#target library-----------------------------------------------------------
set     target_library          [list saed32rvt_ff1p16vn40c.db sram_4kx64_ss_0p99v_0p99v_125c.db sram_8kx32_ss_0p99v_0p99v_125c.db]
set     io_library              ""
set     link_library            "* $target_library $io_library"
set     symbol_library          "* $target_library $io_library"

#----------------------------
# Physical Library settings
#----------------------------
set mw_path      "$lib_path/mw_lib"
set tech_file    "$lib_path/tf/saed32nm_1p9m_mw.tf"
set tlup_map     "$lib_path/tluplus/saed32nm_tf_itf_tluplus.map"
set tlup_max     "$lib_path/tluplus/saed32nm_1p9m_Cmax.tluplus"
set tlup_min     "$lib_path/tluplus/saed32nm_1p9m_Cmin.tluplus"
set verilog_file "$mapped_path/conv_top.mapped.v"
set sdc_file     "$mapped_path/conv_top.sdc"

#lappend search_path "/home/jfjiang/lib/smic_130nm/SCC013UG_HD_RVT_V0p1/synopsys/1.2v \
#		     /home/husai/SOCIPtest/lib \
#		     /home/jfjiang/lib/smic_130nm/SCC013UG_HD_RVT_V0p1/symbol"

#set_app_var target_library "scc013ug_hd_rvt_ss_v1p08_125c_basic.db"
#set_app_var io_library "pad.db"
#set_app_var link_library "* $target_library $io_library"
#set_app_var symbol_library "SCC013UG_HD_RVT_V0p1.sdb"


#create library
exec rm -rf $work_path/$top.mw
create_mw_lib  -technology  $tech_file                               \
               -mw_reference_library "$mw_path/sram_4kx64 $mw_path/sram_8kx32 $mw_path/saed32nm_rvt_1p9m" \
               -hier_separator {/}                                   \
               -bus_naming_style {[%d]}                              \
               -open $work_path/$top.mw

#/home/jfjiang/lib/smic_130nm/SP013D3_V1p6/apollo/SP013D3_V1p6_6MT

set_check_library_options -all

#set TLU+ files
set_tlu_plus_files   -max_tluplus   $tlup_max     \
                     -min_tluplus   $tlup_min     \
                     -tech2itf_map  $tlup_map
#                     -tech2itf_map  /home/library/wxsh/0d13um/VS013/BEView_STDIO/VS-CSMC-13-Tapeout-Kit-V0.5/TECH/CSMC013E_layer_m6.map

check_tlu_plus_files
list_libs

#import designs
import_designs -format verilog $verilog_file



derive_pg_connection -power_net VDD -power_pin VDD -ground_net GND -ground_pin GND
derive_pg_connection -power_net VDDH -power_pin VDDH -ground_net VSSH -ground_pin VSSH
derive_pg_connection -power_net VDD -ground_net GND -tie
check_mv_design -power_nets


read_sdc $sdc_file
check_timing
report_timing_requirements
report_disable_timing
report_case_analysis
report_clock -skew


set_fix_multiple_port_nets -all -buffer_constants
save_mw_cel -as 1_0_data_setup

#
