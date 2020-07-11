create_die_area  \
        -poly { {0.000 0.000} {600.000 0.000} {600.000 600.00} {0.000 600.00} }

source $script_path/2_1_pad.tcl

create_floorplan -control_type aspect_ratio -start_first_row -flip_first_row -left_io2core 20 -bottom_io2core 20 -right_io2core 20 -top_io2core 20

save_mw_cel -as 2_floorplanW

