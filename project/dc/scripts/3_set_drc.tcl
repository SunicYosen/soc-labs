#==========================
# Set DRC on SPI
# DRC: Design Rule Check
#==========================

#---------------------------------------------------------------------
# Change the wire load model or mode specified in a logic library
# Override auto wire load selection
#---------------------------------------------------------------------
# set_wire_load_model -name reference_area_10000000
# set_wire_load_mode enclosed

#---------------------------------------------------------------------
# Enable design rule fixing does not affect the ideal timing 
# properties of clock nets
#---------------------------------------------------------------------
set_auto_disable_drc_nets -constant false

#---------------------------------------------------------------------
# Prevent multiple-port connections
# Feedthroughs:
#     Specify the -feedthroughs option to insert buffers so that input
#     ports are isolated from output ports. A feedthrough net occurs 
#     when an input port and output port are connected directly with
#     no intervening logic.
# Multiple output ports:
#     Specify the -outputs option to insert buffers so that no cell 
#     driver pin drives more than one output port.
# Constants: 
#     Specify the -constants option to duplicate constant logic so 
#     that no constant drives more than one output port. Alternatively,
#     you can use the -buffer_constants option to buffer logic constants
#     instead of duplicating them.
#---------------------------------------------------------------------
# set_fix_multiple_port_nets -all -buffer_constant

#---------------------------------------------------------------------
# Controls whether the compile command tries to identify and remove 
# constant registers and propagate the constant value throughout the design.
# 
# Constant propagation occurs for both unmapped and mapped designs when
# the compile_seqmap_propagate_constants variable is set to true. True 
# by default.
# 
# While,disable constant register removal completely when flase
#---------------------------------------------------------------------
set compile_seqmap_propagate_constants false

#---------------------------------------------------------------------
# For each design
#---------------------------------------------------------------------
foreach_in_collection itr [get_designs * -h] { 
    #--------------------------------------------------------
    # The maximum transition time for a net is the longest time 
    # required for its driving pin to change logic values. 
    #-------------------------------------------------------- 
    set_max_transition 0.5 $itr

    #--------------------------------------------------------
    # sets the maximum allowable fanout load
    #--------------------------------------------------------
    set_max_fanout  20  $itr

    set_auto_disable_drc_nets -constant false
    set compile_seqmap_propagate_constants false
}

current_design $top
