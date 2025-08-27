source ./GenerationScripts/Pause.tcl -notrace
source ./GenerationScripts/SwitchLUT/Synthesis.tcl -notrace
set WIDTH 32
set Name Switch_LUT
set Continue "Y"
pause "Implementation of $Name" 100

set Out "Violazione"
set i 0
while {[string equal $Out "Violazione"] && [string equal $Continue "Y"]} {

	Synthesis $WIDTH $Name
	pause "Starting MaxPerformance Implementation" 100
	#start_implementation #MaxPerformance
	source ./GenerationScripts/SwitchLUT/MaxPerformanceScript.tcl -notrace
	pause "Starting Functional Implementation"
	set Out [source ./ScriptsLUT/Switch_scripts/FunctionalPerfLUT.tcl -notrace]
	write_checkpoint ./IterLUT -force
	close_project
	set i [expr $i+1]
}
open_checkpoint ./IterLUT.dcp
pause "Writing Checkpoint"
write_checkpoint OutputFolder/$Name -force
#close_project
