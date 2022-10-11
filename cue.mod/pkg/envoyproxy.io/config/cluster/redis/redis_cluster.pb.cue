package redis

// [#next-free-field: 7]
#RedisClusterConfig: {
	"@type": "type.googleapis.com/envoy.config.cluster.redis.RedisClusterConfig"
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
}
