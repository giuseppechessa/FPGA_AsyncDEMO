proc CorrBundle {IN {ESPL 1} {Delay 200}} {
	source ./Scripts/Switch_scripts/Verifica.tcl -notrace
	source ./Scripts/Switch_scripts/Impostazioni.tcl -notrace
	source ./Scripts/Switch_scripts/MathProc/math.tcl -notrace
	if {$ESPL==0} {
		route_design -unroute -pins [get_pins ${IN}/PRC/XOR/I0] -quiet
		route_design -pins [get_pins ${IN}/PRC/XOR/I0] -min_delay $Delay -quiet
		set Values [Verifica 1 $IN $OUT]
		return
	}
	set Values [Verifica 1 "IPM" $IN]
	if ([expr [lindex $Values 1] > $margine_low]) {return;}

	set Data_Delay [get_property -max DATAPATH_DELAY [get_timing_paths -hold -from [get_pins ${IN}/input_pipe/*.Data_latch/Q] -to [get_pins ${IN}/PRC/*.RouteAnd/I1] ]]
	set Incr [expr ($MAXValue-$MINValue)/$NUMIter];
	for {set Perc [expr int($MINValue)]} {$Perc<[expr  int($MAXValue)]} {incr Perc [expr int($Incr)]} {
		#1000 Because route design wants the number in ps while get property gives us the time in ns
		#margine low is the target margin, Perc/100 to get from a percent to a real number
		set Delay [expr int((1000*$margine_low*$Data_Delay*$Perc)/100)]
		route_design -unroute -pins [get_pins ${IN}/PRC/XOR/I0] -quiet
		route_design -pins [get_pins ${IN}/PRC/XOR/I0] -min_delay [expr $Delay] -quiet
		set Values [Verifica 1 "IPM" $IN]
		lappend Delays $Delay;lappend FastBundle [lindex $Values 3];lappend SlowBundle [lindex $Values 1];
		lappend MixedBundle [lindex $Values 4]
		#if ([expr [lindex $Values 1] > $margine_low+0.50]) {break;}
	}
	set Sum ""
	foreach Del $Delays FB $FastBundle SB $SlowBundle MB $MixedBundle {
		#puts [format "%s\t%f\t%f\t%f" $Del $FB $SB $MB]
		#[expr $SB>$margine_low]&&
		if ([expr $SB>$margine_low]&&[expr $FB>$margine_low]) {
			lappend Sum [expr $FB+$SB]
		} else {
			lappend Sum 100000
		}
	}
	set Val [Calc $Sum "min"]
	set index [lsearch $Sum $Val]
	route_design -unroute -pins [get_pins ${IN}/PRC/XOR/I0] -quiet
	route_design -pins [get_pins ${IN}/PRC/XOR/I0] -min_delay [lindex $Delays $index] -quiet -eco
}

proc CorrBundleOP {IN {ESPL 1}  {Delay 200}} {
	source ./Scripts/Switch_scripts/MathProc/math.tcl -notrace
	source ./Scripts/Switch_scripts/Verifica.tcl -notrace
	source ./Scripts/Switch_scripts/Impostazioni.tcl -notrace
	if {$ESPL==0} {
		route_design -unroute -pins [get_pins ${IN}/output_pipe/req_latch/D] -quiet
		route_design -pins [get_pins ${IN}/output_pipe/req_latch/D] -min_delay [expr int($Delay)] -quiet
		set Values [Verifica 1 $IN $OUT]
	}
	set Values [Verifica 1 "OPM" $IN]
	if ([expr [lindex $Values 1] > $margine_low]) {return;}

	set Incr [expr ($MAXValue-$MINValue)/$NUMIter];
	set Data_Delay [get_property -max DATAPATH_DELAY [get_timing_paths  -hold -from [get_pins ${IN}/OPM_Mutex/*.Mutex_not/O] -to [get_pins ${IN}/output_pipe/*.Data_latch/D] -max_paths 1000]]
	#set LATCHPIN [get_property ENDPOINT_PIN $Req_Delay]
	for {set Perc [expr int($MINValue)]} {$Perc<[expr  int($MAXValue)]} {incr Perc [expr int($Incr)]} {
		set Delay [expr int((1000*$margine_low*$Data_Delay*$Perc)/100)]
		route_design -unroute -pins [get_pins ${IN}/output_pipe/req_latch/D] -quiet
		route_design -pins [get_pins ${IN}/output_pipe/req_latch/D] -min_delay [expr $Delay] -quiet
		set Values [Verifica 1 "OPM" $IN]
		lappend Delays $Delay;lappend FastBundle [lindex $Values 3];lappend SlowBundle [lindex $Values 1];
		lappend MixedBundle [lindex $Values 4]
		if ([expr [lindex $Values 1] > $margine_low+0.50]) {break;}
	}
	set Sum ""
	foreach Del $Delays FB $FastBundle SB $SlowBundle MB $MixedBundle {
		if ([expr $SB>$margine_low]&&[expr $FB>$margine_low]) {
			lappend Sum [expr $FB+$SB]
		} else {
			lappend Sum 100000
		}
	}
	set Val [Calc $Sum "min"]
	set index [lsearch $Sum $Val]
	route_design -unroute -pins [get_pins ${IN}/output_pipe/req_latch/D] -quiet
	route_design -pins [get_pins ${IN}/output_pipe/req_latch/D] -min_delay [lindex $Delays $index] -quiet
}
