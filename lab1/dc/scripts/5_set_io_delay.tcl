#====================================================
# 1.Set drc and load
# 2.Set multicycle path and false path
#====================================================

current_design $top

#--------------------------------------------
# Set wire load model and mode
#--------------------------------------------
# set_wire_load_model -name Zero -min
# set_wire_load_mode SRAMtest_top

#--------------------------------------------
# Input and output port timing specifications
#--------------------------------------------
# set_input_delay  -clock clk 0.5 [all_inputs]
set_input_delay -clock clk 0.5 [remove_from_collection [all_inputs][get_port "clk"]]
set_output_delay -clock clk 0.5 [all_outputs]

#--------------------------------------------
# Define the drive resistance
#--------------------------------------------
set_drive 0.2 [all_inputs]

#--------------------------------------------
# Set a capacitive load value on input and 
# output ports of the design,
#--------------------------------------------
set_load 0.2 [all_outputs]

#--------------------------------------------
# Specify point-to-point delays.
#--------------------------------------------
# set_min_delay 1.6 -from i_pad_clk/D -to i_clk_b/Z
# set_min_delay 1.6 -from pad_clk -to clkb

#--------------------------------------------
# Set operating conditions
# Specify different operating conditions 
#     for different scenarios
#--------------------------------------------
# set_operating_conditions typical

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
# set_fix_multiple_port_nets -all -buffer_constants

#---------------------------------------------------------------------
# Define ports_clock_root val
#---------------------------------------------------------------------
set ports_clock_root [filter_collection [get_attribute [get_clocks] sources] object_class==port]

#---------------------------------------------------------------------
# Create path groups
# - Control the optimization of your design
# - Optimize near-critical paths
# - Optimize all paths
#---------------------------------------------------------------------
group_path -name reg2out -from [all_registers -clock_pins] -to [all_outputs]
group_path -name in2reg -from [remove_from_collection [all_inputs] $ports_clock_root] -to [all_registers -data_pins]
group_path -name in2out -from [remove_from_collection [all_inputs] $ports_clock_root] -to [all_outputs]
