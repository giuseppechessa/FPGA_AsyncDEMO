set FILES ./Sources/Constraints/BundledConstraints.xdc

source ./Scripts/Switch_scripts/FunctionalPerformanceIntro.tcl -notrace
source ./Scripts/Switch_scripts/FunctionalPerformance2.tcl -notrace
set Out "Violazione"
while {[expr [string equal $Out "Violazione"]==1]} {
	write_checkpoint ./Iter.dcp -force
	close_project
	open_checkpoint ./OutputFolder/Placed.dcp
	read_xdc $FILES -mode out_of_context -quiet
	route_design -quiet
	set Out [source ./Scripts/Switch_scripts/FunctionalPerformance2.tcl -notrace]
}
