set_write_stream_options -child_depth 100 -output_pin {text}
change_names -rules verilog -hierarchy
write_verilog -output $output_path/{$top}_routed.v
write_sdf -version 2.1 -significant_digits 6 $output_path/${top}_routed.sdf
write_stream -cells $top $output_path/$top.gds
