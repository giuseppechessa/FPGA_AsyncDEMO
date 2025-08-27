package require csv
package require struct::matrix

proc Padding {StringTBP} {
	set Var1 [split $StringTBP {}];
	set i 0;
	foreach char $Var1 {
		if ({$char}=={\[}|{$char}=={\]}|{$char}=={\*}) { 
			set Var1 [linsert $Var1 $i "\\"];
			incr i;
		}
		incr i;
	} 
	return [join $Var1 ""]
}

source ./Scripts/Swich_script/Impostazioni.tcl
if ({[info commands csvData]}!="") { ::csvData destroy }
::struct::matrix csvData
set chan [open ROUTEINFO.csv] 
csv::read2matrix $chan csvData  \t auto 
close $chan

if ({[array exists readCSV]}==1) { array unset readCSV}
::csvData link readCSV

set f [open ./Sources/Constraints/BundledConstraints.xdc r]
set file_data [read $f]
close $f
set linedata [split $file_data "\n"]
set tf [open temp.xdc w+] 

set Out "Tutto Apposto"
for {set i 1} {$i<[::csvData rows]} {incr i} {
	set Val [list [get_timing_path -from [get_pins $readCSV(0,$i)] -to [get_pins $readCSV(1,$i)] -max_paths 100 -hold] \
								 [get_timing_path -from [get_pins $readCSV(0,$i)] -to [get_pins $readCSV(1,$i)] -max_paths 100]]
	
	set Cambiamento [list  [get_timing_path -from [get_pins $readCSV(6,$i)/input_pipe/*.Data_latch/Q] -to [get_pins $readCSV(6,$i)/PRC/*.RouteAnd/I1] -max_paths 100 -hold] \
												 [get_timing_path -from [get_pins $readCSV(6,$i)/input_pipe/*.Data_latch/Q] -to [get_pins $readCSV(6,$i)/PRC/*.RouteAnd/I1] -max_paths 100]]

	set min_enable [get_property SLOW_MAX [get_net_delays -of_objects [get_nets $readCSV(6,$i)/input_pipe/en] -to [get_pins $readCSV(6,$i)/input_pipe/req_latch/GE]]] 
	set max_enable [get_property SLOW_MAX -max [get_net_delays -of_objects [get_nets $readCSV(6,$i)/input_pipe/en] -to [get_pins $readCSV(6,$i)/input_pipe/*.Data_latch/GE]]]
	
	if ({[expr [get_property -min DATAPATH_DELAY [lindex $Val 0]]<$margine_low*([get_property -max DATAPATH_DELAY [lindex $Cambiamento 1]]+0.001*($max_enable-$min_enable))]}) {
		set Out "Nuova Implementazione"
		if ({[expr ([get_property -max DATAPATH_DELAY $Cambiamento]+0.001*($max_enable-$min_enable))>1.01*($readCSV(3,$i))]}) {
			#aggiungui il ritardo del loop
			set readCSV(3,$i) [expr [get_property -max DATAPATH_DELAY [lindex $Cambiamento 1]]+0.001*($max_enable-$min_enable)]
			set readCSV(2,$i) [expr [get_property -max DATAPATH_DELAY [lindex $Cambiamento 0]]+0.001*($max_enable-$min_enable)]
		} else {
			set readCSV(4,$i) [expr $readCSV(4,$i)+0.05]
			set readCSV(5,$i) [expr $readCSV(5,$i)+0.05]
		}
			set FromPadded [Padding $readCSV(0,$i)]
			set ToPadded [Padding $readCSV(1,$i)]
			set newData ""
			foreach line $linedata {	
				if {([regexp -all [subst {$FromPadded}] $line])&&([regexp -all [subst {$ToPadded}] $line])} {
					if {[regexp -all "set_min_delay" $line]} {
						lappend newData [subst {set_min_delay -from \[get_pins $readCSV(0,$i)\] -to \[get_pins $readCSV(1,$i)\] [expr $readCSV(4,$i)*$readCSV(3,$i)]}]			
							
					}
					if {[regexp -all "set_max_delay" $line]} {
						lappend newData [subst {set_max_delay -from \[get_pins $readCSV(0,$i)\] -to \[get_pins $readCSV(1,$i)\] [expr $readCSV(5,$i)*$readCSV(3,$i)]}]				
					}
				} else {
					lappend newData $line; 
				}
			}
			set linedata $newData
	}
}
foreach line $linedata {	
	puts $tf $line
}
close $tf
set chan [open ROUTEINFO.csv w] 
csv::writematrix ::csvData $chan \t
close $chan

if ([string equal $Out "Nuova Implementazione"]) {
	exec mv temp.xdc ./Sources/Constraints/BundledConstraints.xdc
}
puts $Out
return $Out
