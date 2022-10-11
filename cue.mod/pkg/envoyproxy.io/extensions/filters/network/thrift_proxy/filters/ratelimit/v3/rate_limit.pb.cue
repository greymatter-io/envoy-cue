package v3

import (
	v3 "envoyproxy.io/config/ratelimit/v3"
)

// [#next-free-field: 6]
#RateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.ratelimit.v3.RateLimit"
	// The rate limit domain to use in the rate limit service request.
	domain?: string
	// Specifies the rate limit configuration stage. Each configured rate limit filter performs a
	// rate limit check using descriptors configured in the
	// :ref:`envoy_v3_api_msg_extensions.filters.network.thrift_proxy.v3.RouteAction` for the request.
	// Only those entries with a matching stage number are used for a given filter. If not set, the
	// default stage number is 0.
	//
	// .. note::
	//
	//  The filter supports a range of 0 - 10 inclusively for stage numbers.
	stage?: uint32
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
	rate_limit_service?: v3.#RateLimitServiceConfig
}
