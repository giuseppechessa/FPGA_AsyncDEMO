proc FN {Value} {
	return [format "%.2f" $Value]
}

proc getTimes {List Option} {
	return [list [get_property $Option DATAPATH_DELAY [lindex $List 0]] [get_property $Option DATAPATH_DELAY [lindex $List 1]] ]
}

proc INPORT_VERIFICA {Iport margine_low} {
	set max_paths 1000
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Iport/input_pipe/*.Data_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I1]}
	set AndPathData [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Iport/input_pipe/req_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I0]}
	set AndPathrequest  [list  [eval $Command -hold] [eval $Command ]]

	set MinAndTIme [getTimes $AndPathData -max]
	set MinAndTIme_req [getTimes $AndPathrequest -min]

	set Command {get_net_delays -of_objects [get_nets $Iport/input_pipe/en] -to [get_pins $Iport/input_pipe/req_latch/GE]}
	set min_enable [list [get_property FAST_MAX [eval $Command]] [get_property SLOW_MAX [eval $Command]]]

	set Command {get_net_delays -of_objects [get_nets $Iport/input_pipe/en] -to [get_pins $Iport/input_pipe/*.Data_latch/GE]}
	set max_enable [list [get_property FAST_MAX -max [eval $Command]] [get_property SLOW_MAX -max [eval $Command]]]

	set SLOW_MARGIN  [format "%.3f" [expr [lindex $MinAndTIme_req 1]/([lindex $MinAndTIme 1] +0.001*([lindex $max_enable 1]- [lindex $min_enable 1]))]]
	set FAST_MARGIN  [format "%.3f" [expr [lindex $MinAndTIme_req 0]/([lindex $MinAndTIme 0] +0.001*([lindex $max_enable 0]- [lindex $min_enable 0]))]]
	set MIXED_MARGIN [format "%.3f" [expr [lindex $MinAndTIme_req 0]/([lindex $MinAndTIme 1] +0.001*([lindex $max_enable 1]- [lindex $min_enable 1]))]]

	set Value "\tTutto apposto"
	if ([expr $SLOW_MARGIN<$margine_low]||[expr $FAST_MARGIN<$margine_low]) {
		set Value "\tViolazione"
	}
	set Message ${Iport}\t[lindex $MinAndTIme_req 0]\t\t[lindex $MinAndTIme_req 1]\t\t${SLOW_MARGIN}\t\t${FAST_MARGIN}\t\t${MIXED_MARGIN}${Value}
	puts $Message

	return [list ${Value} $SLOW_MARGIN [lindex $MinAndTIme_req 1] $FAST_MARGIN $MIXED_MARGIN [lindex $MinAndTIme_req 0] ]
}

proc OPORT_VERIFICA {Oport margine_low} {
	set LatchPath "*.LatchBarrier"
	set max_paths 1000

	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Oport/OPM_Mutex/*.Mutex_not/O] -to [get_pins $Oport/output_pipe/*.Data_latch/D]}
	set DataPaths  [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Oport/OPM_Mutex/*.Mutex_not/O] -to [get_pins $Oport/${LatchPath}/GE]}
	set ControlPath_1  [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Oport/${LatchPath}/Q] -to [get_pins $Oport/output_pipe/req_latch/D]}
	set ControlPath_2  [list  [eval $Command -hold] [eval $Command ]]


	set DataTimes [getTimes $DataPaths -max]
	set ControlTimes_1 [getTimes $ControlPath_1 -min]
	set ControlTimes_2 [getTimes $ControlPath_2 -min]
	set Arc [get_timing_arcs -from [get_pins $Oport/${LatchPath}/GE]]
	proc GetProperty {Option Arc} {
		return [lindex [get_property $Option  $Arc] 0]
	}
	set latch_delay [list [expr [GetProperty "DELAY_FAST_MAX_FALL" $Arc] + [GetProperty "DELAY_FAST_MAX_RISE" $Arc]/2] [GetProperty "DELAY_SLOW_MAX_FALL" $Arc] + [GetProperty "DELAY_SLOW_MAX_RISE" $Arc]/2]]


	set Prova {format "%.3f" [expr [lindex $ControlTimes_1 $Option] +[lindex $ControlTimes_2 $Option] +[lindex $latch_delay $Option]]}
	set Option 0; set ControlTime [list [eval $Prova]]
	set Option 1; lappend ControlTime [eval $Prova]

	set FAST_MARGIN  [format "%.3f" [expr ([lindex $ControlTimes_1 0] +[lindex $ControlTimes_2 0] +[lindex $latch_delay 0])/[lindex $DataTimes 0]]]
	set SLOW_MARGIN  [format "%.3f" [expr ([lindex $ControlTimes_1 1] +[lindex $ControlTimes_2 1] +[lindex $latch_delay 1])/[lindex $DataTimes 1]]]
	set MIXED_MARGIN [format "%.3f" [expr ([lindex $ControlTimes_1 0] +[lindex $ControlTimes_2 0] +[lindex $latch_delay 0])/[lindex $DataTimes 1]]]

	set Value "\tTutto apposto"
	if ([expr $SLOW_MARGIN<$margine_low]||[expr $FAST_MARGIN<$margine_low]) {
		set Value "\tViolazione"
	}
	set Message ${Oport}\t[lindex $ControlTime 0]\t\t[lindex $ControlTime 1]\t\t${SLOW_MARGIN}\t\t${FAST_MARGIN}\t\t${MIXED_MARGIN}${Value}
	puts $Message
	return [list ${Value} $SLOW_MARGIN [lindex $ControlTime 1] $FAST_MARGIN $MIXED_MARGIN]
}

proc BUNDLE_VERIFICA { Iport Oport margine_low} {
	set LatchPath "*.LatchBarrier"
	set PROVA [get_nets $Iport/req_dw_o[*]]
	set Valid 0
	foreach net $PROVA {
		if {[llength [get_net_delays -of_objects $net -to [get_pins $Oport/${LatchPath}/D] -filter {ESTIMATED==0}]]} {
			set Valid 1
			set ReqTime_2 [get_property SLOW_MAX [get_net_delays -of_objects $net -to [get_pins $Oport/${LatchPath}/D] -filter {ESTIMATED==0} ]]
			set Cella [get_property PARENT_CELL [get_nets [get_property PARENT $net]]]
			#puts $net
			}
		}
	if ($Valid==1) {
		set ReqTime_1 [get_property SLOW_MAX [get_net_delays -of_objects [get_nets $Iport/req] -to [get_pins $Cella/req_dw_o_INST_0/I0]]]
		return Times [expr $ReqTime_1+$ReqTime_2]
	}
	return;
}

proc Verifica {{SingleValue 0} {WHERE "IPM"} {START mySwitch/genblk1[0].IPMS}} {
	source ./Scripts/Switch_scripts/Impostazioni.tcl -notrace
	set InportPortModule "ipm"
	set OutportPortModule "opm"
	set Switch "Switch"

	if ($SingleValue==1) {
		if ([string equal $WHERE "IPM"]) {
			return [INPORT_VERIFICA $START $margine_low]
		} elseif ([string equal $WHERE "OPM"]) {
			return [OPORT_VERIFICA $START $margine_low]
		}
		puts stderr "INVALID OPTION"
		return;
	}

	puts "ORIG\t\t\t\tREQFAST\t\tREQSLOW\t\tSLOWMARGIN\tFASTMARGIN\tMIXEDMARGIN"
	set Switches [get_cells -hierarchical -filter [subst {ORIG_REF_NAME== $Switch || REF_NAME== $Switch}]]
	foreach Switch $Switches {
		puts "IPMS"
		set InportModules [get_cells -filter [subst {ORIG_REF_NAME== $InportPortModule || REF_NAME== $InportPortModule}] $Switches/*]
		foreach Iport $InportModules {
			set returnList [INPORT_VERIFICA $Iport $margine_low]
			#lappend ERROR [lindex $returnList 0]
			lappend MarginSlow [lindex $returnList 1]
			lappend Times [lindex $returnList 2]
			lappend MarginFast [lindex $returnList 3]
			lappend MarginMixed [lindex $returnList 4]
			lappend TimesF [lindex $returnList 5]
		}
		puts "OPMS"
		set OutportModules [get_cells -filter [subst {ORIG_REF_NAME== $OutportPortModule || REF_NAME== $OutportPortModule}] $Switches/*]
		foreach Oport $OutportModules {
			set  returnListOP  [OPORT_VERIFICA $Oport $margine_low]
		}
		#foreach Iport $InportModules {
		#	foreach Oport $OutportModules {
				#lappend BundleTimes [BUNDLE_VERIFICA $Iport $Oport $margine_low]
		#	}
		#}
	}

	proc setMessage {List} {
		source ./Scripts/Switch_scripts/MathProc/math.tcl -notrace
		return [FN [Calc $List "average"]]\t[format "%.2f" [expr [Calc $List "max"] - [Calc $List "average"]]]\t[format "%.2f" [expr [Calc $List "min"] - [Calc $List "average"]]]
	}

	puts "\nSLOW"
	set Message [setMessage $MarginSlow]
	set Message [FN [Calc $Times "average"]]\t${Message}
	puts $Message
	puts "FAST"
	set Message [setMessage $MarginFast]
	set Message [FN [Calc $TimesF "average"]]\t${Message}
	puts $Message
	puts "MIXED"
	set Message [setMessage $MarginMixed]
	puts $Message
}
	return;
}


#Verifica
