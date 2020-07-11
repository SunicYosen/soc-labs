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
set CLK_PERIOD  5

#------------------------------------
# Clock source definition
#------------------------------------
create_clock -name "clk" -period $CLK_PERIOD [get_ports clk]

#------------------------------------
# Uncertainty and transition time
#------------------------------------
set_clock_uncertainty -setup 0.5 clk
set_clock_uncertainty -hold  0.5 clk
set_clock_transition         0.5 clk
set_dont_touch_network [get_clocks clk]

#------------------------------------
# Set drc free net
#------------------------------------
set_ideal_network [get_ports clk] -no_propagate

#------------------------------------------------------------------------
# Related clock to fix hold violations at registers during compilation.
#------------------------------------------------------------------------
set_fix_hold clk
