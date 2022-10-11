package v2

import (
	_type "envoyproxy.io/type"
)

#FaultDelay_FaultDelayType: "FIXED"

FaultDelay_FaultDelayType_FIXED: "FIXED"

// Delay specification is used to inject latency into the
// HTTP/gRPC/Mongo/Redis operation or delay proxying of TCP connections.
// [#next-free-field: 6]
#FaultDelay: {
	"@type": "type.googleapis.com/envoy.config.filter.fault.v2.FaultDelay"
	// Unused and deprecated. Will be removed in the next release.
	//
	// Deprecated: Do not use.
	type?: #FaultDelay_FaultDelayType
	// Add a fixed delay before forwarding the operation upstream. See
	// https://developers.google.com/protocol-buffers/docs/proto3#json for
	// the JSON/YAML Duration mapping. For HTTP/Mongo/Redis, the specified
	// delay will be injected before a new request/operation. For TCP
	// connections, the proxying of the connection upstream will be delayed
	// for the specified period. This is required if type is FIXED.
	fixed_delay?: string
	// Fault delays are controlled via an HTTP header (if applicable).
	header_delay?: #FaultDelay_HeaderDelay
	// The percentage of operations/connections/requests on which the delay will be injected.
	percentage?: _type.#FractionalPercent
}

// Describes a rate limit to be applied.
#FaultRateLimit: {
	"@type": "type.googleapis.com/envoy.config.filter.fault.v2.FaultRateLimit"
	// A fixed rate limit.
	fixed_limit?: #FaultRateLimit_FixedLimit
	// Rate limits are controlled via an HTTP header (if applicable).
	header_limit?: #FaultRateLimit_HeaderLimit
	// The percentage of operations/connections/requests on which the rate limit will be injected.
	percentage?: _type.#FractionalPercent
}

// Fault delays are controlled via an HTTP header (if applicable). See the
// :ref:`HTTP fault filter <config_http_filters_fault_injection_http_header>` documentation for
// more information.
#FaultDelay_HeaderDelay: {
	"@type": "type.googleapis.com/envoy.config.filter.fault.v2.FaultDelay_HeaderDelay"
}

// Describes a fixed/constant rate limit.
#FaultRateLimit_FixedLimit: {
	"@type": "type.googleapis.com/envoy.config.filter.fault.v2.FaultRateLimit_FixedLimit"
	// The limit supplied in KiB/s.
	limit_kbps?: uint64
}

// Rate limits are controlled via an HTTP header (if applicable). See the
// :ref:`HTTP fault filter <config_http_filters_fault_injection_http_header>` documentation for
// more information.
#FaultRateLimit_HeaderLimit: {
	"@type": "type.googleapis.com/envoy.config.filter.fault.v2.FaultRateLimit_HeaderLimit"
}
