package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/ratelimit/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v33 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

// Defines the version of the standard to use for X-RateLimit headers.
//
// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.XRateLimitHeadersRFCVersion instead.]
#RateLimit_XRateLimitHeadersRFCVersion: "OFF" | "DRAFT_VERSION_03"

RateLimit_XRateLimitHeadersRFCVersion_OFF:              "OFF"
RateLimit_XRateLimitHeadersRFCVersion_DRAFT_VERSION_03: "DRAFT_VERSION_03"

// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.VhRateLimitsOptions instead.]
#RateLimitPerRoute_VhRateLimitsOptions: "OVERRIDE" | "INCLUDE" | "IGNORE"

RateLimitPerRoute_VhRateLimitsOptions_OVERRIDE: "OVERRIDE"
RateLimitPerRoute_VhRateLimitsOptions_INCLUDE:  "INCLUDE"
RateLimitPerRoute_VhRateLimitsOptions_IGNORE:   "IGNORE"

// The override option determines how the filter handles the cases where there is an override config at a more specific level than this one (from least to most specific: virtual host, route, cluster weight).
// [#not-implemented-hide:]
#RateLimitPerRoute_OverrideOptions: "DEFAULT" | "OVERRIDE_POLICY" | "INCLUDE_POLICY" | "IGNORE_POLICY"

RateLimitPerRoute_OverrideOptions_DEFAULT:         "DEFAULT"
RateLimitPerRoute_OverrideOptions_OVERRIDE_POLICY: "OVERRIDE_POLICY"
RateLimitPerRoute_OverrideOptions_INCLUDE_POLICY:  "INCLUDE_POLICY"
RateLimitPerRoute_OverrideOptions_IGNORE_POLICY:   "IGNORE_POLICY"

