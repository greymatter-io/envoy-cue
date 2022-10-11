package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#ConnectionLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.connection_limit.v3.ConnectionLimit"
	// The prefix to use when emitting :ref:`statistics
	// <config_network_filters_connection_limit_stats>`.
	stat_prefix?: string
	// The max connections configuration to use for new incoming connections that are processed
	// by the filter's filter chain. When max_connection is reached, the incoming connection
	// will be closed after delay duration.
	max_connections?: uint64
	// The delay configuration to use for rejecting the connection after some specified time duration
	// instead of immediately rejecting the connection. That way, a malicious user is not able to
	// retry as fast as possible which provides a better DoS protection for Envoy. If this is not present,
	// the connection will be closed immediately.
	delay?: string
	// Runtime flag that controls whether the filter is enabled or not. If not specified, defaults
	// to enabled.
	runtime_enabled?: v3.#RuntimeFeatureFlag
}
