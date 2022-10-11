package v3

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	v3 "envoyproxy.io/extensions/common/ratelimit/v3"
	v31 "envoyproxy.io/config/core/v3"
)

#RateLimitResponse_Code: "UNKNOWN" | "OK" | "OVER_LIMIT"

RateLimitResponse_Code_UNKNOWN:    "UNKNOWN"
RateLimitResponse_Code_OK:         "OK"
RateLimitResponse_Code_OVER_LIMIT: "OVER_LIMIT"

// Identifies the unit of of time for rate limit.
// [#comment: replace by envoy/type/v3/ratelimit_unit.proto in v4]
#RateLimitResponse_RateLimit_Unit: "UNKNOWN" | "SECOND" | "MINUTE" | "HOUR" | "DAY"

RateLimitResponse_RateLimit_Unit_UNKNOWN: "UNKNOWN"
RateLimitResponse_RateLimit_Unit_SECOND:  "SECOND"
RateLimitResponse_RateLimit_Unit_MINUTE:  "MINUTE"
RateLimitResponse_RateLimit_Unit_HOUR:    "HOUR"
RateLimitResponse_RateLimit_Unit_DAY:     "DAY"

// Main message for a rate limit request. The rate limit service is designed to be fully generic
// in the sense that it can operate on arbitrary hierarchical key/value pairs. The loaded
// configuration will parse the request and find the most specific limit to apply. In addition,
// a RateLimitRequest can contain multiple "descriptors" to limit on. When multiple descriptors
// are provided, the server will limit on *ALL* of them and return an OVER_LIMIT response if any
// of them are over limit. This enables more complex application level rate limiting scenarios
// if desired.
#RateLimitRequest: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.RateLimitRequest"
	// All rate limit requests must specify a domain. This enables the configuration to be per
	// application without fear of overlap. E.g., "envoy".
	domain?: string
	// All rate limit requests must specify at least one RateLimitDescriptor. Each descriptor is
	// processed by the service (see below). If any of the descriptors are over limit, the entire
	// request is considered to be over limit.
	descriptors?: [...v3.#RateLimitDescriptor]
	// Rate limit requests can optionally specify the number of hits a request adds to the matched
	// limit. If the value is not set in the message, a request increases the matched limit by 1.
	hits_addend?: uint32
}

// A response from a ShouldRateLimit call.
// [#next-free-field: 8]
#RateLimitResponse: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.RateLimitResponse"
	// The overall response code which takes into account all of the descriptors that were passed
	// in the RateLimitRequest message.
	overall_code?: #RateLimitResponse_Code
	// A list of DescriptorStatus messages which matches the length of the descriptor list passed
	// in the RateLimitRequest. This can be used by the caller to determine which individual
	// descriptors failed and/or what the currently configured limits are for all of them.
	statuses?: [...#RateLimitResponse_DescriptorStatus]
	// A list of headers to add to the response
	response_headers_to_add?: [...v31.#HeaderValue]
	// A list of headers to add to the request when forwarded
	request_headers_to_add?: [...v31.#HeaderValue]
	// A response body to send to the downstream client when the response code is not OK.
	raw_body?: bytes
	// Optional response metadata that will be emitted as dynamic metadata to be consumed by the next
	// filter. This metadata lives in a namespace specified by the canonical name of extension filter
	// that requires it:
	//
	// - :ref:`envoy.filters.http.ratelimit <config_http_filters_ratelimit_dynamic_metadata>` for HTTP filter.
	// - :ref:`envoy.filters.network.ratelimit <config_network_filters_ratelimit_dynamic_metadata>` for network filter.
	// - :ref:`envoy.filters.thrift.rate_limit <config_thrift_filters_rate_limit_dynamic_metadata>` for Thrift filter.
	dynamic_metadata?: _struct.#Struct
	// Quota is available for a request if its entire descriptor set has cached quota available.
	// This is a union of all descriptors in the descriptor set. Clients can use the quota for future matches if and only if the descriptor set matches what was sent in the request that originated this response.
	//
	// If quota is available, a RLS request will not be made and the quota will be reduced by 1.
	// If quota is not available (i.e., a cached entry doesn't exist for a RLS descriptor set), a RLS request will be triggered.
	// If the server did not provide a quota, such as the quota message is empty then the request admission is determined by the
	// :ref:`overall_code <envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.overall_code>`.
	//
	// If there is not sufficient quota and the cached entry exists for a RLS descriptor set is out-of-quota but not expired,
	// the request will be treated as OVER_LIMIT.
	// [#not-implemented-hide:]
	quota?: #RateLimitResponse_Quota
}

// Defines an actual rate limit in terms of requests per unit of time and the unit itself.
#RateLimitResponse_RateLimit: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.RateLimitResponse_RateLimit"
	// A name or description of this limit.
	name?: string
	// The number of requests per unit of time.
	requests_per_unit?: uint32
	// The unit of time.
	unit?: #RateLimitResponse_RateLimit_Unit
}

// Cacheable quota for responses.
// Quota can be granted at different levels: either for each individual descriptor or for the whole descriptor set.
// This is a certain number of requests over a period of time.
// The client may cache this result and apply the effective RateLimitResponse to future matching
// requests without querying rate limit service.
//
// When quota expires due to timeout, a new RLS request will also be made.
// The implementation may choose to preemptively query the rate limit server for more quota on or
// before expiration or before the available quota runs out.
// [#not-implemented-hide:]
#RateLimitResponse_Quota: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.RateLimitResponse_Quota"
	// Number of matching requests granted in quota. Must be 1 or more.
	requests?: uint32
	// Point in time at which the quota expires.
	valid_until?: string
	// The unique id that is associated with each Quota either at individual descriptor level or whole descriptor set level.
	//
	// For a matching policy with boolean logic, for example, match: "request.headers['environment'] == 'staging' || request.headers['environment'] == 'dev'"),
	// the request_headers action produces a distinct list of descriptors for each possible value of the ‘environment’ header even though the granted quota is same.
	// Thus, the client will use this id information (returned from RLS server) to correctly correlate the multiple descriptors/descriptor sets that have been granted with same quota (i.e., share the same quota among multiple descriptors or descriptor sets.)
	//
	// If id is empty, this id field will be ignored. If quota for the same id changes (e.g. due to configuration update), the old quota will be overridden by the new one. Shared quotas referenced by ID will still adhere to expiration after `valid_until`.
	id?: string
}

