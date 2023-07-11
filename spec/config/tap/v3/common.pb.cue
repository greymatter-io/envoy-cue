package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/common/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

// Output format. All output is in the form of one or more :ref:`TraceWrapper
// <envoy_v3_api_msg_data.tap.v3.TraceWrapper>` messages. This enumeration indicates
// how those messages are written. Note that not all sinks support all output formats. See
// individual sink documentation for more information.
#OutputSink_Format: "JSON_BODY_AS_BYTES" | "JSON_BODY_AS_STRING" | "PROTO_BINARY" | "PROTO_BINARY_LENGTH_DELIMITED" | "PROTO_TEXT"

OutputSink_Format_JSON_BODY_AS_BYTES:            "JSON_BODY_AS_BYTES"
OutputSink_Format_JSON_BODY_AS_STRING:           "JSON_BODY_AS_STRING"
OutputSink_Format_PROTO_BINARY:                  "PROTO_BINARY"
OutputSink_Format_PROTO_BINARY_LENGTH_DELIMITED: "PROTO_BINARY_LENGTH_DELIMITED"
OutputSink_Format_PROTO_TEXT:                    "PROTO_TEXT"

// Tap configuration.
#TapConfig: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.TapConfig"
	// The match configuration. If the configuration matches the data source being tapped, a tap will
	// occur, with the result written to the configured output.
	// Exactly one of :ref:`match <envoy_v3_api_field_config.tap.v3.TapConfig.match>` and
	// :ref:`match_config <envoy_v3_api_field_config.tap.v3.TapConfig.match_config>` must be set. If both
	// are set, the :ref:`match <envoy_v3_api_field_config.tap.v3.TapConfig.match>` will be used.
	//
	// Deprecated: Do not use.
	match_config?: #MatchPredicate
	// The match configuration. If the configuration matches the data source being tapped, a tap will
	// occur, with the result written to the configured output.
	// Exactly one of :ref:`match <envoy_v3_api_field_config.tap.v3.TapConfig.match>` and
	// :ref:`match_config <envoy_v3_api_field_config.tap.v3.TapConfig.match_config>` must be set. If both
	// are set, the :ref:`match <envoy_v3_api_field_config.tap.v3.TapConfig.match>` will be used.
	match?: v3.#MatchPredicate
	// The tap output configuration. If a match configuration matches a data source being tapped,
	// a tap will occur and the data will be written to the configured output.
	output_config?: #OutputConfig
	// [#not-implemented-hide:] Specify if Tap matching is enabled. The % of requests\connections for
	// which the tap matching is enabled. When not enabled, the request\connection will not be
	// recorded.
	//
	// .. note::
	//
	//   This field defaults to 100/:ref:`HUNDRED
	//   <envoy_v3_api_enum_type.v3.FractionalPercent.DenominatorType>`.
	tap_enabled?: v31.#RuntimeFractionalPercent
}

// Tap match configuration. This is a recursive structure which allows complex nested match
// configurations to be built using various logical operators.
// [#next-free-field: 11]
#MatchPredicate: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.MatchPredicate"
	// A set that describes a logical OR. If any member of the set matches, the match configuration
	// matches.
	or_match?: #MatchPredicate_MatchSet
	// A set that describes a logical AND. If all members of the set match, the match configuration
	// matches.
	and_match?: #MatchPredicate_MatchSet
	// A negation match. The match configuration will match if the negated match condition matches.
	not_match?: #MatchPredicate
	// The match configuration will always match.
	any_match?: bool
	// HTTP request headers match configuration.
	http_request_headers_match?: #HttpHeadersMatch
	// HTTP request trailers match configuration.
	http_request_trailers_match?: #HttpHeadersMatch
	// HTTP response headers match configuration.
	http_response_headers_match?: #HttpHeadersMatch
	// HTTP response trailers match configuration.
	http_response_trailers_match?: #HttpHeadersMatch
	// HTTP request generic body match configuration.
	http_request_generic_body_match?: #HttpGenericBodyMatch
	// HTTP response generic body match configuration.
	http_response_generic_body_match?: #HttpGenericBodyMatch
}

// HTTP headers match configuration.
#HttpHeadersMatch: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.HttpHeadersMatch"
	// HTTP headers to match.
	headers?: [...v32.#HeaderMatcher]
}

// HTTP generic body match configuration.
// List of text strings and hex strings to be located in HTTP body.
// All specified strings must be found in the HTTP body for positive match.
// The search may be limited to specified number of bytes from the body start.
//
// .. attention::
//
//   Searching for patterns in HTTP body is potentially cpu intensive. For each specified pattern, http body is scanned byte by byte to find a match.
//   If multiple patterns are specified, the process is repeated for each pattern. If location of a pattern is known, ``bytes_limit`` should be specified
//   to scan only part of the http body.
#HttpGenericBodyMatch: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.HttpGenericBodyMatch"
	// Limits search to specified number of bytes - default zero (no limit - match entire captured buffer).
	bytes_limit?: uint32
	// List of patterns to match.
	patterns?: [...#HttpGenericBodyMatch_GenericTextMatch]
}