// [#next-free-field: 19]
#RateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimit"
	// The rate limit domain to use when calling the rate limit service.
	domain?: string
	// Specifies the rate limit configurations to be applied with the same
	// stage number. If not set, the default stage number is 0.
	//
	// .. note::
	//
	//	The filter supports a range of 0 - 10 inclusively for stage numbers.
	stage?: uint32
	// The type of requests the filter should apply to. The supported
	// types are “internal“, “external“ or “both“. A request is considered internal if
	// :ref:`x-envoy-internal<config_http_conn_man_headers_x-envoy-internal>` is set to true. If
	// :ref:`x-envoy-internal<config_http_conn_man_headers_x-envoy-internal>` is not set or false, a
	// request is considered external. The filter defaults to “both“, and it will apply to all request
	// types.
	request_type?: string
	// The timeout in milliseconds for the rate limit service RPC. If not
	// set, this defaults to 20ms. A value of 0 disables the timeout (infinite).
	timeout?: string
	// The filter's behaviour in case the rate limiting service does
	// not respond back. When it is set to true, Envoy will not allow traffic in case of
	// communication failure between rate limiting service and the proxy.
	failure_mode_deny?: bool
	// Specifies whether a “RESOURCE_EXHAUSTED“ gRPC code must be returned instead
	// of the default “UNAVAILABLE“ gRPC code for a rate limited gRPC call. The
	// HTTP code will be 200 for a gRPC response.
	rate_limited_as_resource_exhausted?: bool
	// Configuration for an external rate limit service provider. If not
	// specified, any calls to the rate limit service will immediately return
	// success.
	rate_limit_service?: v3.#RateLimitServiceConfig
	// Defines the standard version to use for X-RateLimit headers emitted by the filter:
	//
	//   - “X-RateLimit-Limit“ - indicates the request-quota associated to the
	//     client in the current time-window followed by the description of the
	//     quota policy. The values are returned by the rate limiting service in
	//     :ref:`current_limit<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.current_limit>`
	//     field. Example: “10, 10;w=1;name="per-ip", 1000;w=3600“.
	//   - “X-RateLimit-Remaining“ - indicates the remaining requests in the
	//     current time-window. The values are returned by the rate limiting service
	//     in :ref:`limit_remaining<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.limit_remaining>`
	//     field.
	//   - “X-RateLimit-Reset“ - indicates the number of seconds until reset of
	//     the current time-window. The values are returned by the rate limiting service
	//     in :ref:`duration_until_reset<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.duration_until_reset>`
	//     field.
	//
	// In case rate limiting policy specifies more than one time window, the values
	// above represent the window that is closest to reaching its limit.
	//
	// For more information about the headers specification see selected version of
	// the `draft RFC <https://tools.ietf.org/id/draft-polli-ratelimit-headers-03.html>`_.
	//
	// Disabled by default.
	//
	// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.XRateLimitHeadersRFCVersion instead.]
	enable_x_ratelimit_headers?: #RateLimit_XRateLimitHeadersRFCVersion
	// Disables emitting the :ref:`x-envoy-ratelimited<config_http_filters_router_x-envoy-ratelimited>` header
	// in case of rate limiting (i.e. 429 responses).
	// Having this header not present potentially makes the request retriable.
	disable_x_envoy_ratelimited_header?: bool
	// This field allows for a custom HTTP response status code to the downstream client when
	// the request has been rate limited.
	// Defaults to 429 (TooManyRequests).
	//
	// .. note::
	//
	//	If this is set to < 400, 429 will be used instead.
	rate_limited_status?: v31.#HttpStatus
	// Specifies a list of HTTP headers that should be added to each response for requests that
	// have been rate limited.
	response_headers_to_add?: [...v32.#HeaderValueOption]
	// Sets the HTTP status that is returned to the client when the ratelimit server returns an error
	// or cannot be reached. The default status is 500.
	status_on_error?: v31.#HttpStatus
	// Optional additional prefix to use when emitting statistics. This allows to distinguish
	// emitted statistics between configured “ratelimit“ filters in an HTTP filter chain.
	stat_prefix?: string
	// If set, this will enable -- but not necessarily enforce -- the rate limit for the given
	// fraction of requests.
	//
	// If not set then “ratelimit.http_filter_enabled“ runtime key will be used to determine
	// the fraction of requests to enforce rate limits on. And the default percentage of the
	// runtime key is 100% for backwards compatibility.
	filter_enabled?: v32.#RuntimeFractionalPercent
	// If set, this will enforce the rate limit decisions for the given fraction of requests.
	//
	// Note: this only applies to the fraction of enabled requests.
	//
	// If not set then “ratelimit.http_filter_enforcing“ runtime key will be used to determine
	// the fraction of requests to enforce rate limits on. And the default percentage of the
	// runtime key is 100% for backwards compatibility.
	filter_enforced?: v32.#RuntimeFractionalPercent
	// If set, this will override the failure_mode_deny parameter with a runtime fraction.
	// If the runtime key is not specified, the value of failure_mode_deny will be used.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//	failure_mode_deny: true
	//	failure_mode_deny_percent:
	//	  default_value:
	//	    numerator: 50
	//	    denominator: HUNDRED
	//	  runtime_key: ratelimit.failure_mode_deny_percent
	//
	// This means that when the rate limit service is unavailable, 50% of requests will be denied
	// (fail closed) and 50% will be allowed (fail open).
	failure_mode_deny_percent?: v32.#RuntimeFractionalPercent
	// Rate limit configuration that is used to generate a list of descriptor entries based on
	// the request context. The generated entries will be sent to the rate limit service.
	// If this is set, then
	// :ref:`VirtualHost.rate_limits<envoy_v3_api_field_config.route.v3.VirtualHost.rate_limits>` or
	// :ref:`RouteAction.rate_limits<envoy_v3_api_field_config.route.v3.RouteAction.rate_limits>` fields
	// will be ignored. However, :ref:`RateLimitPerRoute.rate_limits<envoy_v3_api_field_extensions.filters.http.ratelimit.v3.RateLimitPerRoute.rate_limits>`
	// will take precedence over this field.
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
	// The namespace where dynamic metadata from rate limit response is saved.
	// If not set, the default is "envoy.filters.http.ratelimit".
	metadata_namespace?: string
}

#RateLimitPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitPerRoute"
	// Specifies if the rate limit filter should include the virtual host rate limits.
	// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.VhRateLimitsOptions instead.]
	vh_rate_limits?: #RateLimitPerRoute_VhRateLimitsOptions
	// Specifies if the rate limit filter should include the lower levels (route level, virtual host level or cluster weight level) rate limits override options.
	// [#not-implemented-hide:]
	override_option?: #RateLimitPerRoute_OverrideOptions
	// Rate limit configuration that is used to generate a list of descriptor entries based on
	// the request context. The generated entries will be used to find one or multiple matched rate
	// limit rule from the “descriptors“.
	// If this is set, then
	// :ref:`VirtualHost.rate_limits<envoy_v3_api_field_config.route.v3.VirtualHost.rate_limits>`,
	// :ref:`RouteAction.rate_limits<envoy_v3_api_field_config.route.v3.RouteAction.rate_limits>` and
	// :ref:`RateLimit.rate_limits<envoy_v3_api_field_extensions.filters.http.ratelimit.v3.RateLimit.rate_limits>` fields
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
	// Overrides the domain. If not set, uses the filter-level domain instead.
	domain?: string
}