// [#next-free-field: 6]
#RateLimitResponse_DescriptorStatus: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.RateLimitResponse_DescriptorStatus"
	// The response code for an individual descriptor.
	code?: #RateLimitResponse_Code
	// The current limit as configured by the server. Useful for debugging, etc.
	current_limit?: #RateLimitResponse_RateLimit
	// The limit remaining in the current time unit.
	limit_remaining?: uint32
	// Duration until reset of the current limit window.
	duration_until_reset?: string
	// Quota is available for a request if its descriptor set has cached quota available for all
	// descriptors.
	// This is for each individual descriptor in the descriptor set. The client will perform matches for each individual descriptor against available per-descriptor quota.
	//
	// If quota is available, a RLS request will not be made and the quota will be reduced by 1 for
	// all matching descriptors.
	//
	// If there is not sufficient quota, there are three cases:
	// 1. A cached entry exists for a RLS descriptor that is out-of-quota, but not expired.
	//    In this case, the request will be treated as OVER_LIMIT.
	// 2. Some RLS descriptors have a cached entry that has valid quota but some RLS descriptors
	//    have no cached entry. This will trigger a new RLS request.
	//    When the result is returned, a single unit will be consumed from the quota for all
	//    matching descriptors.
	//    If the server did not provide a quota, such as the quota message is empty for some of
	//    the descriptors, then the request admission is determined by the
	//    :ref:`overall_code <envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.overall_code>`.
	// 3. All RLS descriptors lack a cached entry, this will trigger a new RLS request,
	//    When the result is returned, a single unit will be consumed from the quota for all
	//    matching descriptors.
	//    If the server did not provide a quota, such as the quota message is empty for some of
	//    the descriptors, then the request admission is determined by the
	//    :ref:`overall_code <envoy_v3_api_field_service.ratelimit.v3.RateLimitResponse.overall_code>`.
	// [#not-implemented-hide:]
	quota?: #RateLimitResponse_Quota
}

// RateLimitServiceClient is the client API for RateLimitService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#RateLimitServiceClient: _

// RateLimitServiceServer is the server API for RateLimitService service.
#RateLimitServiceServer: _

// UnimplementedRateLimitServiceServer can be embedded to have forward compatible implementations.
#UnimplementedRateLimitServiceServer: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v3.UnimplementedRateLimitServiceServer"
}
