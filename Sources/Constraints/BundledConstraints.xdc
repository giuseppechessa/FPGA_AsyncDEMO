group_path -name "mySwitch/genblk1[0].IPMS" -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*/*] 
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/GE] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[5].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*[3].RouteAnd/I1] 0


set_property BEL SLICEL.DFF [get_cells mySwitch/genblk1[0].IPMS/input_pipe/req_latch] 
set_property LOC SLICE_X87Y131 [get_cells mySwitch/genblk1[0].IPMS/input_pipe/req_latch] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/XOR] 
set_property LOC SLICE_X87Y128 [get_cells mySwitch/genblk1[0].IPMS/PRC/XOR] 
set_property LOCK_PINS {I0:A5 I1:A4} [get_cells mySwitch/genblk1[0].IPMS/PRC/XOR] 
set_property BEL SLICEL.A5LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOC SLICE_X87Y131 [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOCK_PINS {I0:A3 I1:A5} [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOC SLICE_X87Y131 [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOCK_PINS {I0:A3 I1:A4} [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property BEL SLICEL.D6LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOC SLICE_X86Y132 [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A6} [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property BEL SLICEL.B6LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOC SLICE_X87Y132 [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property BEL SLICEL.B6LUT [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOC SLICE_X86Y129 [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property FIXED_ROUTE { { CLBLL_L_A CLBLL_LOGIC_OUTS8  { NR1BEG0 NN2BEG0 IMUX0 CLBLL_L_A3 }   { NW6BEG0 NL1BEG_N3 EE2BEG3 IMUX47 CLBLL_LL_D5 }  NL1BEG_N3  { NL1BEG2 IMUX12 CLBLL_LL_B6 }  NN2BEG3 NL1BEG2 NR1BEG2 IMUX13 CLBLL_L_B6 }  } [get_nets mySwitch/genblk1[0].IPMS/PRC/PRC_enable] 


set_min_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] 0.993
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] 4.688000000000001


group_path -name "mySwitch/genblk1[1].IPMS" -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*/*] 
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/GE] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[5].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*[3].RouteAnd/I1] 0


set_property BEL SLICEL.DFF [get_cells mySwitch/genblk1[1].IPMS/input_pipe/req_latch] 
set_property LOC SLICE_X83Y136 [get_cells mySwitch/genblk1[1].IPMS/input_pipe/req_latch] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/XOR] 
set_property LOC SLICE_X83Y128 [get_cells mySwitch/genblk1[1].IPMS/PRC/XOR] 
set_property LOCK_PINS {I0:A5 I1:A2} [get_cells mySwitch/genblk1[1].IPMS/PRC/XOR] 
set_property BEL SLICEL.A5LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOC SLICE_X81Y136 [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOCK_PINS {I0:A3 I1:A4} [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[0].RouteAnd] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOC SLICE_X81Y136 [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOCK_PINS {I0:A3 I1:A5} [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[1].RouteAnd] 
set_property BEL SLICEL.D6LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOC SLICE_X83Y136 [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A4} [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[4].RouteAnd] 
set_property BEL SLICEL.C6LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOC SLICE_X83Y136 [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[2].RouteAnd] 
set_property BEL SLICEL.C6LUT [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOC SLICE_X82Y133 [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[1].IPMS/PRC/genblk1[3].RouteAnd] 
set_property FIXED_ROUTE { { CLBLL_L_A CLBLL_LOGIC_OUTS8  { NN6BEG0 NN2BEG0 BYP_ALT0 BYP_BOUNCE0  { IMUX_L34 CLBLL_L_C6 }  IMUX_L42 CLBLL_L_D6 }   { NW2BEG0 NN6BEG0 NR1BEG0 IMUX0 CLBLM_L_A3 }  WW2BEG0 NE6BEG1 NR1BEG1 IMUX_L35 CLBLL_LL_C6 }  } [get_nets mySwitch/genblk1[1].IPMS/PRC/PRC_enable] 


set_min_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*.RouteAnd/I0] 0.8943500000000001
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*.RouteAnd/I0] 4.499750000000001


group_path -name "mySwitch/genblk1[2].IPMS" -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*/*] 
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/GE] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[5].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*[3].RouteAnd/I1] 0


set_property BEL SLICEL.DFF [get_cells mySwitch/genblk1[2].IPMS/input_pipe/req_latch] 
set_property LOC SLICE_X78Y134 [get_cells mySwitch/genblk1[2].IPMS/input_pipe/req_latch] 
set_property BEL SLICEL.B6LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/XOR] 
set_property LOC SLICE_X78Y132 [get_cells mySwitch/genblk1[2].IPMS/PRC/XOR] 
set_property LOCK_PINS {I0:A5 I1:A1} [get_cells mySwitch/genblk1[2].IPMS/PRC/XOR] 
set_property BEL SLICEM.D6LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOC SLICE_X80Y135 [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A6} [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[4].RouteAnd] 
set_property BEL SLICEL.B6LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOC SLICE_X79Y128 [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[1].RouteAnd] 
set_property BEL SLICEL.A5LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOC SLICE_X79Y133 [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A3} [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[0].RouteAnd] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOC SLICE_X79Y133 [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A5} [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[2].RouteAnd] 
set_property BEL SLICEL.C6LUT [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOC SLICE_X78Y130 [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[2].IPMS/PRC/genblk1[3].RouteAnd] 
set_property FIXED_ROUTE { { CLBLL_LL_B CLBLL_LOGIC_OUTS13  { NR1BEG1 IMUX_L10 CLBLL_L_A4 }   { NN2BEG1 NE2BEG1 NL1BEG0 IMUX47 CLBLM_M_D5 }  SS2BEG1  { SR1BEG2 SL1BEG2 IMUX_L13 CLBLL_L_B6 }  IMUX_L35 CLBLL_LL_C6 }  } [get_nets mySwitch/genblk1[2].IPMS/PRC/PRC_enable] 


set_min_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*.RouteAnd/I0] 1.2160000000000002
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*.RouteAnd/I0] 5.113499999999999


group_path -name "mySwitch/genblk1[3].IPMS" -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*/*] 
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/GE] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[5].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*[3].RouteAnd/I1] 0


