#procedure per la robustezza
proc FixBell {cell fileDescriptor} {
	#questo comando recupera la posizione BEL della cella
	set BEL_property [get_property BEL [get_cells $cell]]
	#questo comando formatta il comando affinchè nel costraint file la posizione BELL sia bloccata
	set line [subst {set_property BEL $BEL_property \[get_cells $cell\] }];
	puts $fileDescriptor $line;
}

proc FixLOC {cell fileDescriptor} {
	#questo comando recupera la posizione LOC della cella
	set LOC_property [get_property LOC [get_cells $cell]]
	#questo comando formatta il comando affinchè nel costraint file la posizione LOC sia bloccata
	set line [subst {set_property LOC $LOC_property \[get_cells $cell\] }];
	puts $fileDescriptor $line;
}

proc FixNet {net fileDescriptor} {
	#questo comando recupera la NET route della NET
	set routes [get_property ROUTE $net];
	#questo comando formatta il comando affinchè nel costraint file la posizione della NET sia bloccata
	set line [subst {set_property FIXED_ROUTE {$routes} \[get_nets $net\] }];
	puts $fileDescriptor $line;
}

proc FixPin {cell fileDescriptor} {
	#questo comando recupera la NET route della NET
	set property [get_property PRIMITIVE_GROUP $cell];
	if ({$property}=={LUT}) {
		set values ""
		set Pins [get_pins -of_objects [get_cells $cell]]
		foreach Pin $Pins {
			set PhPin [get_bel_pins -of_objects $Pin]
			if ([get_property IS_INPUT $PhPin]==1) {
				set property [get_property REF_PIN_NAME $Pin]
				set PhPin [file tail $PhPin]
				lappend values [join [concat $property ":" $PhPin ] ""]
			}
		}
		#questo comando formatta il comando affinchè nel costraint file la posizione della NET sia bloccata
		set line [subst {set_property LOCK_PINS {$values} \[get_cells $cell\] }];
		puts  $fileDescriptor $line;
	}
}

proc ExtractPathTime {PathList {Property "-max"}} {
	set FAST 0
	set SLOW 1
	return [list [get_property $Property DATAPATH_DELAY [lindex $PathList $FAST]] [get_property $Property DATAPATH_DELAY [lindex $PathList $SLOW]]]
}

proc ExtractNetTime {NET OUTPIN {Property "-max"}} {
	return [list [expr 0.001*[get_property FAST_MAX $Property [get_net_delays -of_objects $NET -to $OUTPIN]]] \
	 [expr 0.001*[get_property SLOW_MAX $Property [get_net_delays -of_objects $NET -to $OUTPIN]]]]
}

