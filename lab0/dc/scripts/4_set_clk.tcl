#====================================================
# Definition of main clocks.
# 	1. Define clocks : SYS_CLK
# 	2. Define the clocks' uncertainty and transition etc.
# 	3. Define timing exceptions between clock domains.
#	4. Define drc free nets
#====================================================

#------------------------------------
# Define clock period
#------------------------------------
set CLK_PERIOD  4

#------------------------------------
# clock source definition
#------------------------------------
create_clock -name "sys_clk" -period $CLK_PERIOD [get_ports clk]


#------------------------------------
# uncertainty and transition time
#------------------------------------
set_clock_uncertainty -setup 0.5 sys_clk
set_clock_uncertainty -hold  0.5 sys_clk
set_clock_transition         0.5 sys_clk
set_dont_touch_network [get_clocks sys_clk]

#------------------------------------
# set drc free net
#------------------------------------
echo "set_ideal_network"
set_ideal_network [get_ports clk] -no_propagate
echo "set_ideal_network_end"

set_fix_hold sys_clk
