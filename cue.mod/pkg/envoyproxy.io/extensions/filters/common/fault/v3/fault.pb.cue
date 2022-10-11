package v3

import (
	v3 "envoyproxy.io/type/v3"
)

#FaultDelay_FaultDelayType: "FIXED"

FaultDelay_FaultDelayType_FIXED: "FIXED"

// Delay specification is used to inject latency into the
// HTTP/Mongo operation.
// [#next-free-field: 6]
#FaultDelay: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.fault.v3.FaultDelay"
	// Add a fixed delay before forwarding the operation upstream. See
	// https://developers.google.com/protocol-buffers/docs/proto3#json for
	// the JSON/YAML Duration mapping. For HTTP/Mongo, the specified
	// delay will be injected before a new request/operation.
	// This is required if type is FIXED.
	fixed_delay?: string
	// Fault delays are controlled via an HTTP header (if applicable).
	header_delay?: #FaultDelay_HeaderDelay
	// The percentage of operations/connections/requests on which the delay will be injected.
	percentage?: v3.#FractionalPercent
}

// Describes a rate limit to be applied.
#FaultRateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.fault.v3.FaultRateLimit"
	// A fixed rate limit.
	fixed_limit?: #FaultRateLimit_FixedLimit
	// Rate limits are controlled via an HTTP header (if applicable).
	header_limit?: #FaultRateLimit_HeaderLimit
	// The percentage of operations/connections/requests on which the rate limit will be injected.
	percentage?: v3.#FractionalPercent
}

// Fault delays are controlled via an HTTP header (if applicable). See the
// :ref:`HTTP fault filter <config_http_filters_fault_injection_http_header>` documentation for
// more information.
#FaultDelay_HeaderDelay: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.fault.v3.FaultDelay_HeaderDelay"
}

// Describes a fixed/constant rate limit.
#FaultRateLimit_FixedLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.fault.v3.FaultRateLimit_FixedLimit"
	// The limit supplied in KiB/s.
	limit_kbps?: uint64
}

// Rate limits are controlled via an HTTP header (if applicable). See the
// :ref:`HTTP fault filter <config_http_filters_fault_injection_http_header>` documentation for
// more information.
#FaultRateLimit_HeaderLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.fault.v3.FaultRateLimit_HeaderLimit"
}
