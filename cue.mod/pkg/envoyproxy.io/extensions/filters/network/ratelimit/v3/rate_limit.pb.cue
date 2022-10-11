package v3

import (
	v3 "envoyproxy.io/extensions/common/ratelimit/v3"
	v31 "envoyproxy.io/config/ratelimit/v3"
)

// [#next-free-field: 7]
#RateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ratelimit.v3.RateLimit"
	// The prefix to use when emitting :ref:`statistics <config_network_filters_rate_limit_stats>`.
	stat_prefix?: string
	// The rate limit domain to use in the rate limit service request.
	domain?: string
	// The rate limit descriptor list to use in the rate limit service request.
	descriptors?: [...v3.#RateLimitDescriptor]
	// The timeout in milliseconds for the rate limit service RPC. If not
	// set, this defaults to 20ms.
	timeout?: string
	// The filter's behaviour in case the rate limiting service does
	// not respond back. When it is set to true, Envoy will not allow traffic in case of
	// communication failure between rate limiting service and the proxy.
	// Defaults to false.
	failure_mode_deny?: bool
	// Configuration for an external rate limit service provider. If not
	// specified, any calls to the rate limit service will immediately return
	// success.
	rate_limit_service?: v31.#RateLimitServiceConfig
}
