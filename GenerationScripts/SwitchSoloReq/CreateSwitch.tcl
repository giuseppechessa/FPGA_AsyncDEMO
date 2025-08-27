source ./GenerationScripts/Pause.tcl -notrace
source ./GenerationScripts/SwitchSoloReq/Synthesis.tcl -notrace
set WIDTH 32
set Name Switch_MARGINE10
#pause "Implementation of $Name" 100
Synthesis $WIDTH $Name 
#pause "Starting MaxPerformance Implementation" 100
#start_implementation #MaxPerformance
#source ./GenerationScripts/SwitchSoloReq/MaxPerformanceScript.tcl -notrace


