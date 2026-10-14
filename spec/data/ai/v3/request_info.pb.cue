package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/ai/v3"
)

// Request attributes published as typed dynamic metadata by the :ref:`request info AI
// filter <envoy_v3_api_msg_extensions.http.ai_filters.request_info.v3.RequestInfo>`. Values are
// client-declared and unverified, apart from “estimated_input_tokens“, which Envoy computes.
// A value the client sent that Envoy cannot use, such as one of the wrong type, out of range,
// or a string over 256 bytes, is ignored.
// [#next-free-field: 8]
#RequestInfo: {
	"@type": "type.googleapis.com/envoy.data.ai.v3.RequestInfo"
	// The route's declared wire API. When unspecified, only ``model`` and ``stream`` are read.
	input_llm_protocol?: v3.#LLMProtocol
	// The requested model.
	model?: string
	// Whether a streamed response was requested.
	stream?: bool
	// The requested output token cap.
	max_output_tokens?: uint64
	// Number of messages in the conversation.
	message_count?: uint32
	// Number of tools declared.
	tool_count?: uint32
	// Envoy's estimate of the input tokens, published only when :ref:`token_estimation
	// <envoy_v3_api_field_extensions.http.ai_filters.request_info.v3.RequestInfo.token_estimation>`
	// is configured: ``ceil(tokens_per_byte * request payload bytes)``. A size heuristic, not a
	// tokenizer result, and independent of the wire API.
	estimated_input_tokens?: uint64
}
