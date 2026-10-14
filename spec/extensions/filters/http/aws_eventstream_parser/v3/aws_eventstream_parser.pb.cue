package v3

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#AwsEventstreamParser: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_eventstream_parser.v3.AwsEventstreamParser"
	// Rules for processing AWS EventStream response streams.
	response_rules?: #AwsEventstreamParser_ProcessingRules
}

// Metadata action to write when an EventStream header matches or is missing.
#AwsEventstreamParser_HeaderKeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_eventstream_parser.v3.AwsEventstreamParser_HeaderKeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	// Default: "envoy.filters.http.aws_eventstream_parser".
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// Optional: a fixed value to use instead of the header's actual value.
	// When set for on_present, uses this value instead of the header value.
	// Required for on_missing (since there is no header value available).
	value?: structpb.#Value
}

// A rule for extracting an EventStream message header to dynamic metadata.
#AwsEventstreamParser_HeaderRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_eventstream_parser.v3.AwsEventstreamParser_HeaderRule"
	// The EventStream header name to match. Case-sensitive.
	header_name?: string
	// If the header is present in a message, apply this metadata action.
	on_present?: #AwsEventstreamParser_HeaderKeyValuePair
	// If the header was not found in any message by end-of-stream, apply this metadata action.
	// The value field in the HeaderKeyValuePair must be set (since there is no header value).
	on_missing?: #AwsEventstreamParser_HeaderKeyValuePair
	// Controls how many times this rule should successfully match before stopping evaluation
	// of this rule for subsequent messages.
	//
	// - If set to 0 (default): This rule is evaluated against all messages.
	//   Later matches overwrite earlier values, effectively extracting the LAST occurrence.
	//
	// - If set to 1: Stop evaluating this rule after the first successful match.
	//   This is useful for extracting header values that appear early in the stream
	//   to avoid unnecessary processing of subsequent messages.
	//
	// - If set to N > 1: Reserved for future use. Values > 1 are currently rejected.
	//
	// When all header rules AND all content parser rules have stop_processing_after_matches
	// limits set and all limits are satisfied, the filter stops processing the stream entirely.
	stop_processing_after_matches?: uint32
}

// Rules for processing AWS EventStream streams and extracting metadata.
//
// The filter parses the AWS EventStream binary protocol (messages with headers and payloads),
// then delegates to a content parser to parse the message payload and extract metadata.
// The content parser determines which values to extract and how to write them to metadata.
#AwsEventstreamParser_ProcessingRules: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_eventstream_parser.v3.AwsEventstreamParser_ProcessingRules"
	// Content parser configuration for parsing message payloads and extracting metadata.
	//
	// The content parser specifies:
	// - How to parse the message payload (e.g., JSON, XML, plaintext)
	// - Which values to extract from the parsed content (e.g., JSON paths like usage.total_tokens)
	// - How to map extracted values to metadata (namespace, key, type conversions)
	// - When to write metadata (on_present, on_missing, on_error actions)
	// [#extension-category: envoy.content_parsers]
	content_parser?: v3.#TypedExtensionConfig
	// Rules for extracting EventStream message headers to dynamic metadata.
	// These are evaluated directly by the filter (not by the content parser).
	// Headers are simple typed key-value pairs at the EventStream protocol level.
	//
	// Header values are automatically converted to the appropriate Protobuf value type:
	// - BoolTrue/BoolFalse -> bool_value
	// - Byte/Short/Int32/Int64/Timestamp -> number_value
	// - String -> string_value
	// - ByteArray -> string_value (hex-encoded)
	// - UUID -> string_value (formatted as xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
	header_rules?: [...#AwsEventstreamParser_HeaderRule]
}
