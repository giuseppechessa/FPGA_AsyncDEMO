set FILES ./Sources/Constraints/BundledConstraints.xdc

source ./Scripts/Switch_scripts/MaxPerformance -notrace
read_xdc $FILES -mode out_of_context -quiet
opt_design
place_design
route_design
