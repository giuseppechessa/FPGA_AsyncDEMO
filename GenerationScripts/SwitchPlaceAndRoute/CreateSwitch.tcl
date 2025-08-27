source ./GenerationScripts/Pause.tcl -notrace
source ./GenerationScripts/SwitchPlaceAndRoute/Synthesis.tcl -notrace
set WIDTH 32
set Name Switch_PlaceRoute
pause "Implementation of $Name" 100
Synthesis $WIDTH $Name 
pause "Starting MaxPerformance Implementation" 100
#start_implementation #MaxPerformance
source ./GenerationScripts/SwitchPlaceAndRoute/MaxPerformanceScript.tcl -notrace
pause "Starting Functional Implementation" 100
source ./GenerationScripts/SwitchPlaceAndRoute/FunctionalScript.tcl -notrace
pause "Writing Checkpoint" 100
write_checkpoint OutputFolder/$Name -force
		#close_project

