package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/ratelimit/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v33 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v34 "envoyproxy.io/envoy-cue/spec/type/metadata/v3"
)

// Defines the version of the standard to use for X-RateLimit headers.
//
// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.XRateLimitHeadersRFCVersion instead.]
#RateLimit_XRateLimitHeadersRFCVersion: "OFF" | "DRAFT_VERSION_03"

RateLimit_XRateLimitHeadersRFCVersion_OFF:              "OFF"
RateLimit_XRateLimitHeadersRFCVersion_DRAFT_VERSION_03: "DRAFT_VERSION_03"

#RateLimitConfig_Action_MetaData_Source: "DYNAMIC" | "ROUTE_ENTRY"

RateLimitConfig_Action_MetaData_Source_DYNAMIC:     "DYNAMIC"
RateLimitConfig_Action_MetaData_Source_ROUTE_ENTRY: "ROUTE_ENTRY"

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

// [#next-free-field: 12]
#RateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimit"
	// The rate limit domain to use when calling the rate limit service.
	domain?: string
	// Specifies the rate limit configurations to be applied with the same
	// stage number. If not set, the default stage number is 0.
	//
	// .. note::
	//
	//  The filter supports a range of 0 - 10 inclusively for stage numbers.
	stage?: uint32
	// The type of requests the filter should apply to. The supported
	// types are ``internal``, ``external`` or ``both``. A request is considered internal if
	// :ref:`x-envoy-internal<config_http_conn_man_headers_x-envoy-internal>` is set to true. If
	// :ref:`x-envoy-internal<config_http_conn_man_headers_x-envoy-internal>` is not set or false, a
	// request is considered external. The filter defaults to ``both``, and it will apply to all request
	// types.
	request_type?: string
	// The timeout in milliseconds for the rate limit service RPC. If not
	// set, this defaults to 20ms.
	timeout?: string
	// The filter's behaviour in case the rate limiting service does
	// not respond back. When it is set to true, Envoy will not allow traffic in case of
	// communication failure between rate limiting service and the proxy.
	failure_mode_deny?: bool
	// Specifies whether a ``RESOURCE_EXHAUSTED`` gRPC code must be returned instead
	// of the default ``UNAVAILABLE`` gRPC code for a rate limited gRPC call. The
	// HTTP code will be 200 for a gRPC response.
	rate_limited_as_resource_exhausted?: bool
	// Configuration for an external rate limit service provider. If not
	// specified, any calls to the rate limit service will immediately return
	// success.
	rate_limit_service?: v3.#RateLimitServiceConfig
	// Defines the standard version to use for X-RateLimit headers emitted by the filter:
	//
	// * ``X-RateLimit-Limit`` - indicates the request-quota associated to the
	//   client in the current time-window followed by the description of the
	//   quota policy. The values are returned by the rate limiting service in
	//   :ref:`current_limit<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.current_limit>`
	//   field. Example: ``10, 10;w=1;name="per-ip", 1000;w=3600``.
	// * ``X-RateLimit-Remaining`` - indicates the remaining requests in the
	//   current time-window. The values are returned by the rate limiting service
	//   in :ref:`limit_remaining<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.limit_remaining>`
	//   field.
	// * ``X-RateLimit-Reset`` - indicates the number of seconds until reset of
	//   the current time-window. The values are returned by the rate limiting service
	//   in :ref:`duration_until_reset<envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.DescriptorStatus.duration_until_reset>`
	//   field.
	//
	// In case rate limiting policy specifies more then one time window, the values
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
	//   If this is set to < 400, 429 will be used instead.
	rate_limited_status?: v31.#HttpStatus
	// Specifies a list of HTTP headers that should be added to each response for requests that
	// have been rate limited.
	response_headers_to_add?: [...v32.#HeaderValueOption]
}

