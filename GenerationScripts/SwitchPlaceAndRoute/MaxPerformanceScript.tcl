set FILES ./Sources/Constraints/BundledConstraints.xdc

source ./Scripts/Switch_scripts/MaxPerformance -notrace
read_xdc $FILES -mode out_of_context -quiet
write_checkpoint ./OutputFolder/Placed.dcp -force
opt_design
place_design
route_design
