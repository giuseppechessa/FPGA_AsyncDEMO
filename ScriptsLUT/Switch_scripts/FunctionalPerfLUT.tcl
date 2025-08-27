proc ExtractPathTime {PathList {Property "-max"}} {
	set FAST 0
	set SLOW 1
	return [list [get_property $Property DATAPATH_DELAY [lindex $PathList $FAST]] [get_property $Property DATAPATH_DELAY [lindex $PathList $SLOW]]]
}

proc ExtractNetTime {NET OUTPIN {Property "-max"}} {
	return [list [expr 0.001*[get_property FAST_MAX $Property [get_net_delays -of_objects $NET -to $OUTPIN]]] \
	 [expr 0.001*[get_property SLOW_MAX $Property [get_net_delays -of_objects $NET -to $OUTPIN]]]]
}

proc getNumber {Port} {
	if ([regex {3\[0\]} $Port]||[regex {1\[0\]} $Port]) {
		return 0;
	} elseif ([regex {3\[1\]} $Port]||[regex {1\[1\]} $Port]) {
		return 1;
	} elseif ([regex {3\[2\]} $Port]||[regex {1\[2\]} $Port]) {
		return 2;
	} elseif ([regex {3\[3\]} $Port]||[regex {1\[3\]} $Port]) {
		return 3;
	} elseif ([regex {4\[0\]} $Port]||[regex {2\[0\]} $Port]) {
		return 4;
	}
	return 0;
}
proc InportModuleCon {Switch Iport margine_low margine_high BUFNUM} {
	set max_paths 1000
	set FAST 0
	set SLOW 1
	set Numero [getNumber $Iport]

	#imposto il max delay le linee dati che vanno nella logica del PRC
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Iport/input_pipe/*.Data_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I1]}
	set AndPathData [list  [eval $Command -hold] [eval $Command ]]

	set MinAndTIme [ExtractPathTime $AndPathData]


	#fisso la net dell'enable nel PRC e imposto il min e max delay di tutta la net
	set Command {get_timing_paths -from [get_pins $Iport/input_pipe/req_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I0] -max_paths $max_paths}
	set AndPathReq [list  [eval $Command -hold] [eval $Command ]]

	set  min_enable [ExtractNetTime [get_nets $Iport/input_pipe/en] [get_pins $Iport/input_pipe/req_latch/GE]]
	set  max_enable [ExtractNetTime [get_nets $Iport/input_pipe/en] [get_pins $Iport/input_pipe/*.Data_latch/GE]]

	set minAndTimeReq [ExtractPathTime $AndPathReq "-min"]
	set MinValue [list [expr $margine_low*([lindex $MinAndTIme $FAST] + [lindex $max_enable $FAST] - [lindex $min_enable $FAST])] [expr $margine_low*([lindex $MinAndTIme $SLOW] + [lindex $max_enable $SLOW] - [lindex $min_enable $SLOW])]]

	puts [format "%20s\t\t\t%.3f\t\t%.3f" $Iport [lindex $MinValue $SLOW] [lindex $minAndTimeReq $FAST]]
	set MaxValue [expr $margine_high*([lindex $MinAndTIme 1] + [lindex $max_enable 1] - [lindex $min_enable 1])]
	#if (($MinValue_slow>[lindex $minAndTimeReq $SLOW])||($MinValue_fast>[lindex $minAndTimeReq $FAST])) {}
	if (([lindex $MinValue $SLOW]>[lindex $minAndTimeReq $SLOW])||([lindex $MinValue $FAST]>[lindex $minAndTimeReq $FAST])) {
		lset BUFNUM $Numero [expr [lindex $BUFNUM $Numero] +1]
		puts [subst "aggiunta LUT"]
	}
	return $BUFNUM

}

proc IOModuleCon {Switch Iport Oport margine_low margine_high BUFNUMIO BUFNUMORIGIO} {
	set max_paths 1000
	set FAST 0
	set SLOW 1
	set Numero [getNumber $Oport]


	#imposto il max delay le linee dati che vanno nella logica del PRC
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins ${Iport}/input_pipe/*.Data_latch/Q] -to [get_pins ${Oport}/output_pipe/*.Data_latch/D]}
	set DataPATH [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_path -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]}
	set ReqPATH1 [list  [eval $Command -hold] [eval $Command ]]



	set latchBarrier [lindex  [get_cells [get_property PARENT_CELL [get_property ENDPOINT_PIN [get_timing_path -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]]] 0]
	set Command {get_timing_path  -from [get_pins ${latchBarrier}/Q] -to [get_pins ${Oport}/output_pipe/req_latch/D]}
	set ReqPATH2 [list  [eval $Command -hold] [eval $Command ]]

	set DataTime [ExtractPathTime $DataPATH]
	set Req1Time [ExtractPathTime $ReqPATH1 "-min"]
	set Req2Time [ExtractPathTime $ReqPATH2 "-min"]
	set ReqTime [list [expr [lindex $Req1Time $FAST] + [lindex $Req2Time $FAST]] [expr [lindex $Req1Time $SLOW] + [lindex $Req2Time $SLOW]]]

	puts [format "%20s\t\t\t%20s\t\t\t%.3f\t\t%.3f" $Iport $Oport [lindex $DataTime $SLOW] [lindex $ReqTime $SLOW]]
	if (([lindex $DataTime $SLOW]>[lindex $ReqTime $SLOW])||([lindex $DataTime $FAST]>[lindex $ReqTime $FAST])) {
		if ([lindex $BUFNUMIO $Numero]==[lindex $BUFNUMORIGIO $Numero]) {
			lset BUFNUMIO $Numero [expr [lindex $BUFNUMIO $Numero] +1]
			puts [subst "AGGIUNTA LUT"]
		}
	}
	return $BUFNUMIO
}

proc OutportModuleCon {Switch Oport margine_low margine_high BUFNUMIO BUFNUMORIGIO} {
	set max_paths 1000
	set FAST 0
	set SLOW 1
	set Numero [getNumber $Oport]

	set Arc [get_timing_arcs -from [get_pins $Oport/*.LatchBarrier/GE]]
	proc GetProperty {Option Arc} {
		return [lindex [get_property $Option  $Arc] 0]
	}
	set latch_delay [list [expr ([GetProperty DELAY_FAST_MAX_FALL $Arc] + [GetProperty DELAY_FAST_MAX_RISE $Arc])/2 ] [expr ([GetProperty DELAY_SLOW_MAX_FALL $Arc] + [GetProperty DELAY_SLOW_MAX_RISE $Arc])/2]]
	set Command {get_timing_paths -from [get_pins $Oport/OPM_Mutex/*.Mutex_not/O] -to [get_pins $Oport/*.LatchBarrier/GE]}
	set PacketPath_part1 [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_paths -from [get_pins $Oport/*.LatchBarrier/Q] -to [get_pins $Oport/output_pipe/req_latch/D]}
	set PacketPath_part2 [list  [eval $Command -hold] [eval $Command ]]
	set Command {get_timing_paths -from [get_pins $Oport/OPM_Mutex/*.Mutex_not/O] -to [get_pins $Oport/output_pipe/*.Data_latch/D]}
	set PacketDataPath [list  [eval $Command -hold] [eval $Command ]]

	set PPP_1_time [ExtractPathTime $PacketPath_part1]
	set PPP_2_time [ExtractPathTime $PacketPath_part2]
	set PDP_time [ExtractPathTime $PacketDataPath]

	puts [format "%20s\t\t\t%.3f\t\t%.3f"  $Oport [expr $margine_low*[lindex $PDP_time 1]] [expr ([lindex $PPP_1_time 0]+[lindex $PPP_2_time 0]+[lindex $latch_delay 0])] ]
	if (([expr $margine_low*([lindex $PDP_time $SLOW])>([lindex $PPP_1_time $SLOW]+[lindex $PPP_2_time $SLOW]+[lindex $latch_delay $SLOW])])||([expr $margine_low*([lindex $PDP_time $FAST])>([lindex $PPP_1_time $FAST]+[lindex $PPP_2_time $FAST]+[lindex $latch_delay $FAST])])) {
		if ([lindex $BUFNUMIO $Numero]==[lindex $BUFNUMORIGIO $Numero]) {
			lset BUFNUMIO $Numero [expr [lindex $BUFNUMIO $Numero] +1]
			puts [subst "$Oport AGGIUNTA LUT"]
		}
	}
	return $BUFNUMIO
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

	set f [open ./SourcesLUT/Design/TopModule.sv r]
	set file_data [read $f]
	close $f
	set data [split $file_data "\n"]

	foreach line $data {
		if {[regexp -all "parameter int BUFNumber " $line]} {
			regexp {\{([^)]+)\}} $line match
			scan $match "{%d,%d,%d,%d,%d}" BUFNum5 BUFNum4 BUFNum3 BUFNum2 BUFNum1
			set BUFNUM $BUFNum1
			lappend BUFNUM $BUFNum2
			lappend BUFNUM $BUFNum3
			lappend BUFNUM $BUFNum4
			lappend BUFNUM $BUFNum5
			#regsub -all {\{([^)]+)\}} $line "{1,1,1,1,1}" stringaa
			#puts $stringaa
		}
		if {[regexp -all "parameter int BUFNumberIO" $line]} {
			regexp {\{([^)]+)\}} $line match
			scan $match "{%d,%d,%d,%d,%d}" BUFNum5 BUFNum4 BUFNum3 BUFNum2 BUFNum1
			set BUFNUMIO $BUFNum1
			lappend BUFNUMIO $BUFNum2
			lappend BUFNUMIO $BUFNum3
			lappend BUFNUMIO $BUFNum4
			lappend BUFNUMIO $BUFNum5
			#regsub -all {\{([^)]+)\}} $line "{1,1,1,1,1}" stringaa
			#puts $stringaa
		}
	}
	set BUFNUMIOOR $BUFNUMIO
	set BUFNUMOR $BUFNUM
	puts $BUFNUMIO
	puts $BUFNUM
	#prepareCodeToRunWithout RLOC
	foreach Switch $Switches {
		set InportModules [get_cells -filter [subst {ORIG_REF_NAME== $InportPortModule || REF_NAME== $InportPortModule}] $Switch/*]
		foreach Iport $InportModules {
			set BUFNUM [InportModuleCon $Switch $Iport $margine_low $margine_up $BUFNUM]
		}
		set OutportModules [get_cells -filter [subst {ORIG_REF_NAME== $OutportPortModule || REF_NAME== $OutportPortModule}] $Switch/*]
		foreach Oport $OutportModules {
			set BUFNUMIO [OutportModuleCon $Switch $Oport $margine_low $margine_up $BUFNUMIO $BUFNUMIOOR]
		}
		foreach Iport $InportModules {
			foreach Oport $OutportModules {
				if ([llength [get_timing_path -quiet -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]!=0) {
					set BUFNUMIO [IOModuleCon $Switch $Iport $Oport $margine_low $margine_up $BUFNUMIO $BUFNUMIOOR]
				}
			}
		}
	}



	#chiudo il file e lo muovo nel constraint che uso
	set f [open ./SourcesLUT/Design/TopModule.sv r]
	set file_data [read $f]
	close $f
	set data [split $file_data "\n"]
	set f [open ./Temp.sv w+]
	foreach line $data {
		if {[regexp -all "parameter int BUFNumber " $line]} {
			regsub -all {\{([^)]+)\}} $line [subst {\{[lindex $BUFNUM 4],[lindex $BUFNUM 3],[lindex $BUFNUM 2],[lindex $BUFNUM 1],[lindex $BUFNUM 0]\}}] line

		}
		if {[regexp -all "parameter int BUFNumberIO" $line]} {
			regsub -all {\{([^)]+)\}} $line [subst {\{[lindex $BUFNUMIO 4],[lindex $BUFNUMIO 3],[lindex $BUFNUMIO 2],[lindex $BUFNUMIO 1],[lindex $BUFNUMIO 0]\}}] line

		}
		puts $f $line
	}
	puts $BUFNUMIO
	puts $BUFNUM
	close $f
	if ([string equal [lindex $tcl_platform(os) 0] "Windows"]) {
		exec cmd.exe /c "move ./Temp.sv ./SourcesLUT/Design/TopModule.sv"
	} else {
		exec mv Temp.sv ./SourcesLUT/Design/TopModule.sv
	}
	set Value "Tutto Apposto"
	if {[::struct::list equal $BUFNUMOR $BUFNUM]} {puts "NOIPMSPROBLEM" } else { set Value "Violazione"}
	if {[::struct::list equal $BUFNUMIOOR $BUFNUMIO]} {puts "NOOPMSPROBLEM" } else { set Value "Violazione"}
	return $Value
