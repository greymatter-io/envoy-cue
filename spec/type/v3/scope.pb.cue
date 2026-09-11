package v3

// Stats scope configuration.
// This configuration can be used to create a singleton scope that is shared
// across multiple instances within the process.
// [#next-free-field: 7]
#Scope: {
	"@type": "type.googleapis.com/envoy.type.v3.Scope"
	// Max number of counters allowed in this scope.
	max_counters?: uint32
	// Max number of gauges allowed in this scope.
	max_gauges?: uint32
	// Max number of histograms allowed in this scope.
	max_histograms?: uint32
	// Whether the scope and its stats can be evicted from the store caches.
	// The eviction policy is a mark-and-sweep approach where stats are evicted
	// if they are not updated or accessed between two successive eviction sweeps.
	// The eviction will happen only if the :ref:`stats_eviction_interval <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.stats_eviction_interval>` is configured in
	// the bootstrap.
	enable_eviction?: bool
	// The stats scope prefix.
	prefix?: string
	// The sharing name of the scope. If non-empty, the scope is shared across
	// multiple instances with the same sharing_name if all fields in this message
	// have the same values.
	sharing_name?: string
}
