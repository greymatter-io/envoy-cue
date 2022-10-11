package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
)

// A fully buffered HTTP trace message.
#HttpBufferedTrace: {
	"@type": "type.googleapis.com/envoy.data.tap.v2alpha.HttpBufferedTrace"
	// Request message.
	request?: #HttpBufferedTrace_Message
	// Response message.
	response?: #HttpBufferedTrace_Message
}

// A streamed HTTP trace segment. Multiple segments make up a full trace.
// [#next-free-field: 8]
#HttpStreamedTraceSegment: {
	"@type": "type.googleapis.com/envoy.data.tap.v2alpha.HttpStreamedTraceSegment"
	// Trace ID unique to the originating Envoy only. Trace IDs can repeat and should not be used
	// for long term stable uniqueness.
	trace_id?: uint64
	// Request headers.
	request_headers?: core.#HeaderMap
	// Request body chunk.
	request_body_chunk?: #Body
	// Request trailers.
	request_trailers?: core.#HeaderMap
	// Response headers.
	response_headers?: core.#HeaderMap
	// Response body chunk.
	response_body_chunk?: #Body
	// Response trailers.
	response_trailers?: core.#HeaderMap
}

// HTTP message wrapper.
#HttpBufferedTrace_Message: {
	"@type": "type.googleapis.com/envoy.data.tap.v2alpha.HttpBufferedTrace_Message"
	// Message headers.
	headers?: [...core.#HeaderValue]
	// Message body.
	body?: #Body
	// Message trailers.
	trailers?: [...core.#HeaderValue]
}
