package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// A fully buffered HTTP trace message.
#HttpBufferedTrace: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.HttpBufferedTrace"
	// Request message.
	request?: #HttpBufferedTrace_Message
	// Response message.
	response?: #HttpBufferedTrace_Message
}

// A streamed HTTP trace segment. Multiple segments make up a full trace.
// [#next-free-field: 8]
#HttpStreamedTraceSegment: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.HttpStreamedTraceSegment"
	// Trace ID unique to the originating Envoy only. Trace IDs can repeat and should not be used
	// for long term stable uniqueness.
	trace_id?: uint64
	// Request headers.
	request_headers?: v3.#HeaderMap
	// Request body chunk.
	request_body_chunk?: #Body
	// Request trailers.
	request_trailers?: v3.#HeaderMap
	// Response headers.
	response_headers?: v3.#HeaderMap
	// Response body chunk.
	response_body_chunk?: #Body
	// Response trailers.
	response_trailers?: v3.#HeaderMap
}

// HTTP message wrapper.
#HttpBufferedTrace_Message: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.HttpBufferedTrace_Message"
	// Message headers.
	headers?: [...v3.#HeaderValue]
	// Message body.
	body?: #Body
	// Message trailers.
	trailers?: [...v3.#HeaderValue]
}
