proc Synthesis { WIDTH Name} {
	set OutDir "OutputFoder"
	#set Const ./Sources/Constraints/FloorPlans/FloorPlan_X${locX}Y${locY}.xdc
	set FILES [concat \
	[glob ./Sources/Design/Ipm/*.sv] \
	[glob ./Sources/Design/Opm/*.sv] \
	[glob ./Sources/Design/Mousetrap/*.sv] \
	./Sources/Design/Switch.sv \
	./Sources/Design/TopModule.sv \
	./Sources/Design/Net.sv]


	read_verilog -sv $FILES
	#read_xdc $Const -mode out_of_context
	#start design in out of context mode single switch
	synth_design -top TopModule_Switch -part xc7a200tisbv484-1L -name $Name -flatten_hierarchy rebuilt -generic WIDTH=$WIDTH -mode out_of_context
	#-rtl
}