// Global rate limiting :ref:`architecture overview <arch_overview_global_rate_limit>`.
// Also applies to Local rate limiting :ref:`using descriptors <config_http_filters_local_rate_limit_descriptors>`.
// [#not-implemented-hide:]
#RateLimitConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig"
	// Refers to the stage set in the filter. The rate limit configuration only
	// applies to filters with the same stage number. The default stage number is
	// 0.
	//
	// .. note::
	//
	//   The filter supports a range of 0 - 10 inclusively for stage numbers.
	stage?: uint32
	// The key to be set in runtime to disable this rate limit configuration.
	disable_key?: string
	// A list of actions that are to be applied for this rate limit configuration.
	// Order matters as the actions are processed sequentially and the descriptor
	// is composed by appending descriptor entries in that sequence. If an action
	// cannot append a descriptor entry, no descriptor is generated for the
	// configuration. See :ref:`composing actions
	// <config_http_filters_rate_limit_composing_actions>` for additional documentation.
	actions?: [...#RateLimitConfig_Action]
	// An optional limit override to be appended to the descriptor produced by this
	// rate limit configuration. If the override value is invalid or cannot be resolved
	// from metadata, no override is provided. See :ref:`rate limit override
	// <config_http_filters_rate_limit_rate_limit_override>` for more information.
	limit?: #RateLimitConfig_Override
}

#RateLimitPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitPerRoute"
	// Specifies if the rate limit filter should include the virtual host rate limits.
	// [#next-major-version: unify with local ratelimit, should use common.ratelimit.v3.VhRateLimitsOptions instead.]
	vh_rate_limits?: #RateLimitPerRoute_VhRateLimitsOptions
	// Specifies if the rate limit filter should include the lower levels (route level, virtual host level or cluster weight level) rate limits override options.
	// [#not-implemented-hide:]
	override_option?: #RateLimitPerRoute_OverrideOptions
	// Rate limit configuration. If not set, uses the
	// :ref:`VirtualHost.rate_limits<envoy_v3_api_field_config.route.v3.VirtualHost.rate_limits>` or
	// :ref:`RouteAction.rate_limits<envoy_v3_api_field_config.route.v3.RouteAction.rate_limits>` fields instead.
	// [#not-implemented-hide:]
	rate_limits?: [...#RateLimitConfig]
}

// [#next-free-field: 10]
#RateLimitConfig_Action: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action"
	// Rate limit on source cluster.
	source_cluster?: #RateLimitConfig_Action_SourceCluster
	// Rate limit on destination cluster.
	destination_cluster?: #RateLimitConfig_Action_DestinationCluster
	// Rate limit on request headers.
	request_headers?: #RateLimitConfig_Action_RequestHeaders
	// Rate limit on remote address.
	remote_address?: #RateLimitConfig_Action_RemoteAddress
	// Rate limit on a generic key.
	generic_key?: #RateLimitConfig_Action_GenericKey
	// Rate limit on the existence of request headers.
	header_value_match?: #RateLimitConfig_Action_HeaderValueMatch
	// Rate limit on metadata.
	metadata?: #RateLimitConfig_Action_MetaData
	// Rate limit descriptor extension. See the rate limit descriptor extensions documentation.
	// [#extension-category: envoy.rate_limit_descriptors]
	extension?: v32.#TypedExtensionConfig
}

#RateLimitConfig_Override: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Override"
	// Limit override from dynamic metadata.
	dynamic_metadata?: #RateLimitConfig_Override_DynamicMetadata
}

// The following descriptor entry is appended to the descriptor:
//
// .. code-block:: cpp
//
//   ("source_cluster", "<local service cluster>")
//
// <local service cluster> is derived from the :option:`--service-cluster` option.
#RateLimitConfig_Action_SourceCluster: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_SourceCluster"
}

