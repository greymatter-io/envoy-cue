package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v33 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v34 "envoyproxy.io/envoy-cue/spec/data/accesslog/v3"
)

#ComparisonFilter_Op: "EQ" | "GE" | "LE" | "NE"

ComparisonFilter_Op_EQ: "EQ"
ComparisonFilter_Op_GE: "GE"
ComparisonFilter_Op_LE: "LE"
ComparisonFilter_Op_NE: "NE"

#GrpcStatusFilter_Status: "OK" | "CANCELED" | "UNKNOWN" | "INVALID_ARGUMENT" | "DEADLINE_EXCEEDED" | "NOT_FOUND" | "ALREADY_EXISTS" | "PERMISSION_DENIED" | "RESOURCE_EXHAUSTED" | "FAILED_PRECONDITION" | "ABORTED" | "OUT_OF_RANGE" | "UNIMPLEMENTED" | "INTERNAL" | "UNAVAILABLE" | "DATA_LOSS" | "UNAUTHENTICATED"

GrpcStatusFilter_Status_OK:                  "OK"
GrpcStatusFilter_Status_CANCELED:            "CANCELED"
GrpcStatusFilter_Status_UNKNOWN:             "UNKNOWN"
GrpcStatusFilter_Status_INVALID_ARGUMENT:    "INVALID_ARGUMENT"
GrpcStatusFilter_Status_DEADLINE_EXCEEDED:   "DEADLINE_EXCEEDED"
GrpcStatusFilter_Status_NOT_FOUND:           "NOT_FOUND"
GrpcStatusFilter_Status_ALREADY_EXISTS:      "ALREADY_EXISTS"
GrpcStatusFilter_Status_PERMISSION_DENIED:   "PERMISSION_DENIED"
GrpcStatusFilter_Status_RESOURCE_EXHAUSTED:  "RESOURCE_EXHAUSTED"
GrpcStatusFilter_Status_FAILED_PRECONDITION: "FAILED_PRECONDITION"
GrpcStatusFilter_Status_ABORTED:             "ABORTED"
GrpcStatusFilter_Status_OUT_OF_RANGE:        "OUT_OF_RANGE"
GrpcStatusFilter_Status_UNIMPLEMENTED:       "UNIMPLEMENTED"
GrpcStatusFilter_Status_INTERNAL:            "INTERNAL"
GrpcStatusFilter_Status_UNAVAILABLE:         "UNAVAILABLE"
GrpcStatusFilter_Status_DATA_LOSS:           "DATA_LOSS"
GrpcStatusFilter_Status_UNAUTHENTICATED:     "UNAUTHENTICATED"

#AccessLog: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.AccessLog"
	// The name of the access log extension configuration.
	name?: string
	// Filter which is used to determine if the access log needs to be written.
	filter?:       #AccessLogFilter
	typed_config?: _
}

// [#next-free-field: 14]
#AccessLogFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.AccessLogFilter"
	// Status code filter.
	status_code_filter?: #StatusCodeFilter
	// Duration filter.
	duration_filter?: #DurationFilter
	// Not health check filter.
	not_health_check_filter?: #NotHealthCheckFilter
	// Traceable filter.
	traceable_filter?: #TraceableFilter
	// Runtime filter.
	runtime_filter?: #RuntimeFilter
	// And filter.
	and_filter?: #AndFilter
	// Or filter.
	or_filter?: #OrFilter
	// Header filter.
	header_filter?: #HeaderFilter
	// Response flag filter.
	response_flag_filter?: #ResponseFlagFilter
	// gRPC status filter.
	grpc_status_filter?: #GrpcStatusFilter
	// Extension filter.
	// [#extension-category: envoy.access_loggers.extension_filters]
	extension_filter?: #ExtensionFilter
	// Metadata Filter
	metadata_filter?: #MetadataFilter
	// Log Type Filter
	log_type_filter?: #LogTypeFilter
}

// Filter on an integer comparison.
#ComparisonFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.ComparisonFilter"
	// Comparison operator.
	op?: #ComparisonFilter_Op
	// Value to compare against.
	value?: v3.#RuntimeUInt32
}

// Filters on HTTP response/status code.
#StatusCodeFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.StatusCodeFilter"
	// Comparison.
	comparison?: #ComparisonFilter
}

// Filters based on the duration of the request or stream, in milliseconds.
// For end of stream access logs, the total duration of the stream will be used.
// For :ref:`periodic access logs<arch_overview_access_log_periodic>`,
// the duration of the stream at the time of log recording will be used.
#DurationFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.DurationFilter"
	// Comparison.
	comparison?: #ComparisonFilter
}

