package v3

// Configuration for the backtrace watchdog action.
//
// This action is currently only supported on Linux.
#BacktraceActionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.watchdog.backtrace_action.v3.BacktraceActionConfig"
	// Minimum time between backtrace logs per thread. Defaults to 10 seconds if not set.
	// Set to 0 to disable the cooldown and log a backtrace on every watchdog event.
	cooldown_duration?: string
}
