package require math::statistics
proc Calc {ListVal OPERATION} {
	set Val  ""
	if ([string equal $OPERATION "average"]) {
		set Val [expr {[tcl::mathop::+ {*}$ListVal 0.0] / max(1, [llength $ListVal])}]
	} elseif ([string equal $OPERATION "max"]) {
		set Val [tcl::mathfunc::max {*}$ListVal]
	} elseif ([string equal $OPERATION "min"]) {
		set Val [tcl::mathfunc::min {*}$ListVal]
	} elseif ([string equal $OPERATION "std"]) {
		set Val [math::statistics::stdev $ListVal]
	}
	return $Val
}