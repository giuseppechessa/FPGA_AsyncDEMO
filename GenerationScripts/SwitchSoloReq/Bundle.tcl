


proc ResetBundle {IN} {
	route_design -unroute -pins [get_pins ${IN}/PRC/XOR/I0] -quiet
}

proc FixBundle {{Reset 0}} {
	source .//Scripts/Switch_scripts/CorrectBundle.tcl
	source ./Scripts/Switch_scripts/Impostazioni.tcl
	set InportPortModule "ipm"
	set OutportPortModule "opm"
	set Switch "mySwitch"
	set Maximum_tries 10
	#open_run impl_1
	puts "SWITCH NETS"

	set InportModules [get_cells -filter [subst {ORIG_REF_NAME== $InportPortModule || REF_NAME== $InportPortModule}] $Switch/*]
	set ListaIports ""
	foreach Iport $InportModules {
	#		lappend ListaIports [get_pins $Iport/PRC/XOR/I0]
		if ($Reset==1) {
			ResetBundle $Iport
		} else {
			CorrBundle $Iport
		}
	}
	#puts $ListaIports

	set OutportModules [get_cells -filter [subst {ORIG_REF_NAME== $OutportPortModule || REF_NAME== $OutportPortModule}] $Switch/*]
	foreach Oport $OutportModules {
		if ($Reset==1) {
			#ResetBundle $Oport
		} else {
			CorrBundleOP $Oport
		}
	}
	#write_checkpoint ./OutputFolder/Margine10req.dcp
}
