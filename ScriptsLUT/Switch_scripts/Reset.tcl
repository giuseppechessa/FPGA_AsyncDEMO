
set f [open ./SourcesLUT/Design/TopModule.sv r]
set file_data [read $f]
close $f
set data [split $file_data "\n"]
set f [open ./Temp.sv w+]
foreach line $data {
	if {[regexp -all "parameter int" $line]} {
		regsub -all {\{([^)]+)\}} $line [subst {\{0,0,0,0,0\}}] line

	}
	puts $f $line
	puts $line
}
close $f
#exec mv Temp.sv ./SourcesLUT/Design/TopModule.sv
if ([string equal [lindex $tcl_platform(os) 0] "Windows"]) {
	exec cmd.exe /c "move ./Temp.sv ./SourcesLUT/Design/TopModule.sv"
} else {
	exec mv Temp.sv ./SourcesLUT/Design/TopModule.sv
}
