#==========================
# Write Mapped and reports
#==========================

#------------------------------------
# Make Directory
#------------------------------------
set mapped_dir  $mapped_path
set reports_dir $reports_path
if { [ file exists $mapped_dir ] } {
    file delete -force $mapped_dir
    file mkdir $mapped_dir
} else {
    file mkdir $mapped_dir
}

if { [file exists $reports_dir] } {
    file delete -force $reports_dir
    file mkdir $reports_dir
} else {
    file mkdir $reports_dir
}

#------------------------------------
# Write mapped file
#------------------------------------
write_file -hierarchy -format ddc -output $mapped_dir/$top.mapped.ddc
write_file -hierarchy -format verilog -output $mapped_dir/$top.mapped.v
write_sdf $mapped_dir/$top.sdf
write_sdc -version 1.9 $mapped_dir/$top.sdc

#------------------------------------
# Write reports
#------------------------------------
report_timing > $reports_dir/$top.timing_rpts.rpts
report_area > $reports_dir/$top.area_rpts.rpts
report_constrain -all_violators > $reports_dir/$top.all_violators.rpts
report_net_fanout >  $reports_dir/$top.net_fanout.rpts
