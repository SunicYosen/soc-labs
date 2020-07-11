# Create corners and P/G pads
#Need To Change
create_cell {CornerLL CornerLR CornerTR CornerTL} PCORNERW
create_cell {vss1_l vss1_r vss1_t vss1_b} PVSS1W
create_cell {vdd1_l vdd1_r vdd1_t vdd1_b} PVDD1W
create_cell {vss2_l vss2_r vss2_t vss2_b} PVSS2W
create_cell {vdd2_l vdd2_r vdd2_t vdd2_b} PVDD2W

# Define corner pad locations
set_pad_physical_constraints -pad_name "CornerTL" -side 1
set_pad_physical_constraints -pad_name "CornerTR" -side 2
set_pad_physical_constraints -pad_name "CornerLR" -side 3
set_pad_physical_constraints -pad_name "CornerLL" -side 4

# Define signal and PG pad locations

# Left side
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[0]} -side 1 -order 1
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[1]} -side 1 -order 2
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[2]} -side 1 -order 3
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[3]} -side 1 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[4]} -side 1 -order 5
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[5]} -side 1 -order 6
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[6]} -side 1 -order 7
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[7]} -side 1 -order 8
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[8]} -side 1 -order 9
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[9]} -side 1 -order 10
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[10]} -side 1 -order 11
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[11]} -side 1 -order 12
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[12]} -side 1 -order 13
set_pad_physical_constraints -pad_name "vdd2_l" -side 1 -order 1
set_pad_physical_constraints -pad_name "vdd1_l" -side 1 -order 2
set_pad_physical_constraints -pad_name "vss1_l" -side 1 -order 3
set_pad_physical_constraints -pad_name "vss2_l" -side 1 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[13]} -side 1 -order 18
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[14]} -side 1 -order 19
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[15]} -side 1 -order 20
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[16]} -side 1 -order 21
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[17]} -side 1 -order 22
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[18]} -side 1 -order 23
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[19]} -side 1 -order 24
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[20]} -side 1 -order 25
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[21]} -side 1 -order 26
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[22]} -side 1 -order 27
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[23]} -side 1 -order 28
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[24]} -side 1 -order 29
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[25]} -side 1 -order 30


# Top side
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[26]} -side 2 -order 1
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[27]} -side 2 -order 2
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[28]} -side 2 -order 3
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[29]} -side 2 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[30]} -side 2 -order 5
set_pin_physical_constraints -pin_name {i_icb_cmd_addr[31]} -side 2 -order 6
set_pin_physical_constraints -pin_name {i_icb_cmd_valid} -side 2 -order 7
set_pin_physical_constraints -pin_name {i_icb_cmd_read} -side  2 -order 8
set_pin_physical_constraints -pin_name {i_icb_rsp_ready} -side 2 -order 9
set_pin_physical_constraints -pin_name {clk} -side 2 -order 10
set_pin_physical_constraints -pin_name {rst_n} -side 2 -order 11
set_pin_physical_constraints -pin_name {i_icb_cmd_ready} -side 2 -order 12
set_pin_physical_constraints -pin_name {i_icb_rsp_valid} -side 2 -order 13
set_pad_physical_constraints -pad_name "vdd2_t" -side 2 -order 1
set_pad_physical_constraints -pad_name "vdd1_t" -side 2 -order 2
set_pad_physical_constraints -pad_name "vss1_t" -side 2 -order 3
set_pad_physical_constraints -pad_name "vss2_t" -side 2 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[0]} -side  2 -order 18
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[1]} -side  2 -order 19
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[2]} -side  2 -order 20
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[3]} -side  2 -order 21
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[4]} -side  2 -order 22
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[5]} -side  2 -order 23
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[6]} -side  2 -order 24
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[7]} -side  2 -order 25
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[8]} -side  2 -order 26
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[9]} -side  2 -order 27
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[10]} -side 2  -order 28
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[11]} -side 2  -order 29
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[12]} -side 2  -order 30

# Right side
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[13]} -side  3 -order 1
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[14]} -side  3 -order 2
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[15]} -side  3 -order 3
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[16]} -side  3 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[17]} -side  3 -order 5
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[18]} -side  3 -order 6
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[19]} -side  3 -order 7
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[20]} -side  3 -order 8
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[21]} -side  3 -order 9
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[22]} -side  3 -order 10
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[23]} -side  3 -order 11
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[24]} -side  3 -order 12
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[25]} -side  3 -order 13
set_pad_physical_constraints -pad_name "vdd2_r" -side 3 -order 1
set_pad_physical_constraints -pad_name "vdd1_r" -side 3 -order 2
set_pad_physical_constraints -pad_name "vss1_r" -side 3 -order 3
set_pad_physical_constraints -pad_name "vss2_r" -side 3 -order 4
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[26]} -side  3 -order 18
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[27]} -side  3 -order 19
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[28]} -side  3 -order 20
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[29]} -side  3 -order 21
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[30]} -side  3 -order 22
set_pin_physical_constraints -pin_name {i_icb_cmd_wdata[31]} -side  3 -order 23
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[0]}  -side  3 -order 24
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[1]}  -side  3 -order 25
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[2]}  -side  3 -order 26
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[3]}  -side  3 -order 27
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[4]}  -side  3 -order 28
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[5]}  -side  3 -order 29
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[6]}  -side  3 -order 30


# Bottom side
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[7]} -side  4 -order 1
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[8]} -side  4 -order 2
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[9]} -side  4 -order 3
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[10]} -side  4 -order 4
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[11]} -side  4 -order 5
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[12]} -side  4 -order 6
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[13]} -side  4 -order 7
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[14]} -side  4 -order 8
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[15]} -side  4 -order 9
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[16]} -side  4 -order 10
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[17]} -side  4 -order 11
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[18]} -side  4 -order 12
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[19]} -side  4 -order 13
set_pad_physical_constraints -pad_name "vdd2_b" -side 4 -order 1
set_pad_physical_constraints -pad_name "vdd1_b" -side 4 -order 2
set_pad_physical_constraints -pad_name "vss1_b" -side 4 -order 3
set_pad_physical_constraints -pad_name "vss2_b" -side 4 -order 4
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[20]} -side  4 -order 18
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[21]} -side  4 -order 19
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[22]} -side  4 -order 20
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[23]} -side  4 -order 21
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[24]} -side  4 -order 22
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[25]} -side  4 -order 23
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[26]} -side  4 -order 24
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[27]} -side  4 -order 25
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[28]} -side  4 -order 26
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[29]} -side  4 -order 27
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[30]} -side  4 -order 28
set_pin_physical_constraints -pin_name {i_icb_rsp_rdata[31]} -side  4 -order 29

