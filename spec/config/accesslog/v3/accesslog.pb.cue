package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v33 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

#ComparisonFilter_Op: "EQ" | "GE" | "LE"

ComparisonFilter_Op_EQ: "EQ"
ComparisonFilter_Op_GE: "GE"
ComparisonFilter_Op_LE: "LE"

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

// [#next-free-field: 13]
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

// Filters on total request duration in milliseconds.
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

// Filters for random sampling of requests.
#RuntimeFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.RuntimeFilter"
	// Runtime key to get an optional overridden numerator for use in the
	// ``percent_sampled`` field. If found in runtime, this value will replace the
	// default numerator.
	runtime_key?: string
	// The default sampling percentage. If not specified, defaults to 0% with
	// denominator of 100.
	percent_sampled?: v31.#FractionalPercent
	// By default, sampling pivots on the header
	// :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` being
	// present. If :ref:`x-request-id<config_http_conn_man_headers_x-request-id>`
	// is present, the filter will consistently sample across multiple hosts based
	// on the runtime key value and the value extracted from
	// :ref:`x-request-id<config_http_conn_man_headers_x-request-id>`. If it is
	// missing, or ``use_independent_randomness`` is set to true, the filter will
	// randomly sample based on the runtime key value alone.
	// ``use_independent_randomness`` can be used for logging kill switches within
	// complex nested :ref:`AndFilter
	// <envoy_v3_api_msg_config.accesslog.v3.AndFilter>` and :ref:`OrFilter
	// <envoy_v3_api_msg_config.accesslog.v3.OrFilter>` blocks that are easier to
	// reason about from a probability perspective (i.e., setting to true will
	// cause the filter to behave like an independent random variable when
	// composed within logical operator filters).
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

// Extension filter is statically registered at runtime.
#ExtensionFilter: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v3.ExtensionFilter"
	// The name of the filter implementation to instantiate. The name must
	// match a statically registered filter.
	name?:         string
	typed_config?: _
}