// Filters for requests that are not health check requests. A health check
// request is marked by the health check filter.
#NotHealthCheckFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.NotHealthCheckFilter"
}

// Filters for requests that are traceable. See the tracing overview for more
// information on how a request becomes traceable.
#TraceableFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.TraceableFilter"
}

// Filters requests based on runtime-configurable sampling rates.
#RuntimeFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.RuntimeFilter"
	// Specifies a key used to look up a custom sampling rate from the runtime configuration. If a value is found for this
	// key, it will override the default sampling rate specified in “percent_sampled“.
	runtime_key?: string
	// Defines the default sampling percentage when no runtime override is present. If not specified, the default is
	// **0%** (with a denominator of 100).
	percent_sampled?: v31.#FractionalPercent
	// Controls how sampling decisions are made.
	//
	// - Default behavior (“false“):
	//
	//   - Uses the :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` as a consistent sampling pivot.
	//   - When :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` is present, sampling will be consistent
	//     across multiple hosts based on both the “runtime_key“ and
	//     :ref:`x-request-id<config_http_conn_man_headers_x-request-id>`.
	//   - Useful for tracking related requests across a distributed system.
	//
	// - When set to “true“ or :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` is missing:
	//
	//   - Sampling decisions are made randomly based only on the “runtime_key“.
	//   - Useful in complex filter configurations (like nested
	//     :ref:`AndFilter<envoy_v3_api_msg_config.accesslog.v3.AndFilter>`/
	//     :ref:`OrFilter<envoy_v3_api_msg_config.accesslog.v3.OrFilter>` blocks) where independent probability
	//     calculations are desired.
	//   - Can be used to implement logging kill switches with predictable probability distributions.
	use_independent_randomness?: bool
}

// Performs a logical “and” operation on the result of each filter in filters.
// Filters are evaluated sequentially and if one of them returns false, the
// filter returns false immediately.
#AndFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.AndFilter"
	filters?: [...#AccessLogFilter]
}

// Performs a logical “or” operation on the result of each individual filter.
// Filters are evaluated sequentially and if one of them returns true, the
// filter returns true immediately.
#OrFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.OrFilter"
	filters?: [...#AccessLogFilter]
}

// Filters requests based on the presence or value of a request header.
#HeaderFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.HeaderFilter"
	// Only requests with a header which matches the specified HeaderMatcher will
	// pass the filter check.
	header?: v32.#HeaderMatcher
}

// Filters requests that received responses with an Envoy response flag set.
// A list of the response flags can be found
// in the access log formatter
// :ref:`documentation<config_access_log_format_response_flags>`.
#ResponseFlagFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.ResponseFlagFilter"
	// Only responses with the any of the flags listed in this field will be
	// logged. This field is optional. If it is not specified, then any response
	// flag will pass the filter check.
	flags?: [...string]
}

// Filters gRPC requests based on their response status. If a gRPC status is not
// provided, the filter will infer the status from the HTTP status code.
#GrpcStatusFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.GrpcStatusFilter"
	// Logs only responses that have any one of the gRPC statuses in this field.
	statuses?: [...#GrpcStatusFilter_Status]
	// If included and set to true, the filter will instead block all responses
	// with a gRPC status or inferred gRPC status enumerated in statuses, and
	// allow all other responses.
	exclude?: bool
}

// Filters based on matching dynamic metadata.
// If the matcher path and key correspond to an existing key in dynamic
// metadata, the request is logged only if the matcher value is equal to the
// metadata value. If the matcher path and key *do not* correspond to an
// existing key in dynamic metadata, the request is logged only if
// match_if_key_not_found is "true" or unset.
#MetadataFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.MetadataFilter"
	// Matcher to check metadata for specified value. For example, to match on the
	// access_log_hint metadata, set the filter to "envoy.common" and the path to
	// "access_log_hint", and the value to "true".
	matcher?: v33.#MetadataMatcher
	// Default result if the key does not exist in dynamic metadata: if unset or
	// true, then log; if false, then don't log.
	match_if_key_not_found?: bool
}

// Filters based on access log type.
#LogTypeFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.LogTypeFilter"
	// Logs only records which their type is one of the types defined in this field.
	types?: [...v34.#AccessLogType]
	// If this field is set to true, the filter will instead block all records
	// with a access log type in types field, and allow all other records.
	exclude?: bool
}

// Extension filter is statically registered at runtime.
#ExtensionFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.ExtensionFilter"
	// The name of the filter implementation to instantiate. The name must
	// match a statically registered filter.
	name?:         string
	typed_config?: _
}
