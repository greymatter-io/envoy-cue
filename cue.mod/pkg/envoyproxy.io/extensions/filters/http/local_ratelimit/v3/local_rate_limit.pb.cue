package v3

import (
	v3 "envoyproxy.io/type/v3"
	v31 "envoyproxy.io/config/core/v3"
	v32 "envoyproxy.io/extensions/common/ratelimit/v3"
	v33 "envoyproxy.io/config/route/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// [#next-free-field: 18]
#LocalRateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.local_ratelimit.v3.LocalRateLimit"
	// The human readable prefix to use when emitting stats.
	stat_prefix?: string
	// This field allows for a custom HTTP response status code to the downstream client when
	// the request has been rate limited.
	// Defaults to 429 (TooManyRequests).
	//
	// .. note::
	//
	//	If this is set to < 400, 429 will be used instead.
	status?: v3.#HttpStatus
	// The token bucket configuration to use for rate limiting requests that are processed by this
	// filter. Each request processed by the filter consumes a single token. If the token is available,
	// the request will be allowed. If no tokens are available, the request will receive the configured
	// rate limit status.
	//
	// .. note::
	//
	//	It's fine for the token bucket to be unset for the global configuration since the rate limit
	//	can be applied at a the virtual host or route level. Thus, the token bucket must be set
	//	for the per route configuration otherwise the config will be rejected.
	//
	// .. note::
	//
	//	When using per route configuration, the bucket becomes unique to that route.
	//
	// .. note::
	//
	//	In the current implementation the token bucket's :ref:`fill_interval
	//	<envoy_v3_api_field_type.v3.TokenBucket.fill_interval>` must be >= 50ms to avoid too aggressive
	//	refills.
	token_bucket?: v3.#TokenBucket
	// If set, this will enable -- but not necessarily enforce -- the rate limit for the given
	// fraction of requests.
	// Defaults to 0% of requests for safety.
	filter_enabled?: v31.#RuntimeFractionalPercent
	// If set, this will enforce the rate limit decisions for the given fraction of requests.
	//
	// Note: this only applies to the fraction of enabled requests.
	//
	// Defaults to 0% of requests for safety.
	filter_enforced?: v31.#RuntimeFractionalPercent
	// Specifies a list of HTTP headers that should be added to each request that
	// has been rate limited and is also forwarded upstream. This can only occur when the
	// filter is enabled but not enforced.
	request_headers_to_add_when_not_enforced?: [...v31.#HeaderValueOption]
	// Specifies a list of HTTP headers that should be added to each response for requests that
	// have been rate limited. This occurs when the filter is enabled and fully enforced.
	response_headers_to_add?: [...v31.#HeaderValueOption]
	// The rate limit descriptor list to use in the local rate limit to override
	// on. The rate limit descriptor is selected by the first full match from the
	// request descriptors.
	//
	// Example on how to use :ref:`this <config_http_filters_local_rate_limit_descriptors>`.
	//
	// .. note::
	//
	//	In the current implementation the descriptor's token bucket :ref:`fill_interval
	//	<envoy_v3_api_field_type.v3.TokenBucket.fill_interval>` must be a multiple
	//	global :ref:`token bucket's<envoy_v3_api_field_extensions.filters.http.local_ratelimit.v3.LocalRateLimit.token_bucket>` fill interval.
	//
	//	The descriptors must match verbatim for rate limiting to apply. There is no partial
	//	match by a subset of descriptor entries in the current implementation.
	descriptors?: [...v32.#LocalRateLimitDescriptor]
	// Specifies the rate limit configurations to be applied with the same
	// stage number. If not set, the default stage number is 0.
	//
	// .. note::
	//
	//	The filter supports a range of 0 - 10 inclusively for stage numbers.
	stage?: uint32
	// Specifies the scope of the rate limiter's token bucket.
	// If set to false, the token bucket is shared across all worker threads,
	// thus the rate limits are applied per Envoy process.
	// If set to true, a token bucket is allocated for each connection.
	// Thus the rate limits are applied per connection thereby allowing
	// one to rate limit requests on a per connection basis.
	// If unspecified, the default value is false.
	local_rate_limit_per_downstream_connection?: bool
	// Enables the local cluster level rate limiting, iff this is set explicitly. For example,
	// given an Envoy gateway that contains N Envoy instances and a rate limit rule X tokens
	// per second. If this is set, the total rate limit of whole gateway will always be X tokens
	// per second regardless of how N changes. If this is not set, the total rate limit of whole
	// gateway will be N * X tokens per second.
	//
	// .. note::
	//
	//	This should never be set if the ``local_rate_limit_per_downstream_connection`` is set to
	//	true. Because if per connection rate limiting is enabled, we assume that the token buckets
	//	should never be shared across Envoy instances.
	//
	// .. note::
	//
	//	This only works when the :ref:`local cluster name
	//	<envoy_v3_api_field_config.bootstrap.v3.ClusterManager.local_cluster_name>` is set and
	//	the related cluster is defined in the bootstrap configuration.
	local_cluster_rate_limit?: v32.#LocalClusterRateLimit
	// Defines the standard version to use for X-RateLimit headers emitted by the filter.
	//
	// Disabled by default.
	enable_x_ratelimit_headers?: v32.#XRateLimitHeadersRFCVersion
	// Specifies if the local rate limit filter should include the virtual host rate limits.
	vh_rate_limits?: v32.#VhRateLimitsOptions
	// Specifies if default token bucket should be always consumed.
	// If set to false, default token bucket will only be consumed when there is
	// no matching descriptor. If set to true, default token bucket will always
	// be consumed. Default is true.
	always_consume_default_token_bucket?: wrapperspb.#BoolValue
	// Specifies whether a “RESOURCE_EXHAUSTED“ gRPC code must be returned instead
	// of the default “UNAVAILABLE“ gRPC code for a rate limited gRPC call. The
	// HTTP code will be 200 for a gRPC response.
	rate_limited_as_resource_exhausted?: bool
	// Rate limit configuration that is used to generate a list of descriptor entries based on
	// the request context. The generated entries will be used to find one or multiple matched rate
	// limit rule from the “descriptors“.
	// If this is set, then
	// :ref:`VirtualHost.rate_limits<envoy_v3_api_field_config.route.v3.VirtualHost.rate_limits>` or
	// :ref:`RouteAction.rate_limits<envoy_v3_api_field_config.route.v3.RouteAction.rate_limits>` fields
	// will be ignored.
	//
	// .. note::
	//
	//	Not all configuration fields of
	//	:ref:`rate limit config <envoy_v3_api_msg_config.route.v3.RateLimit>` is supported at here.
	//	Following fields are not supported:
	//
	//	1. :ref:`rate limit stage <envoy_v3_api_field_config.route.v3.RateLimit.stage>`.
	//	2. :ref:`dynamic metadata <envoy_v3_api_field_config.route.v3.RateLimit.Action.dynamic_metadata>`.
	//	3. :ref:`disable_key <envoy_v3_api_field_config.route.v3.RateLimit.disable_key>`.
	//	4. :ref:`override limit <envoy_v3_api_field_config.route.v3.RateLimit.limit>`.
	rate_limits?: [...v33.#RateLimit]
}
