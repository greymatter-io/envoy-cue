package v2

import (
	core "envoyproxy.io/api/v2/core"
	ratelimit "envoyproxy.io/api/v2/ratelimit"
)

#RateLimitResponse_Code: "UNKNOWN" | "OK" | "OVER_LIMIT"

RateLimitResponse_Code_UNKNOWN:    "UNKNOWN"
RateLimitResponse_Code_OK:         "OK"
RateLimitResponse_Code_OVER_LIMIT: "OVER_LIMIT"

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
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.RateLimitRequest"
	// All rate limit requests must specify a domain. This enables the configuration to be per
	// application without fear of overlap. E.g., "envoy".
	domain?: string
	// All rate limit requests must specify at least one RateLimitDescriptor. Each descriptor is
	// processed by the service (see below). If any of the descriptors are over limit, the entire
	// request is considered to be over limit.
	descriptors?: [...ratelimit.#RateLimitDescriptor]
	// Rate limit requests can optionally specify the number of hits a request adds to the matched
	// limit. If the value is not set in the message, a request increases the matched limit by 1.
	hits_addend?: uint32
}

// A response from a ShouldRateLimit call.
#RateLimitResponse: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.RateLimitResponse"
	// The overall response code which takes into account all of the descriptors that were passed
	// in the RateLimitRequest message.
	overall_code?: #RateLimitResponse_Code
	// A list of DescriptorStatus messages which matches the length of the descriptor list passed
	// in the RateLimitRequest. This can be used by the caller to determine which individual
	// descriptors failed and/or what the currently configured limits are for all of them.
	statuses?: [...#RateLimitResponse_DescriptorStatus]
	// A list of headers to add to the response
	headers?: [...core.#HeaderValue]
	// A list of headers to add to the request when forwarded
	request_headers_to_add?: [...core.#HeaderValue]
}

// Defines an actual rate limit in terms of requests per unit of time and the unit itself.
#RateLimitResponse_RateLimit: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.RateLimitResponse_RateLimit"
	// A name or description of this limit.
	name?: string
	// The number of requests per unit of time.
	requests_per_unit?: uint32
	// The unit of time.
	unit?: #RateLimitResponse_RateLimit_Unit
}

#RateLimitResponse_DescriptorStatus: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.RateLimitResponse_DescriptorStatus"
	// The response code for an individual descriptor.
	code?: #RateLimitResponse_Code
	// The current limit as configured by the server. Useful for debugging, etc.
	current_limit?: #RateLimitResponse_RateLimit
	// The limit remaining in the current time unit.
	limit_remaining?: uint32
}

// RateLimitServiceClient is the client API for RateLimitService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#RateLimitServiceClient: _

// RateLimitServiceServer is the server API for RateLimitService service.
#RateLimitServiceServer: _

// UnimplementedRateLimitServiceServer can be embedded to have forward compatible implementations.
#UnimplementedRateLimitServiceServer: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.UnimplementedRateLimitServiceServer"
}
