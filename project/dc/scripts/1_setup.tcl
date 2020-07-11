#==========================
# Set up
#==========================

set top $top
set std_path $lib_path
set search_path [list $std_path/]

#-----------------------
# SYNTHETIC LIB
#-----------------------

#-----------------------
# Set up library
#-----------------------
set     target_library          [list saed32rvt_ss0p95v125c.db sram_8kx32_ss_0p99v_0p99v_125c.db sram_4kx64_ss_0p99v_0p99v_125c.db]
set     link_library            "* $target_library"

#-----------------------
# Naming Rules
#-----------------------
define_name_rules BORG -type net -allowed "A-Z a-z 0-9" -first_restricted "_0-9\\" \
        -last_restricted "_0-9\\" -max_length 30

#-----------------------
# List name rules.
report_name_rules BORG > $reports_path/name_rules.rpt

#---------------------------------------------------------------------
# Specify the style to use in naming an individual port member 
set bus_naming_style {%s[%d]}

#-----------------------
# Others
#-----------------------

#----------------------------------------------
# Turn tri state nets from "tri" to "wire"
set verilogout_no_tri true

#---------------------------------------------------------------------
# Write out the gate level netlist so that all of the unused pins
set verilogout_show_unconnected_pins true
