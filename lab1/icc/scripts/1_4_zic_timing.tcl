set_zero_interconnect_delay_mode true
redirect -tee $reports_path/data_setup_zic.timing { report_timing }
set_zero_interconnect_delay_mode false
