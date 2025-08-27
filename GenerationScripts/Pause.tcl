proc pause {{message "Press N to stop else to continue ==> "} {Wait 5000}} {
		puts -nonewline "\033\[1;31m"; #RED
    puts $message
    puts -nonewline "\033\[0m";# Reset
    global GetsInput
    set id [after $Wait {set GetsInput "Y"}]
		fileevent stdin readable {set GetsInput [read stdin 1]}
		vwait ::GetsInput
		after cancel $id
		if ([string equal $GetsInput "N"]) {
		set $GetsInput "N"
		} else {
		set $GetsInput "Y"
		}
		return $GetsInput
		
}
