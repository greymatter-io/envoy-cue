package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#SseToMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.sse_to_metadata.v3.SseToMetadata"
	// Rules for processing SSE response streams.
	response_rules?: #SseToMetadata_ProcessingRules
}

// Rules for processing SSE streams and extracting metadata.
//
// The filter parses the SSE protocol (events delimited by blank lines), then delegates
// to a content parser to parse event content and extract metadata. The content parser
// determines which values to extract and how to write them to metadata.
#SseToMetadata_ProcessingRules: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.sse_to_metadata.v3.SseToMetadata_ProcessingRules"
	// Content parser configuration for parsing event content and extracting metadata.
	//
	// The content parser specifies:
	// - How to parse the event data (e.g., JSON, XML, plaintext)
	// - Which values to extract from the parsed content (e.g., JSON paths like usage.total_tokens)
	// - How to map extracted values to metadata (namespace, key, type conversions)
	// - When to write metadata (on_present, on_missing, on_error actions)
	// [#extension-category: envoy.content_parsers]
	content_parser?: v3.#TypedExtensionConfig
	// Maximum size in bytes for a single SSE event before it's considered invalid
	// and discarded. This protects against unbounded memory growth from malicious
	// or malformed streams that never send event delimiters (blank lines).
	//
	// Default is 8192 bytes (8KB), which is sufficient for most legitimate events.
	// Set to 0 to disable the limit (not recommended for production).
	// Maximum allowed value is 10485760 bytes (10MB).
	max_event_size?: uint32
}
