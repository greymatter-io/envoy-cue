package v3

// A GuardDogAction that will terminate the process by killing the
// stuck thread. This would allow easier access to the call stack of the stuck
// thread since we would run signal handlers on that thread. By default
// this will be registered to run as the last watchdog action on KILL and
// MULTIKILL events if those are enabled.
#AbortActionConfig: {
	"@type": "type.googleapis.com/envoy.watchdog.v3.AbortActionConfig"
	// How long to wait for the thread to respond to the thread kill function
	// before killing the process from this action. This is a blocking action.
	// By default this is 5 seconds.
	wait_duration?: string
}
