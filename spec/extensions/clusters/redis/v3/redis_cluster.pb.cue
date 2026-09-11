package v3

// [#next-free-field: 8]
#RedisClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.redis.v3.RedisClusterConfig"
	// Interval between successive topology refresh requests. If not set, this defaults to 5s.
	cluster_refresh_rate?: string
	// Timeout for topology refresh request. If not set, this defaults to 3s.
	cluster_refresh_timeout?: string
	// The minimum interval that must pass after triggering a topology refresh request before a new
	// request can possibly be triggered again. Any errors received during one of these
	// time intervals are ignored. If not set, this defaults to 5s.
	redirect_refresh_interval?: string
	// The number of redirection errors that must be received before
	// triggering a topology refresh request. If not set, this defaults to 5.
	// If this is set to 0, topology refresh after redirect is disabled.
	redirect_refresh_threshold?: uint32
	// The number of failures that must be received before triggering a topology refresh request.
	// If not set, this defaults to 0, which disables the topology refresh due to failure.
	failure_refresh_threshold?: uint32
	// The number of hosts became degraded or unhealthy before triggering a topology refresh request.
	// If not set, this defaults to 0, which disables the topology refresh due to degraded or
	// unhealthy host.
	host_degraded_refresh_threshold?: uint32
	// Enable zone discovery via INFO command. When enabled, the cluster will
	// send INFO command to each node to discover its availability_zone field,
	// which is then used for zone-aware routing.
	//
	// Note: This feature currently works with Valkey only. Valkey exposes
	// availability_zone in its INFO response. Standard Redis does not support this field.
	//
	// If not set, this defaults to false.
	enable_zone_discovery?: bool
}
