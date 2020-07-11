#==========================
# Read verilog
#==========================

set rtl_dir $src_path/rtl

#------------------------------------------------------------------------
# analyze: 
# 1. Reads an HDL source file
# 2. Checks for errors without building generic logic for the design
# 3. Creates HDL library objects in an HDL-independent intermediate format
# 4. Stores the intermediate files in a location you define
#------------------------------------------------------------------------
analyze -format verilog [glob $rtl_dir/*.v]

#------------------------------------------------------------------------
# 1. Translates the design into a technology-independent design (GTECH) from the
#    intermediate files produced during analysis
# 2. Allows changing of parameter values defined in the source code
# 3. Allows VHDL architecture selection
# 4. Replaces the HDL arithmetic operators in the code with DesignWare components
# 5. Automatically executes the link command, which resolves design references
#------------------------------------------------------------------------
elaborate $top

#------------------------------------------------------------------------
# Other method
#------------------------------------------------------------------------
#------------------------------------------------------------------------
# Read_file: The read_file command analyzes the design and translates it
#            into a technology-independent (GTECH) design in a single step
#------------------------------------------------------------------------
# read_file -format verilog [glob $rtl_dir/core/*.v $rtl_dir/general/*.v]
# 
#------------------------------------------------------------------------
# link: The link command uses the link_library and search_path system 
#       variables and the local_link_library attribute to resolve 
#       design references.
#------------------------------------------------------------------------
# link

uniquify
check_design
