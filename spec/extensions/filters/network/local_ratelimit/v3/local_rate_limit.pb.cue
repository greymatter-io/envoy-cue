package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#LocalRateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.local_ratelimit.v3.LocalRateLimit"
	// The prefix to use when emitting :ref:`statistics
	// <config_network_filters_local_rate_limit_stats>`.
	stat_prefix?: string
	// The token bucket configuration to use for rate limiting connections that are processed by the
	// filter's filter chain. Each incoming connection processed by the filter consumes a single
	// token. If the token is available, the connection will be allowed. If no tokens are available,
	// the connection will be immediately closed.
	//
	// .. note::
	//   In the current implementation each filter and filter chain has an independent rate limit, unless
	//   a shared rate limit is configured via :ref:`share_key <envoy_v3_api_field_extensions.filters.network.local_ratelimit.v3.LocalRateLimit.share_key>`.
	//
	// .. note::
	//   In the current implementation the token bucket's :ref:`fill_interval
	//   <envoy_v3_api_field_type.v3.TokenBucket.fill_interval>` must be >= 50ms to avoid too aggressive
	//   refills.
	token_bucket?: v3.#TokenBucket
	// Runtime flag that controls whether the filter is enabled or not. If not specified, defaults
	// to enabled.
	runtime_enabled?: v31.#RuntimeFeatureFlag
	// Specifies that the token bucket used for rate limiting should be shared with other local_rate_limit filters
	// with a matching :ref:`token_bucket <envoy_v3_api_field_extensions.filters.network.local_ratelimit.v3.LocalRateLimit.token_bucket>`
	// and ``share_key`` configuration. All fields of ``token_bucket`` must match exactly for the token bucket to be shared. If this
	// field is empty, this filter will not share a token bucket with any other filter.
	share_key?: string
}
