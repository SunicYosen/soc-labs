#==========================
# Optimization
#==========================

current_design $top

#------------------------------------
# Timing optimization
#------------------------------------
# set_ultra_optimization true
# compile_ultra
# group_path -name all_reg -critical_range 2.0 -to [all_registers] -weight 10
compile -map_effort low -incremental_mapping 
# compile_ultra -timing_high_effort_script

#------------------------------------
# Area optimization
#------------------------------------
# set_ultra_optimization false
# set_max_area 200000
# compile -incremental_mapping -area_effort high 
# compile -incremental_mapping -area_effort high 

#------------------------------------
# DRC optimization
#------------------------------------
#------------------
# insert buffers
#------------------
foreach_in_collection itr [get_designs * -h] {
     current_design $itr
     set_fix_multiple_port_net -all -buffer
     set_fix_multiple_port_net -output -buffer
     set_fix_multiple_port_net -feedthr -buffer
     set_fix_multiple_port_net -buffer     
}

current_design $top

#------------------------------------------------------------------------
# To perform an incremental compile
# The option incremental_mapping enables only gate-level optimizations.
# - Gates are not converted back to the generic technology (GTECH) level.
# - Flattening and structuring are not done on the mapped portion of the design.
# - Implementations for DesignWare operators are reselected if optimization costs
#   can be improved.
#------------------------------------------------------------------------
# compile -incremental_mapping 
# compile -incremental_mapping
# compile -incremental_mapping
