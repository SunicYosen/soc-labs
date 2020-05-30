#==========================
# Set up
#==========================

set top "e203_cpu_top"
set std_path $lib_path
set search_path [list $std_path/]

#-----------------------
# SYNTHETIC LIB
#-----------------------

#-----------------------
# Set up library
#-----------------------
set     target_library          saed32rvt_tt1p05v25c.db 
set     link_library            [list  "*" $target_library ]

#-----------------------
# Naming Rules
#-----------------------
define_name_rules BORG -type net -allowed "A-Z a-z 0-9" -first_restricted "_0-9\\" \
        -last_restricted "_0-9\\" -max_length 30
# List name rules.
report_name_rules BORG
# Specify the style to use in naming an individual port member 
set bus_naming_style {%s[%d]}

#-----------------------
# Others
#-----------------------
# Turn tri state nets from "tri" to "wire"
set verilogout_no_tri true
# Write out the gate level netlist so that all of the unused pins
set verilogout_show_unconnected_pins true
