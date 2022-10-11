package v2

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
	route "envoyproxy.io/api/v2/route"
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
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.AccessLog"
	// The name of the access log implementation to instantiate. The name must
	// match a statically registered access log. Current built-in loggers include:
	//
	// #. "envoy.access_loggers.file"
	// #. "envoy.access_loggers.http_grpc"
	// #. "envoy.access_loggers.tcp_grpc"
	name?: string
	// Filter which is used to determine if the access log needs to be written.
	filter?: #AccessLogFilter
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

// [#next-free-field: 12]
#AccessLogFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.AccessLogFilter"
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
	extension_filter?: #ExtensionFilter
}

// Filter on an integer comparison.
#ComparisonFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.ComparisonFilter"
	// Comparison operator.
	op?: #ComparisonFilter_Op
	// Value to compare against.
	value?: core.#RuntimeUInt32
}

// Filters on HTTP response/status code.
#StatusCodeFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.StatusCodeFilter"
	// Comparison.
	comparison?: #ComparisonFilter
}

// Filters on total request duration in milliseconds.
#DurationFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.DurationFilter"
	// Comparison.
	comparison?: #ComparisonFilter
}

// Filters for requests that are not health check requests. A health check
// request is marked by the health check filter.
#NotHealthCheckFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.NotHealthCheckFilter"
}

// Filters for requests that are traceable. See the tracing overview for more
// information on how a request becomes traceable.
#TraceableFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.TraceableFilter"
}

// Filters for random sampling of requests.
#RuntimeFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.RuntimeFilter"
	// Runtime key to get an optional overridden numerator for use in the *percent_sampled* field.
	// If found in runtime, this value will replace the default numerator.
	runtime_key?: string
	// The default sampling percentage. If not specified, defaults to 0% with denominator of 100.
	percent_sampled?: _type.#FractionalPercent
	// By default, sampling pivots on the header
	// :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` being present. If
	// :ref:`x-request-id<config_http_conn_man_headers_x-request-id>` is present, the filter will
	// consistently sample across multiple hosts based on the runtime key value and the value
	// extracted from :ref:`x-request-id<config_http_conn_man_headers_x-request-id>`. If it is
	// missing, or *use_independent_randomness* is set to true, the filter will randomly sample based
	// on the runtime key value alone. *use_independent_randomness* can be used for logging kill
	// switches within complex nested :ref:`AndFilter
	// <envoy_api_msg_config.filter.accesslog.v2.AndFilter>` and :ref:`OrFilter
	// <envoy_api_msg_config.filter.accesslog.v2.OrFilter>` blocks that are easier to reason about
	// from a probability perspective (i.e., setting to true will cause the filter to behave like
	// an independent random variable when composed within logical operator filters).
	use_independent_randomness?: bool
}

// Performs a logical “and” operation on the result of each filter in filters.
// Filters are evaluated sequentially and if one of them returns false, the
// filter returns false immediately.
#AndFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.AndFilter"
	filters?: [...#AccessLogFilter]
}

// Performs a logical “or” operation on the result of each individual filter.
// Filters are evaluated sequentially and if one of them returns true, the
// filter returns true immediately.
#OrFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.OrFilter"
	filters?: [...#AccessLogFilter]
}

// Filters requests based on the presence or value of a request header.
#HeaderFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.HeaderFilter"
	// Only requests with a header which matches the specified HeaderMatcher will pass the filter
	// check.
	header?: route.#HeaderMatcher
}

// Filters requests that received responses with an Envoy response flag set.
// A list of the response flags can be found
// in the access log formatter :ref:`documentation<config_access_log_format_response_flags>`.
#ResponseFlagFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.ResponseFlagFilter"
	// Only responses with the any of the flags listed in this field will be logged.
	// This field is optional. If it is not specified, then any response flag will pass
	// the filter check.
	flags?: [...string]
}

// Filters gRPC requests based on their response status. If a gRPC status is not provided, the
// filter will infer the status from the HTTP status code.
#GrpcStatusFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.GrpcStatusFilter"
	// Logs only responses that have any one of the gRPC statuses in this field.
	statuses?: [...#GrpcStatusFilter_Status]
	// If included and set to true, the filter will instead block all responses with a gRPC status or
	// inferred gRPC status enumerated in statuses, and allow all other responses.
	exclude?: bool
}

// Extension filter is statically registered at runtime.
#ExtensionFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.accesslog.v2.ExtensionFilter"
	// The name of the filter implementation to instantiate. The name must
	// match a statically registered filter.
	name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}