proc InportModuleCon {Switch Iport fileDescriptor csv margine_low margine_high Data} {
	set SLOW 1
	set FAST 0
	set Startpoint "Q"
	set max_paths 1000
	puts $fileDescriptor [subst {group_path -name "$Iport" -from \[get_pins $Iport/input_pipe/*/*\] }]
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/input_pipe/req_latch/GE\] 0}]
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/input_pipe/*.Data_latch/GE\] 0 }]

	#imposto il max delay le linee dati che vanno nella logica del PRC
	set Command {get_timing_paths -max_paths $max_paths -from [get_pins $Iport/input_pipe/*.Data_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I1]}
	set AndPathData [list  [eval $Command -hold] [eval $Command ]]

	set MinAndTIme [ExtractPathTime $AndPathData "-max"]

	for {set i 0} {$i<32} {incr i} {
		for {set j 0} {$j<4} {incr j} {
			set var [get_timing_paths -from [get_pins $Iport/input_pipe/*[$i].Data_latch/Q] -to [get_pins $Iport/PRC/*[$j].RouteAnd/I1] -quiet];
			if {$var != ""} {
				set Delay [lindex $MinAndTIme 1];
				puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Iport/input_pipe/*[$i].Data_latch/Q\] -to \[get_pins $Iport/PRC/*[$j].RouteAnd/I1\] 0}]
			}
		}
	}
	puts $fileDescriptor "\n"

	#fisso la net dell'enable nel PRC e imposto il min e max delay di tutta la net
	set Command {get_timing_paths -from [get_pins $Iport/input_pipe/req_latch/Q] -to [get_pins $Iport/PRC/*.RouteAnd/I0] -max_paths $max_paths}
	set AndPathReq [list  [eval $Command -hold] [eval $Command ]]

	#FIXING CELLS IN ENABLE PATH
	foreach cell [get_cells -of_objects [lindex $AndPathReq 1]] {FixBell $cell $fileDescriptor;FixLOC $cell $fileDescriptor;FixPin $cell $fileDescriptor;}
	FixNet [get_nets $Iport/PRC/PRC_enable] $fileDescriptor
	puts $fileDescriptor "\n"



	set min_enable [ExtractNetTime [get_nets $Iport/input_pipe/en] [get_pins $Iport/input_pipe/req_latch/GE]]
	set max_enable [ExtractNetTime [get_nets $Iport/input_pipe/en] [get_pins $Iport/input_pipe/*.Data_latch/GE]]


	set minAndTimeReq [ExtractPathTime $AndPathReq "-min"]

	set MinValue [list [expr ([lindex $MinAndTIme $FAST] + [lindex $max_enable $FAST] - [lindex $min_enable $FAST])] \
					   [expr ([lindex $MinAndTIme $SLOW] + [lindex $max_enable $SLOW] - [lindex $min_enable $SLOW])]]

	#Retrieve past iterations information
	set DictIndex 0
	foreach elem $Data {
		if ([string equal [dict get $elem "IPM"] $Iport]&&[string equal [dict get $elem "OPM"] "NA"]) {
			set RightDict $elem
			break
		}
		incr DictIndex
	}

	set Value 1
	if ([expr $margine_low*[lindex $MinValue $SLOW]>[lindex $minAndTimeReq $SLOW]]) {
		if ([dict get $RightDict "M_Low"]==0) {
			dict set RightDict "M_Low"		$margine_low
			dict set RightDict "M_Up"		$margine_high
			dict set RightDict "FAST"		[expr ([lindex $MinValue $FAST])]
			dict set RightDict "SLOW"		[expr ([lindex $MinValue $SLOW])]
		} else {
			if ([expr [lindex $MinValue $SLOW]>1.01*[dict get $RightDict "SLOW"]]) {
				dict set RightDict "FAST" [expr ([lindex $MinValue $FAST])]
				dict set RightDict "SLOW" [expr ([lindex $MinValue $SLOW])]
			} else {
				dict set RightDict "M_Low" [expr [dict get $RightDict "M_Low"]+0.05]
				dict set RightDict "M_Up" [expr [dict get $RightDict "M_Up"]+0.05]
			}
		}
		set MinValue_slow [expr [dict get $RightDict "M_Low"]*[dict get $RightDict "FAST"]]
		set MaxValue [expr [dict get $RightDict "M_Up"]*[dict get $RightDict "SLOW"]]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/PRC/*.RouteAnd/I0\] $MinValue_slow}]
		puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/PRC/*.RouteAnd/I0\] $MaxValue}]
		puts [subst "$Iport Nuovo Vincolo"]
		puts [expr $margine_low*[lindex $MinValue $SLOW]]
		puts [expr [lindex $minAndTimeReq $FAST]]
	} elseif ([dict get $RightDict "M_Low"]!=0) {
		set MinValue_slow [expr [dict get $RightDict "M_Low"]*[dict get $RightDict "FAST"]]
		set MaxValue [expr [dict get $RightDict "M_Up"]*[dict get $RightDict "SLOW"]]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/PRC/*.RouteAnd/I0\] $MinValue_slow}]
		puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Iport/input_pipe/req_latch/Q\] -to \[get_pins $Iport/PRC/*.RouteAnd/I0\] $MaxValue}]
		puts [subst "$Iport Vincolo precedente"]
		set Value 0
	} else {
		puts [subst "$Iport Senza Vincoli"]
		set Value 0
	}
	puts $csv [subst {[dict get $RightDict "FROM"]	[dict get $RightDict "TO"]	[dict get $RightDict "FAST"]	[dict get $RightDict "SLOW"]	[dict get $RightDict "M_Low"]	[dict get $RightDict "M_Up"]	[dict get $RightDict "IPM"]	[dict get $RightDict "OPM"]}]
	puts $fileDescriptor "\n"
	return $Value

}

proc OutportModuleCon {Switch Oport fileDescriptor csv margine_low margine_high Data} {
	set SLOW 1
	set FAST 0
	set max_paths 1000
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/output_pipe/req_latch/Q\] -to \[get_pins $Oport/output_pipe/req_latch/GE\] 0 }]
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/output_pipe/req_latch/Q\] -to \[get_pins $Oport/output_pipe/*.Data_latch/GE\] 0 }]

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

	set PPP_1_time [ExtractPathTime $PacketPath_part1 "-min"]
	set PPP_2_time [ExtractPathTime $PacketPath_part2 "-min"]
	set PDP_time [ExtractPathTime $PacketDataPath]

	#Retrieve past iterations information
	set DictIndex 0
	foreach elem $Data {
		if ([string equal [dict get $elem "OPM"] $Oport]&&[string equal [dict get $elem "IPM"] "NA"]) {
			set RightDict $elem
			break
		}
		incr DictIndex

	}

	set Value 1
	if ([expr $margine_low*([lindex $PDP_time $SLOW])>([lindex $PPP_1_time $SLOW]+[lindex $PPP_2_time $SLOW]+[lindex $latch_delay $SLOW])]) {
		if ([dict get $RightDict "M_Low"]==0) {
			dict set RightDict "M_Low"		$margine_low
			dict set RightDict "M_Up"		$margine_high
			dict set RightDict "FAST"		[expr ([lindex $PDP_time $FAST]-[lindex $PPP_1_time $FAST] - [lindex $latch_delay $FAST])]
			dict set RightDict "SLOW"		[expr ([lindex $PDP_time $SLOW]-[lindex $PPP_1_time $SLOW] - [lindex $latch_delay $SLOW])]
		} else {
			if ([expr ([lindex $PDP_time $SLOW]-[lindex $PPP_1_time $SLOW] - [lindex $latch_delay $SLOW])>1.01*[dict get $elem "SLOW"]]) {
				dict set RightDict "FAST" [expr ([lindex $PDP_time $FAST]-[lindex $PPP_1_time $FAST] - [lindex $latch_delay $FAST])]
				dict set RightDict "SLOW" [expr ([lindex $PDP_time $SLOW]-[lindex $PPP_1_time $SLOW] - [lindex $latch_delay $SLOW])]
			} else {
				dict set RightDict "M_Low" [expr [dict get $RightDict "M_Low"]+0.05]
				dict set RightDict "M_Up" [expr [dict get $RightDict "M_Up"]+0.05]
			}
		}
		set min_Bundled [expr [dict get $RightDict "M_Low"]*([dict get $RightDict "FAST"])]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $min_Bundled}]
		puts [subst "$Oport Nuovo Vincolo"]
	} elseif ([dict get $RightDict "M_Low"]!=0) {
		set min_Bundled [expr [dict get $RightDict "M_Low"]*[dict get $RightDict "FAST"]]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $min_Bundled}]
		puts [subst "$Oport Vincolo precedente"]
		set Value 0
	} else {
		puts [subst "$Oport Senza Vincoli"]
		set Value 0
	}
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/OPM_Mutex/*.Mutex_not/O\] -to \[get_pins $Oport/*.LatchBarrier/GE\] [lindex $PPP_1_time $FAST] }]
	puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/OPM_Mutex/*.Mutex_not/O\] -to \[get_pins $Oport/output_pipe/*.Data_latch/D\] 0 }]
	puts $csv [subst {[dict get $RightDict "FROM"]	[dict get $RightDict "TO"]	[dict get $RightDict "FAST"]	[dict get $RightDict "SLOW"]	[dict get $RightDict "M_Low"]	[dict get $RightDict "M_Up"]	[dict get $RightDict "IPM"]	[dict get $RightDict "OPM"]}]
	puts $fileDescriptor "\n"
	return $Value

}
proc BundleModuleCon  {Switch Iport Oport fileDescriptor csv margine_low margine_high Data AlAug} {
	set SLOW 1
	set FAST 0
	set max_paths 1000
	foreach elem $Data {
			if ([string equal [dict get $elem "IPM"] $Iport]&&[string equal [dict get $elem "OPM"] $Oport]) {
				set RightDict $elem
				break
			}
			incr DictIndex
		}
	if ($AlAug) {
		set DictIndex 0

		puts $csv [subst {[dict get $RightDict "FROM"]	[dict get $RightDict "TO"]	[dict get $RightDict "FAST"]	[dict get $RightDict "SLOW"]	[dict get $RightDict "M_Low"]	[dict get $RightDict "M_Up"]	[dict get $RightDict "IPM"]	[dict get $RightDict "OPM"]}]

		set Value 0
		return $Value
	} else {
		set ReqDelay [get_property -max DATAPATH_DELAY [get_timing_path -hold  -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]
		set latchBarrier [get_cells [get_property PARENT_CELL [get_property ENDPOINT_PIN [get_timing_path -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]]]
		set ReqDelay1 [get_property DATAPATH_DELAY [get_timing_path -hold -from [get_pins ${latchBarrier}/Q] -to [get_pins ${Oport}/output_pipe/req_latch/D]]]
		set DataDelay [get_property -max DATAPATH_DELAY [get_timing_path -max_paths 1000 -from [get_pins ${Iport}/input_pipe/*.Data_latch/Q] -to [get_pins ${Oport}/output_pipe/*.Data_latch/D]]]

		set ReqDelays [expr $ReqDelay+$ReqDelay1+0.141]

		set Value 1
		if ([expr $margine_low*$DataDelay>$ReqDelays]) {
		if ([dict get $RightDict "M_Low"]==0) {
			dict set RightDict "M_Low"		$margine_low
			dict set RightDict "M_Up"		$margine_high
			dict set RightDict "FAST"		[expr $DataDelay-$ReqDelays]
			dict set RightDict "SLOW"		[expr $DataDelay-$ReqDelays]
		} else {
			if ([expr $DataDelay-$ReqDelays>1.01*[dict get $RightDict "SLOW"]]) {
				dict set RightDict "FAST" [expr $DataDelay-$ReqDelays]
				dict set RightDict "SLOW" [expr $DataDelay-$ReqDelays]
			} else {
				dict set RightDict "M_Low" [expr [dict get $RightDict "M_Low"]+0.05]
				dict set RightDict "M_Up" [expr [dict get $RightDict "M_Up"]+0.05]
			}
		}
		set min_Bundled [expr [dict get $RightDict "M_Low"]*[dict get $RightDict "SLOW"]]
		set max_Bundled [expr [dict get $RightDict "M_Up"]*[dict get $RightDict "SLOW"]]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $min_Bundled}]
		puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $max_Bundled}]
		puts [subst "$Oport Nuovo Vincolo"]
	} elseif ([dict get $RightDict "M_Low"]!=0) {
		set min_Bundled [expr [dict get $RightDict "M_Low"]*[dict get $RightDict "SLOW"]]
		set max_Bundled [expr [dict get $RightDict "M_Up"]*[dict get $RightDict "SLOW"]]
		puts $fileDescriptor [subst {set_min_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $min_Bundled}]
		puts $fileDescriptor [subst {set_max_delay -from \[get_pins $Oport/*.LatchBarrier/Q\] -to \[get_pins $Oport/output_pipe/req_latch/D\] $max_Bundled}]
		puts [subst "$Oport Vincolo precedente"]
		set Value 0
	} else {
		puts [subst "$Oport Senza Vincoli"]
		set Value 0
	}
	puts $csv [subst {[dict get $RightDict "FROM"]	[dict get $RightDict "TO"]	[dict get $RightDict "FAST"]	[dict get $RightDict "SLOW"]	[dict get $RightDict "M_Low"]	[dict get $RightDict "M_Up"]	[dict get $RightDict "IPM"]	[dict get $RightDict "OPM"]}]


	}
}


#---------------MAIN----------------#
#Global variables
set InportPortModule "ipm"
set OutportPortModule "opm"
set Switch "Switch"
set Maximum_tries 10
source ./Scripts/Switch_scripts/Impostazioni.tcl
set LatchPath "*.LatchBarrier"

package require csv
package require struct::matrix




source ./Scripts/Switch_scripts/Impostazioni.tcl
if ({[info commands csvData]}!="") { ::csvData destroy }
::struct::matrix csvData
set chan [open ROUTEINFO.csv]
csv::read2matrix $chan csvData  \t auto
close $chan

if ({[array exists readCSV]}==1) { array unset readCSV}
::csvData link readCSV
set Data ""

for {set i 1} {$i<[::csvData rows]} {incr i} {
	lappend Data [dict create FROM $readCSV(0,$i) TO $readCSV(1,$i) FAST $readCSV(2,$i) SLOW $readCSV(3,$i) M_Low $readCSV(4,$i) M_Up $readCSV(5,$i) IPM $readCSV(6,$i) OPM $readCSV(7,$i)]
}
::csvData destroy
puts $Data





#get all the switches in the design
set Switches [get_cells -hierarchical -filter [subst {ORIG_REF_NAME== $Switch || REF_NAME== $Switch}]]
#prepareCodeToRunWithout RLOC
set f [open Temp.xdc w+]
set csv [open ROUTEINFO.csv w+]
puts $csv {FROM	TO	SLOW	FAST	M_Low	M_Up	IPM	OPM}
set newVincoli 0
foreach Switch $Switches {
	set InportModules [get_cells -filter [subst {ORIG_REF_NAME== $InportPortModule || REF_NAME== $InportPortModule}] $Switches/*]
	foreach Iport $InportModules {
		set newVincoli [expr [InportModuleCon $Switch $Iport $f $csv $margine_low $margine_up $Data]+$newVincoli]
	}
	puts $newVincoli
	set OutportModules [get_cells -filter [subst {ORIG_REF_NAME== $OutportPortModule || REF_NAME== $OutportPortModule}] $Switches/*]
	foreach Oport $OutportModules {
		set Error [OutportModuleCon $Switch $Oport $f $csv $margine_low $margine_up $Data]
		set newVincoli [expr $newVincoli +$Error]
		puts $newVincoli
		foreach Iport $InportModules {
			if ([llength [get_timing_path -quiet -from [get_pins ${Iport}/input_pipe/req_latch/Q] -to [get_pins ${Oport}/*.LatchBarrier/D]]]!=0) {
					set newVincoli [expr [BundleModuleCon $Switch $Iport $Oport $f $csv $margine_low $margine_up $Data 1] +$newVincoli]
			}
		}
		puts $newVincoli
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


set Value "Violazione"
if ($newVincoli==0) {
	set Value "Tutto Apposto"
}
return $Value