// Tap output configuration.
#OutputConfig: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.OutputConfig"
	// Output sinks for tap data. Currently a single sink is allowed in the list. Once multiple
	// sink types are supported this constraint will be relaxed.
	sinks?: [...#OutputSink]
	// For buffered tapping, the maximum amount of received body that will be buffered prior to
	// truncation. If truncation occurs, the :ref:`truncated
	// <envoy_v3_api_field_data.tap.v3.Body.truncated>` field will be set. If not specified, the
	// default is 1KiB.
	max_buffered_rx_bytes?: uint32
	// For buffered tapping, the maximum amount of transmitted body that will be buffered prior to
	// truncation. If truncation occurs, the :ref:`truncated
	// <envoy_v3_api_field_data.tap.v3.Body.truncated>` field will be set. If not specified, the
	// default is 1KiB.
	max_buffered_tx_bytes?: uint32
	// Indicates whether taps produce a single buffered message per tap, or multiple streamed
	// messages per tap in the emitted :ref:`TraceWrapper
	// <envoy_v3_api_msg_data.tap.v3.TraceWrapper>` messages. Note that streamed tapping does not
	// mean that no buffering takes place. Buffering may be required if data is processed before a
	// match can be determined. See the HTTP tap filter :ref:`streaming
	// <config_http_filters_tap_streaming>` documentation for more information.
	streaming?: bool
}

// Tap output sink configuration.
// [#next-free-field: 6]
#OutputSink: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.OutputSink"
	// Sink output format.
	format?: #OutputSink_Format
	// Tap output will be streamed out the :http:post:`/tap` admin endpoint.
	//
	// .. attention::
	//
	//   It is only allowed to specify the streaming admin output sink if the tap is being
	//   configured from the :http:post:`/tap` admin endpoint. Thus, if an extension has
	//   been configured to receive tap configuration from some other source (e.g., static
	//   file, XDS, etc.) configuring the streaming admin output type will fail.
	streaming_admin?: #StreamingAdminSink
	// Tap output will be written to a file per tap sink.
	file_per_tap?: #FilePerTapSink
	// [#not-implemented-hide:]
	// GrpcService to stream data to. The format argument must be PROTO_BINARY.
	// [#comment: TODO(samflattery): remove cleanup in uber_per_filter.cc once implemented]
	streaming_grpc?: #StreamingGrpcSink
	// Tap output will be buffered in a single block before flushing to the :http:post:`/tap` admin endpoint
	//
	// .. attention::
	//
	//   It is only allowed to specify the buffered admin output sink if the tap is being
	//   configured from the :http:post:`/tap` admin endpoint. Thus, if an extension has
	//   been configured to receive tap configuration from some other source (e.g., static
	//   file, XDS, etc.) configuring the buffered admin output type will fail.
	buffered_admin?: #BufferedAdminSink
}

// Streaming admin sink configuration.
#StreamingAdminSink: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.StreamingAdminSink"
}

// BufferedAdminSink configures a tap output to collect traces without returning them until
// one of multiple criteria are satisfied.
// Similar to StreamingAdminSink, it is only allowed to specify the buffered admin output
// sink if the tap is being configured from the ``/tap`` admin endpoint.
#BufferedAdminSink: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.BufferedAdminSink"
	// Stop collecting traces when the specified number are collected.
	// If other criteria for ending collection are reached first, this value will not be used.
	max_traces?: uint64
	// Acts as a fallback to prevent the client from waiting for long periods of time.
	// After timeout has occurred, a buffer flush will be triggered, returning the traces buffered so far.
	// This may result in returning fewer traces than were requested, and in the case that no traces are
	// buffered during this time, no traces will be returned.
	// Specifying 0 for the timeout value (or not specifying a value at all) indicates an infinite timeout.
	timeout?: string
}

// The file per tap sink outputs a discrete file for every tapped stream.
#FilePerTapSink: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.FilePerTapSink"
	// Path prefix. The output file will be of the form <path_prefix>_<id>.pb, where <id> is an
	// identifier distinguishing the recorded trace for stream instances (the Envoy
	// connection ID, HTTP stream ID, etc.).
	path_prefix?: string
}

// [#not-implemented-hide:] Streaming gRPC sink configuration sends the taps to an external gRPC
// server.
#StreamingGrpcSink: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.StreamingGrpcSink"
	// Opaque identifier, that will be sent back to the streaming grpc server.
	tap_id?: string
	// The gRPC server that hosts the Tap Sink Service.
	grpc_service?: v31.#GrpcService
}

// A set of match configurations used for logical operations.
#MatchPredicate_MatchSet: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.MatchPredicate_MatchSet"
	// The list of rules that make up the set.
	rules?: [...#MatchPredicate]
}

#HttpGenericBodyMatch_GenericTextMatch: {
	"@type": "type.googleapis.com/envoy.config.tap.v3.HttpGenericBodyMatch_GenericTextMatch"
	// Text string to be located in HTTP body.
	string_match?: string
	// Sequence of bytes to be located in HTTP body.
	binary_match?: bytes
}
