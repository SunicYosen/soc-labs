# Script step 1 - Data Setup and Basic Flow
#
exec rm -rf $work_path/$top.mw
#
############################################################
# Create Milkyway Design Library
############################################################
create_mw_lib $work_path/$top.mw -open -technology $tech_file -mw_reference_library  "$mw_path/sram_4kx64 $mw_path/sram_8kx32 $mw_path/saed32nm_rvt_1p9m"

############################################################
# Load the netlist, constraints and controls.
############################################################
import_designs $verilog_file -format verilog -top $top

############################################################
# Load TLU+ files
############################################################
set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map  $tlup_map

check_library
check_tlu_plus_files
list_libs


source 1_2_derive_pg.tcl
check_mv_design -power_nets

read_sdc $sdc_file
# set_wire_load_mode segmented
# set_wire_load_model -name smic18_wl10 -library slow

check_timing
report_timing_requirements
report_disable_timing
report_case_analysis
report_clock
report_clock -skew
redirect -tee $reports_path/data_setup.timing { report_timing }

source 1_3_opt_ctrl.tcl
source 1_4_zic_timing.tcl
#exec cat zic.timing
#remove_ideal_network [get_ports scan_en]
save_mw_cel -as 1_datasetup
