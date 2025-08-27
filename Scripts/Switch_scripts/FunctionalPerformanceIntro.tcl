proc InportModuleCon {Iport csv} {
	puts $csv [subst {$Iport/input_pipe/req_latch/Q	$Iport/PRC/*.RouteAnd/I0	0	0	0	0	$Iport	NA}]
}

proc OutportModuleCon {Oport csv} {
	puts $csv [subst {$Oport/*.LatchBarrier/Q	$Oport/output_pipe/req_latch/D	0	0	0	0	NA	$Oport}]
}
proc BundleModuleCon {Iport Oport csv} {
	puts $csv [subst {$Iport/input_pipereq_latch/Q	$Oport/*.LatchBarrier/D	0	0	0	0	$Iport	$Oport}]
}
#---------------MAIN----------------#
#Global variables
set InportPortModule "ipm"
set OutportPortModule "opm"
set Switch "Switch"
set Maximum_tries 10
source ./Scripts/Switch_scripts/Impostazioni.tcl


#open_run impl_1
set Switches [get_cells -hierarchical -filter [subst {ORIG_REF_NAME== $Switch || REF_NAME== $Switch}]]
#prepareCodeToRunWithout RLOC
set f [open Temp.xdc w+]
set csv [open Temp.csv w+]
puts $csv {FROM	TO	FAST	SLOW	M_Low	M_Up	IPM	OPM}
foreach Switch $Switches {
	set InportModules [get_cells -filter [subst {ORIG_REF_NAME== $InportPortModule || REF_NAME== $InportPortModule}] $Switches/*]
	foreach Iport $InportModules {
		InportModuleCon $Iport $csv
	}
	set OutportModules [get_cells -filter [subst {ORIG_REF_NAME== $OutportPortModule || REF_NAME== $OutportPortModule}] $Switches/*]
	foreach Oport $OutportModules {
		OutportModuleCon $Oport $csv
	}

	foreach Iport $InportModules {
		foreach Oport $OutportModules {
			if ([llength [get_timing_path -quiet -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]!=0) {
				BundleModuleCon $Iport $Oport $csv
			}
		}
	}

}
#chiudo il file e lo muovo nel constraint che uso
close $f
close $csv
if ([string equal [lindex $tcl_platform(os) 0] "Windows"]) {
	exec cmd.exe /c "move  Temp.xdc ./Sources/Constraints/BundledConstraints.xdc"
} else {
	exec mv Temp.xdc ./Sources/Constraints/BundledConstraints.xdc
}

if ([string equal [lindex $tcl_platform(os) 0] "Windows"]) {
	exec cmd.exe /c "move Temp.csv ./ROUTEINFO.csv" &
} else {
	exec mv Temp.csv ./ROUTEINFO.csv
}