// The following descriptor entry is appended to the descriptor:
//
// .. code-block:: cpp
//
//   ("destination_cluster", "<routed target cluster>")
//
// Once a request matches against a route table rule, a routed cluster is determined by one of
// the following :ref:`route table configuration <envoy_v3_api_msg_config.route.v3.RouteConfiguration>`
// settings:
//
// * :ref:`cluster <envoy_v3_api_field_config.route.v3.RouteAction.cluster>` indicates the upstream cluster
//   to route to.
// * :ref:`weighted_clusters <envoy_v3_api_field_config.route.v3.RouteAction.weighted_clusters>`
//   chooses a cluster randomly from a set of clusters with attributed weight.
// * :ref:`cluster_header <envoy_v3_api_field_config.route.v3.RouteAction.cluster_header>` indicates which
//   header in the request contains the target cluster.
#RateLimitConfig_Action_DestinationCluster: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_DestinationCluster"
}

// The following descriptor entry is appended when a header contains a key that matches the
// ``header_name``:
//
// .. code-block:: cpp
//
//   ("<descriptor_key>", "<header_value_queried_from_header>")
#RateLimitConfig_Action_RequestHeaders: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_RequestHeaders"
	// The header name to be queried from the request headers. The header’s
	// value is used to populate the value of the descriptor entry for the
	// descriptor_key.
	header_name?: string
	// The key to use in the descriptor entry.
	descriptor_key?: string
	// If set to true, Envoy skips the descriptor while calling rate limiting service
	// when header is not present in the request. By default it skips calling the
	// rate limiting service if this header is not present in the request.
	skip_if_absent?: bool
}

// The following descriptor entry is appended to the descriptor and is populated using the
// trusted address from :ref:`x-forwarded-for <config_http_conn_man_headers_x-forwarded-for>`:
//
// .. code-block:: cpp
//
//   ("remote_address", "<trusted address from x-forwarded-for>")
#RateLimitConfig_Action_RemoteAddress: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_RemoteAddress"
}

// The following descriptor entry is appended to the descriptor:
//
// .. code-block:: cpp
//
//   ("generic_key", "<descriptor_value>")
#RateLimitConfig_Action_GenericKey: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_GenericKey"
	// The value to use in the descriptor entry.
	descriptor_value?: string
	// An optional key to use in the descriptor entry. If not set it defaults
	// to 'generic_key' as the descriptor key.
	descriptor_key?: string
}

// The following descriptor entry is appended to the descriptor:
//
// .. code-block:: cpp
//
//   ("header_match", "<descriptor_value>")
#RateLimitConfig_Action_HeaderValueMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_HeaderValueMatch"
	// The value to use in the descriptor entry.
	descriptor_value?: string
	// If set to true, the action will append a descriptor entry when the
	// request matches the headers. If set to false, the action will append a
	// descriptor entry when the request does not match the headers. The
	// default value is true.
	expect_match?: bool
	// Specifies a set of headers that the rate limit action should match
	// on. The action will check the request’s headers against all the
	// specified headers in the config. A match will happen if all the
	// headers in the config are present in the request with the same values
	// (or based on presence if the value field is not in the config).
	headers?: [...v33.#HeaderMatcher]
}

// The following descriptor entry is appended when the metadata contains a key value:
//
// .. code-block:: cpp
//
//   ("<descriptor_key>", "<value_queried_from_metadata>")
#RateLimitConfig_Action_MetaData: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Action_MetaData"
	// The key to use in the descriptor entry.
	descriptor_key?: string
	// Metadata struct that defines the key and path to retrieve the string value. A match will
	// only happen if the value in the metadata is of type string.
	metadata_key?: v34.#MetadataKey
	// An optional value to use if ``metadata_key`` is empty. If not set and
	// no value is present under the metadata_key then no descriptor is generated.
	default_value?: string
	// Source of metadata
	source?: #RateLimitConfig_Action_MetaData_Source
}

// Fetches the override from the dynamic metadata.
#RateLimitConfig_Override_DynamicMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimitConfig_Override_DynamicMetadata"
	// Metadata struct that defines the key and path to retrieve the struct value.
	// The value must be a struct containing an integer "requests_per_unit" property
	// and a "unit" property with a value parseable to :ref:`RateLimitUnit
	// enum <envoy_v3_api_enum_type.v3.RateLimitUnit>`
	metadata_key?: v34.#MetadataKey
}
