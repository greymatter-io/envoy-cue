package v2alpha

import (
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
)

#LocalRateLimit: {
	"@type": "type.googleapis.com/envoy.config.filter.network.local_rate_limit.v2alpha.LocalRateLimit"
	// The prefix to use when emitting :ref:`statistics
	// <config_network_filters_local_rate_limit_stats>`.
	stat_prefix?: string
	// The token bucket configuration to use for rate limiting connections that are processed by the
	// filter's filter chain. Each incoming connection processed by the filter consumes a single
	// token. If the token is available, the connection will be allowed. If no tokens are available,
	// the connection will be immediately closed.
	//
	// .. note::
	//   In the current implementation each filter and filter chain has an independent rate limit.
	//
	// .. note::
	//   In the current implementation the token bucket's :ref:`fill_interval
	//   <envoy_api_field_type.TokenBucket.fill_interval>` must be >= 50ms to avoid too aggressive
	//   refills.
	token_bucket?: _type.#TokenBucket
	// Runtime flag that controls whether the filter is enabled or not. If not specified, defaults
	// to enabled.
	runtime_enabled?: core.#RuntimeFeatureFlag
}