set_property BEL SLICEM.DFF [get_cells mySwitch/genblk1[3].IPMS/input_pipe/req_latch] 
set_property LOC SLICE_X72Y132 [get_cells mySwitch/genblk1[3].IPMS/input_pipe/req_latch] 
set_property BEL SLICEM.A6LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/XOR] 
set_property LOC SLICE_X70Y131 [get_cells mySwitch/genblk1[3].IPMS/PRC/XOR] 
set_property LOCK_PINS {I0:A5 I1:A1} [get_cells mySwitch/genblk1[3].IPMS/PRC/XOR] 
set_property BEL SLICEL.D5LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOC SLICE_X77Y133 [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A3} [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[0].RouteAnd] 
set_property BEL SLICEL.D6LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOC SLICE_X77Y133 [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A5} [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[3].RouteAnd] 
set_property BEL SLICEM.B6LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOC SLICE_X72Y135 [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A6} [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[1].RouteAnd] 
set_property BEL SLICEL.D6LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOC SLICE_X71Y134 [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[2].RouteAnd] 
set_property BEL SLICEM.B6LUT [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOC SLICE_X70Y134 [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A6} [get_cells mySwitch/genblk1[3].IPMS/PRC/genblk1[4].RouteAnd] 
set_property FIXED_ROUTE { { CLBLM_M_A CLBLM_LOGIC_OUTS12  { EE4BEG0 NN2BEG0 NL1BEG_N3 IMUX_L37 CLBLM_L_D4 }   { WR1BEG1 NN2BEG1 NE2BEG1 IMUX_L42 CLBLM_L_D6 }  NR1BEG0 NN2BEG0  { NE2BEG0 IMUX24 CLBLM_M_B5 }  IMUX_L24 CLBLM_M_B5 }  } [get_nets mySwitch/genblk1[3].IPMS/PRC/PRC_enable] 


set_min_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*.RouteAnd/I0] 0.9016000000000003
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*.RouteAnd/I0] 4.1021


group_path -name "mySwitch/genblk2[0].IPMS" -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*/*] 
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/GE] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[0].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[5].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[6].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[7].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[8].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[9].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[10].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[11].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[3].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[0].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[1].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[2].RouteAnd/I1] 0
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*[12].Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*[3].RouteAnd/I1] 0


set_property BEL SLICEM.DFF [get_cells mySwitch/genblk2[0].IPMS/input_pipe/req_latch] 
set_property LOC SLICE_X88Y129 [get_cells mySwitch/genblk2[0].IPMS/input_pipe/req_latch] 
set_property BEL SLICEL.A6LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/XOR] 
set_property LOC SLICE_X87Y129 [get_cells mySwitch/genblk2[0].IPMS/PRC/XOR] 
set_property LOCK_PINS {I0:A5 I1:A4} [get_cells mySwitch/genblk2[0].IPMS/PRC/XOR] 
set_property BEL SLICEM.B5LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOC SLICE_X88Y130 [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A3} [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[0].RouteAnd] 
set_property BEL SLICEM.B6LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOC SLICE_X88Y130 [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property LOCK_PINS {I0:A4 I1:A5} [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[4].RouteAnd] 
set_property BEL SLICEL.C6LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOC SLICE_X91Y130 [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property LOCK_PINS {I0:A6 I1:A5} [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[3].RouteAnd] 
set_property BEL SLICEM.D6LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOC SLICE_X88Y130 [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A6} [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[2].RouteAnd] 
set_property BEL SLICEM.C6LUT [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOC SLICE_X88Y130 [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property LOCK_PINS {I0:A5 I1:A1} [get_cells mySwitch/genblk2[0].IPMS/PRC/genblk1[1].RouteAnd] 
set_property FIXED_ROUTE { { CLBLL_L_A CLBLL_LOGIC_OUTS8  { NE2BEG0 NL1BEG_N3 EL1BEG2 IMUX27 CLBLM_M_B4 }   { NR1BEG0 EE2BEG0 ER1BEG1 IMUX_L34 CLBLM_L_C6 }  EE2BEG0 NN2BEG0  { IMUX31 CLBLM_M_C5 }  IMUX47 CLBLM_M_D5 }  } [get_nets mySwitch/genblk2[0].IPMS/PRC/PRC_enable] 


set_min_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*.RouteAnd/I0] 0.9916500000000001
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*.RouteAnd/I0] 4.749349999999999


set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[0].OPMS/*.LatchBarrier/GE] 0.579 
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/*.Data_latch/D] 0 


set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[1].OPMS/*.LatchBarrier/GE] 0.564 
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/*.Data_latch/D] 0 


set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[2].OPMS/*.LatchBarrier/GE] 0.538 
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/*.Data_latch/D] 0 


set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[3].OPMS/*.LatchBarrier/GE] 0.656 
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/*.Data_latch/D] 0 


set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/*.Data_latch/GE] 0 
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk4[0].OPMS/*.LatchBarrier/GE] 0.603 
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/*.Data_latch/D] 0 


