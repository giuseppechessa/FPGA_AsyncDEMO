# FPGA_AsyncDEMO
Repository with all the files for the summer workshop demo
# Brief List  of commands used during the tutorial
The demo will occur with 3 terminal tabs running commands in parallel
## First Terminal Tab
launch vivado with: \
`vivado -mode tcl -nolog -nojou`\
Inside Vivado launch the commands: \
`source ./GenerationScripts/SwitchLUT/CreateSwitch.tcl`\
When is finished launch: \
`source ./Scripts/Switch_scripts/Verifica.tcl`\
`Verifica`

## Second Terminal Tab
launch vivado with: \
`vivado -mode tcl -nolog -nojou`\
Inside Vivado launch the commands: \
`source ./GenerationScripts/SwitchPlaceAndRoute/CreateSwitch.tcl`\
When is finished launch: \
`source ./Scripts/Switch_scripts/Verifica.tcl`\
`Verifica`

## Third Terminal Tab
launch vivado with: \
`vivado -mode tcl -nolog -nojou`\
Inside Vivado launch the commands: \
`source ./GenerationScripts/SwitchSoloReq/Synthesis.tcl`\
`Synthesis 32 SWITCH_ECO`\
`start_gui`\
Here we will look at the result of the synthesis and then we will close the gui \
`stop_gui`\
`close_project`\
`open_checkpoint ./SWITCH_ECO_MAX.dcp`\
`start_gui`\
Here we will look at the result of the place and route and then we will close the gui \
`stop_gui`\
`source ./Scripts/Switch_scripts/Verifica.tcl`\
`Verifica`\
`get_timing_paths -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] -max_paths 100`\
`get_property DATAPATH_DELAY -min  [get_timing_paths -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] -max_paths 1000]`\
`get_property DATAPATH_DELAY -min  [get_timing_paths -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] -max_paths 1000 -hold]`\
`get_property DATAPATH_DELAY -max  [get_timing_paths -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I1] -max_paths 1000 -hold ]`\
`get_property DATAPATH_DELAY -max  [get_timing_paths -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I1] -max_paths 1000] `\
`route_design -pins [get_pins mySwitch/genblk1[0].IPMS/PRC/XOR/I0] -unroute`\
`route_design -pins [get_pins mySwitch/genblk1[0].IPMS/PRC/XOR/I0] -min_delay 500`\
`route_design -pins [get_pins mySwitch/genblk1[0].IPMS/PRC/XOR/I0] -unroute `\
`route_design -pins [get_pins mySwitch/genblk1[0].IPMS/PRC/XOR/I0] -min_delay 1`\
`source ./GenerationScripts/SwitchSoloReq/Bundle.tcl`\
`FixBundle`\
`Verifica`\
