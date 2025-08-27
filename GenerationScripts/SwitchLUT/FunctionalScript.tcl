set FILES ./SourcesLUT/Constraints/BundledConstraints.xdc

source ./ScriptsLUT/Switch_scripts/FunctionalPerformance.tcl -notrace
read_xdc $FILES -mode out_of_context -quiet
opt_design -quiet
place_design -quiet
route_design -quiet
