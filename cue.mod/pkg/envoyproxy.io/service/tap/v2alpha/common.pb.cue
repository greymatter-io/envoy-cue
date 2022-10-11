package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
	route "envoyproxy.io/api/v2/route"
)

// Output format. All output is in the form of one or more :ref:`TraceWrapper
// <envoy_api_msg_data.tap.v2alpha.TraceWrapper>` messages. This enumeration indicates
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
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.TapConfig"
	// The match configuration. If the configuration matches the data source being tapped, a tap will
	// occur, with the result written to the configured output.
	match_config?: #MatchPredicate
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
	//   <envoy_api_enum_type.FractionalPercent.DenominatorType>`.
	tap_enabled?: core.#RuntimeFractionalPercent
}

// Tap match configuration. This is a recursive structure which allows complex nested match
// configurations to be built using various logical operators.
// [#next-free-field: 9]
#MatchPredicate: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.MatchPredicate"
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
}

// HTTP headers match configuration.
#HttpHeadersMatch: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.HttpHeadersMatch"
	// HTTP headers to match.
	headers?: [...route.#HeaderMatcher]
}

// Tap output configuration.
#OutputConfig: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.OutputConfig"
	// Output sinks for tap data. Currently a single sink is allowed in the list. Once multiple
	// sink types are supported this constraint will be relaxed.
	sinks?: [...#OutputSink]
	// For buffered tapping, the maximum amount of received body that will be buffered prior to
	// truncation. If truncation occurs, the :ref:`truncated
	// <envoy_api_field_data.tap.v2alpha.Body.truncated>` field will be set. If not specified, the
	// default is 1KiB.
	max_buffered_rx_bytes?: uint32
	// For buffered tapping, the maximum amount of transmitted body that will be buffered prior to
	// truncation. If truncation occurs, the :ref:`truncated
	// <envoy_api_field_data.tap.v2alpha.Body.truncated>` field will be set. If not specified, the
	// default is 1KiB.
	max_buffered_tx_bytes?: uint32
	// Indicates whether taps produce a single buffered message per tap, or multiple streamed
	// messages per tap in the emitted :ref:`TraceWrapper
	// <envoy_api_msg_data.tap.v2alpha.TraceWrapper>` messages. Note that streamed tapping does not
	// mean that no buffering takes place. Buffering may be required if data is processed before a
	// match can be determined. See the HTTP tap filter :ref:`streaming
	// <config_http_filters_tap_streaming>` documentation for more information.
	streaming?: bool
}

// Tap output sink configuration.
#OutputSink: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.OutputSink"
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
	streaming_grpc?: #StreamingGrpcSink
}

// Streaming admin sink configuration.
#StreamingAdminSink: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.StreamingAdminSink"
}

// The file per tap sink outputs a discrete file for every tapped stream.
#FilePerTapSink: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.FilePerTapSink"
	// Path prefix. The output file will be of the form <path_prefix>_<id>.pb, where <id> is an
	// identifier distinguishing the recorded trace for stream instances (the Envoy
	// connection ID, HTTP stream ID, etc.).
	path_prefix?: string
}

// [#not-implemented-hide:] Streaming gRPC sink configuration sends the taps to an external gRPC
// server.
#StreamingGrpcSink: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.StreamingGrpcSink"
	// Opaque identifier, that will be sent back to the streaming grpc server.
	tap_id?: string
	// The gRPC server that hosts the Tap Sink Service.
	grpc_service?: core.#GrpcService
}

// A set of match configurations used for logical operations.
#MatchPredicate_MatchSet: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.MatchPredicate_MatchSet"
	// The list of rules that make up the set.
	rules?: [...#MatchPredicate]
}
