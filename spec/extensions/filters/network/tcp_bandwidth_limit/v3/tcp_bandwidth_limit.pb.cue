package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// [#next-free-field: 6]
#TcpBandwidthLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.tcp_bandwidth_limit.v3.TcpBandwidthLimit"
	// The human readable prefix to use when emitting stats.
	stat_prefix?: string
	// The limit for read (onData) bandwidth in KiB/s.
	// If not set, no limit is applied (unlimited bandwidth).
	// If set to 0, all reads are blocked.
	read_limit_kbps?: uint64
	// The limit for write (onWrite) bandwidth in KiB/s.
	// If not set, no limit is applied (unlimited bandwidth).
	// If set to 0, all writes are is blocked.
	write_limit_kbps?: uint64
	// The interval at which to process buffered data and check for available bandwidth.
	// Defaults to 50ms. It must be at least 20ms to avoid too frequent processing.
	fill_interval?: string
	// Runtime flag that controls whether the filter is enabled or not. If not specified, defaults
	// to enabled.
	runtime_enabled?: v3.#RuntimeFeatureFlag
}
