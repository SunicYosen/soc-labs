#====================================================
# Compile the design
#====================================================

#------------------------------------------------------------------------
# Disable both downward and upward propagation of constant and equal and
# opposite information across the hierarchy
#------------------------------------------------------------------------
set compile_preserve_subdesign_interfaces true

#------------------------------------------------------------------------
# Direct Design Compiler to preserve the registers. The default is true
#------------------------------------------------------------------------
set compile_delete_unloaded_sequential_cells true

#------------------------------------------------------------------------
# check_design: Checks the internal representation of the current design
#               for consistency and issues error and warning messages as 
#               appropriate.
#           
# check_timing: Checks the timing attributes placed on the current design.
#------------------------------------------------------------------------
parallel_execute [list "check_design > $log_path/check_design.log" \
                       "check_timing > $log_path/check_timing.log"]

#------------------------------------------------------------------------
# compile: The compile command runs DC Expert. DC Expert synthesizes your
#          HDL descriptions into optimized, technology-dependent, gate-
#          level designs. It supports a wide range of flat and hierarchical
#          design styles and can optimize both combinational and sequential
#          designs for area, timing, and power.
#------------------------------------------------------------------------
compile > $log_path/compile.log
