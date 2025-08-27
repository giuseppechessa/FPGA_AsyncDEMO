source ./GenerationScripts/Pause.tcl -notrace
source ./GenerationScripts/SwitchOnlyRouting/Synthesis.tcl -notrace
set WIDTH 32
		set Name Switch_MINMAXOR
		pause "Implementation of $Name" 100
		Synthesis $WIDTH $Name 
		pause "Starting MaxPerformance Implementation" 100
		#start_implementation #MaxPerformance
		source ./GenerationScripts/SwitchOnlyRouting/MaxPerformanceScript.tcl -notrace
		pause "Starting Functional Implementation" 100
		source ./GenerationScripts/SwitchOnlyRouting/FunctionalScript.tcl -notrace
		pause "Writing Checkpoint" 100
		write_checkpoint OutputFolder/$Name -force
		#close_project

