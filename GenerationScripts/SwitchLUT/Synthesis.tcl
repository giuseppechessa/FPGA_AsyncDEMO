proc Synthesis { WIDTH Name} {
	set OutDir "OutputFoder"
	#set Const ./Sources/Constraints/FloorPlans/FloorPlan_X${locX}Y${locY}.xdc
	set FILES [concat \
	[glob ./SourcesLUT/Design/Ipm/*.sv] \
	[glob ./SourcesLUT/Design/Opm/*.sv] \
	[glob ./SourcesLUT/Design/Mousetrap/*.sv] \
	./SourcesLUT/Design/Switch.sv \
	./SourcesLUT/Design/TopModule.sv \
	./SourcesLUT/Design/Net.sv]


	read_verilog -sv $FILES
	#read_xdc $Const -mode out_of_context
	#start design in out of context mode single switch
	synth_design -top TopModule_Switch -part xc7a200tisbv484-1L -name $Name -flatten_hierarchy rebuilt -generic WIDTH=$WIDTH -mode out_of_context
}
