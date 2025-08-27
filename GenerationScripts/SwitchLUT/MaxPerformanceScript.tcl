set FILES ./SourcesLUT/Constraints/BundledConstraints.xdc

source ./ScriptsLUT/Switch_scripts/MaxPerformance.tcl
read_xdc $FILES -mode out_of_context -quiet
opt_design
place_design
route_design
